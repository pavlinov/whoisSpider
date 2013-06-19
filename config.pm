=head1 NAME

config

=head1 DESCRIPTION 

Config module

=head1 AUTHORS

Alexey Pavlinoff <alexey@pavlinoff.com>

=cut
package config;

use strict;
use Exporter;
use File::Basename qw(dirname);
use vars qw(@ISA @EXPORT);
@ISA = qw(Exporter);

@EXPORT = qw(DEBUG LOG LOGPATH LOGNAME DBHOST DBNAME DBUSER DBPASS THREADS SERVERWHOIS TLD);

use constant DBHOST => "localhost";
use constant DBNAME => "dataSpider";
use constant DBUSER => "spider";
use constant DBPASS => "!vfD5fg";

use constant SERVERWHOIS => "";

use constant TLD => ".com";

use constant THREADS => 3; # concurrent number of Whois-queries per minute 

use constant DEBUG => "1"; # print debug messages
use constant LOG   => "0"; # logging
use constant LOGPATH => dirname(__FILE__) . "/logs/";
use constant LOGNAME => "whoisSpider";

1;

=head1 CONSTANTS

	You can set following constants

	Database credentials
		DBHOST      => "localhost";
		DBNAME      => "dataSpider";
		DBUSER      => "spider";
		DBPASS      => "!vfD5fg";
		
	Set whois server if this var is unset use dafelut server for zone
		SERVERWHOIS => "whois.ripn.net";
		
		TLD         => ".com";
		
	Concurrent number of Whois-queries per minute
		THREADS     => 15; 
		
	Print debug messages
		DEBUG       => "0";

	Logging on/off
		LOG         => "0";
		LOGPATH     => dirname(__FILE__) . "/logs/";
		LOGNAME     => "whoisSpider";

=cut

