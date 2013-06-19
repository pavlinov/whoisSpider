/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
/*GRANT SELECT, INSERT, UPDATE, DELETE, INDEX, ALTER, CREATE, LOCK TABLES, CREATE TEMPORARY TABLES, DROP, REFERENCES ON dataSpider.* TO spider@localhost IDENTIFIED BY '!vfD5fg';*/
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
INSERT INTO `domains` VALUES (2,'yandex.ru','.ru');
INSERT INTO `domains` VALUES (3,'rambler.ru','.ru');
INSERT INTO `domains` VALUES (4,'meta.ua','.ua');
INSERT INTO `domains` VALUES (5,'graphis.org.ua','.org.ua');
INSERT INTO `domains` VALUES (6,'telegraph.co.uk','.co.uk');
INSERT INTO `domains` VALUES (9,'Ð¡ÐµÐºÑ.Ð Ð¤','.Ñ€Ñ„');
INSERT INTO `domains` VALUES (8,'Ð¿Ñ€ÐµÐ·Ð¸Ð´ÐµÐ½Ñ‚.Ñ€Ñ„','.Ñ€Ñ„');
INSERT INTO `domains` VALUES (10,'my-test-domain.test','.test');
INSERT INTO `domains` VALUES (11,'opennet.ru','.ru');
INSERT INTO `domains` VALUES (12,'habrahabr.ru','.ru');
INSERT INTO `domains` VALUES (13,'reg.ru','.ru');
INSERT INTO `domains` VALUES (14,'warez.ru','.ru');
INSERT INTO `domains` VALUES (15,'trinixy.ru','.ru');
INSERT INTO `domains` VALUES (16,'webpark.ru','.ru');
INSERT INTO `domains` VALUES (17,'bugaga.ru','.ru');
INSERT INTO `domains` VALUES (18,'nefart.ru','.ru');
INSERT INTO `domains` VALUES (19,'dwg.ru','.ru');
INSERT INTO `domains` VALUES (20,'sql.ru','.ru');
INSERT INTO `domains` VALUES (21,'popmech.ru','.ru');
INSERT INTO `domains` VALUES (22,'securitylab.ru','.ru');
INSERT INTO `domains` VALUES (23,'drweb.ru','.ru');
INSERT INTO `domains` VALUES (24,'kaspersky.ru','.ru');
INSERT INTO `domains` VALUES (25,'nod.ru','.ru');
INSERT INTO `domains` VALUES (26,'papa.ru','.ru');
INSERT INTO `domains` VALUES (27,'mama.ru','.ru');
INSERT INTO `domains` VALUES (28,'sex.ru','.ru');
INSERT INTO `domains` VALUES (29,'codenet.ru','.ru');
INSERT INTO `domains` VALUES (30,'pereplet.ru','.ru');
INSERT INTO `domains` VALUES (31,'odnoklassniki.ru','.ru');
INSERT INTO `domains` VALUES (32,'vkontakte.ru','.ru');
INSERT INTO `domains` VALUES (33,'kroshka.ru','.ru');
INSERT INTO `domains` VALUES (34,'bla-bla.ru','.ru');
INSERT INTO `domains` VALUES (35,'majordomo.ru','.ru');
INSERT INTO `domains` VALUES (36,'xpoint.ru','.ru');
INSERT INTO `domains` VALUES (37,'npksv.ru','.ru');
INSERT INTO `domains` VALUES (38,'i2r.ru','.ru');
INSERT INTO `domains` VALUES (39,'seasonvar.ru','.ru');
INSERT INTO `domains` VALUES (40,'kino-teatr.ru','.ru');
INSERT INTO `domains` VALUES (41,'ucoz.ru','.ru');
INSERT INTO `domains` VALUES (42,'kinokadr.ru','.ru');
INSERT INTO `domains` VALUES (43,'lurkmore.ru','.ru');
INSERT INTO `domains` VALUES (44,'filmz.ru','.ru');
INSERT INTO `domains` VALUES (45,'KinoNews.ru','.ru');
INSERT INTO `domains` VALUES (46,'online-new-films.ru','.ru');
INSERT INTO `domains` VALUES (47,'berkino.ru','.ru');
INSERT INTO `domains` VALUES (48,'film.ru','.ru');
INSERT INTO `domains` VALUES (49,'twilight-saga.ru','.ru');
INSERT INTO `domains` VALUES (50,'kinoreys.ru','.ru');
INSERT INTO `domains` VALUES (51,'film-sumerki4rassvet.ru','.ru');
INSERT INTO `domains` VALUES (52,'1kinotv.ru','.ru');
INSERT INTO `domains` VALUES (53,'ruskino.ru','.ru');
INSERT INTO `domains` VALUES (54,'kinotvonline.ru','.ru');
INSERT INTO `domains` VALUES (55,'kinovisit.ru','.ru');
INSERT INTO `domains` VALUES (56,'onlymults.ru','.ru');
INSERT INTO `domains` VALUES (57,'mobipres.ru','.ru');
INSERT INTO `domains` VALUES (58,'tvcok.ru','.ru');
INSERT INTO `domains` VALUES (59,'boi-s-teniy3-online.ru','.ru');
INSERT INTO `domains` VALUES (60,'filmopoisk.ru','.ru');
INSERT INTO `domains` VALUES (61,'bigbang-tv.ru','.ru');
INSERT INTO `domains` VALUES (62,'multfilmchik.ru','.ru');
INSERT INTO `domains` VALUES (63,'eaon.ru','.ru');
INSERT INTO `domains` VALUES (64,'tv-shows.ru','.ru');
INSERT INTO `domains` VALUES (65,'kinokorol.ru','.ru');
INSERT INTO `domains` VALUES (66,'kfiles.ru','.ru');
INSERT INTO `domains` VALUES (67,'kino.ru','.ru');
INSERT INTO `domains` VALUES (68,'bitkino.ru','.ru');
INSERT INTO `domains` VALUES (69,'onkuno.ru','.ru');
INSERT INTO `domains` VALUES (70,'vam-dar.ru','.ru');
INSERT INTO `domains` VALUES (71,'letitbit-movie.ru','.ru');
INSERT INTO `domains` VALUES (72,'cinemaking.ru','.ru');
INSERT INTO `domains` VALUES (73,'jeans.ru','.ru');
INSERT INTO `domains` VALUES (74,'google.com','.com');
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
