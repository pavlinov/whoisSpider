#!/usr/bin/perl -w 
=head1 NAME

whois_db.pl


=head1 USAGE

Usage: perl whois_db.pl

Before using you can configure script in config.pm                                                                                                                                 

=head1 DESCRIPTION

Script for grabbing whois-info to the database

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

use strict;
use warnings;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use config;
use Core::Database;
use Core::Punycode;
use Core::WhoisUtil;

=head1 VERSION

version 0.02

=cut

our $VERSION = '0.02';

main();

exit 0;

=head1 METHODS

=head2 main

Does all main work

=cut

sub main {
	my $dbObject = new Core::Database;
	$dbObject->setDSN(
		'dbName' => DBNAME,
		'dbUser' => DBUSER,
		'dbPass' => DBPASS);
	
	my $domainList = $dbObject->getDomainsList();
	exit 1 if $dbObject->getError();
	
	my $punycodeObject = new Core::Punycode;
	my $whoisObject    = new Core::WhoisUtil;
	$whoisObject->setWhoisServer(SERVERWHOIS);
	
	foreach my $domain (keys %$domainList)
	{
		my $realDomainName = $punycodeObject->getRealName($domain);
		my $whoisResponse = $whoisObject->getWhoisInfo($realDomainName);
		exit 1 if (!$dbObject->saveWhoisInfo($whoisResponse, $domainList->{$domain}))
	}

	return 1;
}
