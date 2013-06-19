=head1 NAME                                                                                                                                                                        

Core::Punycode

=head1 DESCRIPTION

Class for encode domain name to Punycode in compliance with the RFC 3492

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

package Core::Punycode;

use strict;
use locale;
use URI::UTF8::Punycode;
use Core::BaseObject;
use vars qw(@ISA);
@ISA = qw(Core::BaseObject);

=head1 VERSION

version 0.02

=cut

our $VERSION = '0.02';

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

=head2 getRealName

	Function for getting encoded domain name

	Arguments (required):
		domain - string. For example: 'Президент.рФ'

	Return Value:
		encodedDomain - string, encoded domain name in the Punycode. For example: 'xn--d1abbgf6aiiy.xn--p1ai'

=cut

sub getRealName {
	my ($self) = shift;
	my ($domain) = @_;

	$self->debug("In the getRealName");
	$self->debug("Original Domain Name: " . $domain);

	# If domain name in English, then exit from function
	if($domain =~ m/[a-zA-Z0-9-]/sgo){
		return lc $domain;
	}

	my (@newName);
	# Hack for support lc on Unicode
	$domain = pack 'U0C*', unpack 'C*', $domain;
	foreach my $key (split '\.', lc($domain) ) {
		$key = puny_enc($key);
		$key = pack 'C*', unpack 'C0C*', $key;
		push(@newName,$key);
	}

	my $encodedDomain = join '.', @newName;
	$self->debug("Encoded Domain Name ::: ",$encodedDomain);

	return $encodedDomain;
}

1;

