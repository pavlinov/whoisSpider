#####################
# Whois spider test #
####### Whois #######

use strict;
use config;
use warnings;
use lib qw(..);
use Test::More;

BEGIN {
	use_ok('Core::Punycode');
	use_ok('Core::WhoisUtil');
	use_ok('Core::Database');
	use_ok('Core::BaseObject');
	use_ok('URI::UTF8::Punycode');
	use_ok('Net::Whois::Raw');
}

can_ok('Core::BaseObject', qw(new debug getError dumpVar setError debugMode));
can_ok('Core::Database',   qw(new getDomainsList saveWhoisInfo));
can_ok('Core::Punycode',   qw(new getRealName));
can_ok('Core::WhoisUtil',  qw(new getWhoisInfo));

my $baseObject = new Core::BaseObject;
isa_ok($baseObject, "Core::BaseObject");
$baseObject->debug("="x35 . " NEW " . "="x35);

my $whoisObject = new Core::WhoisUtil;
isa_ok($whoisObject, "Core::WhoisUtil");

my $dbObject = new Core::Database;
isa_ok($dbObject, "Core::Database");

my $punycodeObject = new Core::Punycode;
isa_ok($punycodeObject, "Core::Punycode");

compile();

done_testing();

sub compile {
	my ($file) = 'whois.pl';

	my $output = `perl -wc $file 2>&1`;
	chomp($output);

	my $return_val = $?;

	$output =~ s/^\Q$file\E syntax OK$//ms;
	diag($output) if $output;
	ok(!$return_val, $file) or diag('--ERROR');

	return 1;
}

