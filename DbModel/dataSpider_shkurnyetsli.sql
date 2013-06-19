/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  `tld` varchar(45) NOT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `Domain_UNIQUE` (`domain`),
  UNIQUE KEY `DomainID_UNIQUE` (`domain_id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `domains` VALUES (1,'render.ru','.ru');

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whois_data` (
  `whois_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `info` text,
  `sync_date` datetime DEFAULT NULL,
  `domain_id` int(11) NOT NULL,
  PRIMARY KEY (`whois_data_id`),
  UNIQUE KEY `WhoisDataID_UNIQUE` (`whois_data_id`),
  KEY `fk_WHOISDATA_DOMAINS` (`domain_id`)
) ENGINE=MyISAM AUTO_INCREMENT=669 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
