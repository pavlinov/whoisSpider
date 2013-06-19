whoisSpider
===========

WhoisSpider is a multi-threaded application on Perl allowing to scan whois for domains and save data into database

Main app is whois_threads.pl
Before using please fill the `domains` table in the database

Usage:
     bash> perl whois_threads.pl

Configuring in config.pm:
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

Database structure (more info please see in ./DbModel):
    mysql> desc domains;
    +-----------+--------------+------+-----+---------+----------------+
    | Field     | Type         | Null | Key | Default | Extra          |
    +-----------+--------------+------+-----+---------+----------------+
    | domain_id | int(11)      | NO   | PRI | NULL    | auto_increment |
    | domain    | varchar(255) | NO   | UNI | NULL    |                |
    | tld       | varchar(45)  | NO   |     | NULL    |                |
    +-----------+--------------+------+-----+---------+----------------+
    3 rows in set (0.00 sec)
    
    mysql> desc whois_data;
    +---------------+----------+------+-----+---------+----------------+
    | Field         | Type     | Null | Key | Default | Extra          |
    +---------------+----------+------+-----+---------+----------------+
    | whois_data_id | int(11)  | NO   | PRI | NULL    | auto_increment |
    | info          | text     | YES  |     | NULL    |                |
    | sync_date     | datetime | YES  |     | NULL    |                |
    | domain_id     | int(11)  | NO   | MUL | NULL    |                |
    +---------------+----------+------+-----+---------+----------------+
    4 rows in set (0.00 sec)
