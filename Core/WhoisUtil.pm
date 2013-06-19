=head1 NAME                                                                                                                                                                        

Core::WhoisUtil

=head1 DESCRIPTION

Class for getting the whois information

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut
package Core::WhoisUtil;

use strict;
use warnings;
use Net::Whois::Raw;
use Core::BaseObject;
use vars qw(@ISA);
@ISA = qw(Core::BaseObject);


=head1 VERSION

version 0.02

=cut

our $VERSION='0.02';

=head2 new

	Constructor

=cut

sub new {
	my ($proto) = shift;
	my ($class) = ref($proto) || $proto;
	my ($self)  = $class->SUPER::new(@_);

	bless ($self, $class);

	return $self;
}

=head2 getWhoisInfo

	Function for get whois info from whois servers

	Arguments (required):
		domain - string

	Return Value:
		result - whois information

=cut

sub getWhoisInfo {
	my ($self) = shift;
	my ($domain) = @_;

	$self->debug("In the getWhoisInfo");
	$self->debug("Getting whois info for domain: " . $domain);

	my $result;
	eval {
		my $responseFirstPart = get_whois($domain, $self->{"SERVERWHOIS"},
			'QRY_FIRST');
		my $responseSecondPart = get_whois($domain, $self->{"SERVERWHOIS"},
			'QRY_LAST');

		$result = $responseFirstPart;
		if ($responseFirstPart ne $responseSecondPart){
			$result .= $responseSecondPart;
		}
		$self->debug("response=" . $result);
	};

	if ($@) {
		$self->setError("Can't get whois information");
		return undef;
	}

	$self->debug("WhoisInfo got succesfully");
	return $result;
}

=head2 setWhoisServer

	Set defult Whois server

	Arguments (required):
		server - string

=cut

sub setWhoisServer {
	my ($self) = shift;
	my ($server) = (@_);

	$self->debug("In the setWhoisServer");
	$self->debug("Whois Server: " . $server);

	($self->{"SERVERWHOIS"}) = $server;

	return 1;
}

1;

