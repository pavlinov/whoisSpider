#######################
# Whois get info test #
######## Whois ########

use strict;
use config;
use warnings;
use lib qw(..);
use Test::More;

BEGIN {
	use_ok('Core::WhoisUtil');
	use_ok('Net::Whois::Raw');
}

can_ok('Core::WhoisUtil',  qw(new getWhoisInfo));

my $whoisObject = new Core::WhoisUtil;
isa_ok($whoisObject, "Core::WhoisUtil");

whoisInfoGet($whoisObject);

done_testing();

sub whoisInfoGet {
	my ($whoisObject) = @_; 
	ok($whoisObject->getWhoisInfo('example.com') =~ (m/Creation Date: 14-aug-1995/go), "Get Whois info: example.com") or diag('--ERROR');
	return 1;
}

