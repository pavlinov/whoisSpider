#!/usr/bin/perl -w 
=head1 NAME

whois.pl


=head1 USAGE

cat domain.list | perl whois.pl

Before using you can configure script in config.pm                                                                                                                                 

=head1 DESCRIPTION

Script for grabbing whois-info

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

use strict;
use warnings;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use config;
use Core::Punycode;
use Core::WhoisUtil;

our $VERSION = '0.02';

while (<>) {
	chomp;
	my $domain = $_;
	my $punycodeObject = new Core::Punycode;
	my $whoisObject    = new Core::WhoisUtil;
	$whoisObject->setWhoisServer(SERVERWHOIS);

	my $realDomainName = $punycodeObject->getRealName($domain);
	my $whoisResponse = $whoisObject->getWhoisInfo($realDomainName);
	unless ($whoisResponse) {
		print "WHOIS ERROR: " . $whoisObject->getError();
		next;
	}

	print $whoisResponse;
}

exit 0;
