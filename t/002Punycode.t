#################
# Punycode test #
##### Whois #####

use strict;
use config;
use warnings;
use lib qw(..);
use Test::More;

BEGIN {
	use_ok('Core::Punycode');
	use_ok('URI::UTF8::Punycode');
}

can_ok('Core::Punycode',   qw(new getRealName));

my $punycodeObject = new Core::Punycode;
isa_ok($punycodeObject, "Core::Punycode");

punycodeEncode($punycodeObject);

done_testing();

sub punycodeEncode {
	my ($punyObject) = @_;
	ok($punyObject->getRealName('ПрезиДент.Рф') eq 'xn--d1abbgf6aiiy.xn--p1ai', "Punycode test") or diag('--ERROR');
	return 1;
}

