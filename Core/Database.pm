=head1NAME

Core::Database

=head1 DESCRIPTION

Class for working with database

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

package Core::Database;

use strict;
use DBI;
use Core::BaseObject;
use vars qw(@ISA);
@ISA = qw(Core::BaseObject);

=head1 VERSION

version 0.02

=cut

our $VERSION = '0.02';

=head1 METHODS
                                                                                                                                                                                   
=head2 new

	Constructor of the DB object

=cut

sub new {
	my ($proto) = shift;
	my ($class) = ref($proto) || $proto;
	my ($self)  = $class->SUPER::new(@_);

	bless ($self, $class);

	$self->{"DBH"} = undef;

	return $self
}

=head2 setDSN

	Set data source name
	Arguments (required):
		dbHost - database host
		dbName - database name
		dbUser - database user name
		dbPass - database password

=cut

sub setDSN {
	my ($self) = shift;
	my (%param) = @_;

	$self->debug("In the setDSN");
	$self->dumpVar(\%param);

	$self->{"DBHOST"} = $param{'dbHost'} || 'localhost';
	$self->{"DBNAME"} = $param{'dbName'};
	$self->{"DBUSER"} = $param{'dbUser'};
	$self->{"DBPASS"} = $param{'dbPass'};

	return 1;
}

=head2 _getDatabase

	Get databases handler

=cut

sub _getDatabase {
	my ($self) = shift;

	$self->debug("In the _getDatabase");

	if (defined($self->{"DBH"})) {
		if ($self->{"DBH"}->ping()) {  
			return $self->{"DBH"};
		}

		$self->debug("Connection lost, reconnecting...");
	}

	my (@dsn) = ("DBI:mysql:" . $self->{DBNAME} . ":" . $self->{DBHOST},
		$self->{DBUSER}, $self->{DBPASS});
	$self->dumpVar(@dsn);

	my ($dbh);
	$dbh = DBI->connect(@dsn, {RaiseError => 0});
	unless ($dbh) {
		$self->setError("DB CONNECT IS FAILED");
		return undef;
	}
	$self->debug("Connected successfully");

	$dbh->do("set character set utf8");
	$dbh->do("set names utf8");

	$self->{"DBH"} = $dbh;
	return $self->{"DBH"};
}

=head2 _closeDatabase

	Close databases handler

=cut

sub _closeDatabase {
	my ($self) = shift;

	$self->debug("In the _closeDatabase");

	return undef unless ($self->{"DBH"});

	$self->debug("Closing database connection");
	$self->{"DBH"}->disconnect();
	$self->{"DBH"} = undef;

	return 1;
}

=head2 getDomainsList

	Function for getting domains list from the db

	Arguments (no required):
		tld - top level domain. For example '.com'

	Return Value:
		HASH as following: domain_name => domain_id

=cut

sub getDomainsList {
	my $self = shift;
	my ($tld) = @_;

	$self->debug("In the getDomainsList");

	$tld = '.ru' unless $tld;

	my $db = $self->_getDatabase();

	my $quotedTld = $db->quote($tld);

	my $query = qq { SELECT `domain`, `domain_id` FROM `domains` WHERE `tld` =  $quotedTld };
	
	$self->debug("Query: " . $query);
	
	my ($res) = $db->selectcol_arrayref($query, {Columns => [1,2]});
	
	if ($db->err || !(scalar @$res)) {
		$self->setError($db->err ? "DB ERROR: " . $db->errstr 
			: "DOMAINS NOT FOUND");
		return undef;
	}

	my (%dHash) = @$res;
	$self->dumpVar(\%dHash);

	$self->_closeDatabase();

	return \%dHash;
}

=head2 saveWhoisInfo

	Frunction for saveing whois ifo in the db

	Arguments(required):
		info     - string with whois information
		domainId - domain ID

=cut

sub saveWhoisInfo {
	my ($self) = shift;
	my ($info, $domainId) = @_;

	$self->debug("In the saveWhoisInfo");
	$self->debug("$info, $domainId");

	my $db = $self->_getDatabase();

	my $query = qq {
			INSERT `whois_data` (`sync_date`,`info`, `domain_id`) 
			VALUES (NOW(), ?, ?)
		};

	$self->debug("Query: " . $query);

	my $s;
	if (!($s = $db->prepare($query)) || !$s->execute($info, $domainId)) {
		$self->setError("ERROR IN INSERT QUERY saveWhoisInfo: " . $db->errstr);
		return undef;
	}

	$self->_closeDatabase();

	$self->debug("WhoisInfo has been saved successfully");

	return 1;
}

1;

