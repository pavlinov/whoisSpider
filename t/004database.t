#################
# Database test #
##### Whois #####

use strict;
use config;
use warnings;
use lib qw(..);
use Test::More;

BEGIN {
	use_ok('Core::Database');
}

can_ok('Core::Database',   qw(new getDomainsList saveWhoisInfo));

my $dbObject = new Core::Database;
isa_ok($dbObject, "Core::Database");
ok($dbObject->setDSN('dbName' => DBNAME, 'dbUser' => DBUSER, 'dbPass' => DBPASS) eq 1, 'setDSN test') or diag('--ERROR');

dbTest($dbObject);

done_testing();

sub dbTest {
	my ($dbObject) = @_;

	ok(ref ($dbObject->getDomainsList(TLD)) eq 'HASH', "Database get domains list test") or diag('--ERROR');

	ok($dbObject->saveWhoisInfo('THIS IS TEST TEST TEST WHOIS INFO', '10') eq 1, "Database insert test info") or diag('--ERROR');

	return 1;
}

