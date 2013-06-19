#!/usr/bin/perl -w 
=head1 NAME

whois_threads.pl


=head1 USAGE

Usage: perl whois_threads.pl

Before using you can configure script in config.pm

=head1 DESCRIPTION

Script for grabbing whois-info to the database in multiple threads

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut

$|=1;

use strict;
use warnings;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use config;
use Core::Database;
use Core::Punycode;
use Core::WhoisUtil;
use Core::BaseObject;
use threads;

=head1 VERSION

version 0.02

=cut

our $VERSION = '0.02';

main();

exit 0;

=head1 METHODS

=head2 B<main()>

Does a main work

=cut

sub main {
	my @threads;
	
	my $forDebug = new Core::BaseObject;
	my $dbObj = new Core::Database;
	$dbObj->setDSN(
		'dbName' => DBNAME,
		'dbUser' => DBUSER,
		'dbPass' => DBPASS);
	
	my ($domainList) = $dbObj->getDomainsList(TLD);
	exit 1 if $dbObj->getError();
	
	my $i = 0;
	foreach my $domain (keys %$domainList) {
		my $startTime = time(); 
	
		push @threads, threads->create(\&_doSync, $domain, $domainList->{$domain});
		$i++;
	
		# Await the completion of threads
		if (($i % THREADS) == 0) {
			foreach my $thread (@threads) {
				$thread->join();
			}
	
			@threads = ();
	
			my $runTime = (time() - $startTime);
			if ($runTime < 59) {
				$forDebug->debug("Wait (" . scalar(localtime()) . "): " . (59 - $runTime));
				sleep(59 - $runTime);
			}
		}
	}
	
	# Await the completion of the last threads
	foreach my $thread (@threads) {
		$thread->join();
	}
}
exit;

=head2 B<_doSync()>

Get Whois-info and save in the database.

=over

=item Arguments (I<no required>):

=over 12

=item C<domain>

domain name

=item C<domainId>

domain id from database

=back

=back

=cut

sub _doSync {
	my ($domain, $domainId) = @_;
	
	my $dbObject = new Core::Database;
	$dbObject->setDSN(
	    'dbName' => DBNAME, 
	    'dbUser' => DBUSER,
	    'dbPass' => DBPASS);

	my $punycodeObject = new Core::Punycode;

	my $whoisObject    = new Core::WhoisUtil;
	$whoisObject->setWhoisServer(SERVERWHOIS);
	
	my $realDomainName = $punycodeObject->getRealName($domain);
	my $whoisResponse = $whoisObject->getWhoisInfo($realDomainName);
	$dbObject->saveWhoisInfo($whoisResponse, $domainId);
	#if($whoisResponse =~ /^\s*Registrar\:\s+(.*)/mgi)
	#{
	#	$dbObject->saveWhoisInfo($1, $domainId);
	#}
	#elsif($whoisResponse =~ /^\s*Sponsoring Registrar\:\s*(.*)/mgi)
	#{
	#	$dbObject->saveWhoisInfo($1, $domainId);
	#}

	return 1;
}
