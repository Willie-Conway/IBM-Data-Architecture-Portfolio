-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: finhub
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_type`
--

DROP TABLE IF EXISTS `account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_type` (
  `ID` int DEFAULT NULL,
  `AccountType` varchar(100) DEFAULT NULL,
  UNIQUE KEY `AccountType_UNIQUE` (`AccountType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `BranchCode` varchar(100) DEFAULT NULL,
  `BranchName` text,
  UNIQUE KEY `BranchCode_UNIQUE` (`BranchCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `CountryID` int DEFAULT NULL,
  `CountryName` varchar(100) DEFAULT NULL,
  `CountryCode` text,
  `Continent` text,
  UNIQUE KEY `CountryName_UNIQUE` (`CountryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_data`
--

DROP TABLE IF EXISTS `customer_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_data` (
  `CustomerID` int DEFAULT NULL,
  `CustomerName` text,
  `Email` text,
  `DateOfBirth` text,
  `AccountId` varchar(100) DEFAULT NULL,
  `AccountType` varchar(100) DEFAULT NULL,
  `BranchCode` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `DateJoined` text,
  `Balance` int DEFAULT NULL,
  UNIQUE KEY `AccountId_UNIQUE` (`AccountId`),
  KEY `actype_idx` (`AccountType`),
  KEY `bcode_idx` (`BranchCode`),
  KEY `ctry_idx` (`Country`),
  CONSTRAINT `actype` FOREIGN KEY (`AccountType`) REFERENCES `account_type` (`AccountType`),
  CONSTRAINT `bcode` FOREIGN KEY (`BranchCode`) REFERENCES `branches` (`BranchCode`),
  CONSTRAINT `ctry` FOREIGN KEY (`Country`) REFERENCES `countries` (`CountryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_data`
--

DROP TABLE IF EXISTS `transaction_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_data` (
  `TransactionID` int DEFAULT NULL,
  `AccountId` varchar(100) DEFAULT NULL,
  `TransactionDate` text,
  `TransactionType` text,
  `TransactionAmount` int DEFAULT NULL,
  `TransactionLocation` varchar(100) DEFAULT NULL,
  KEY `LOC_idx` (`TransactionLocation`),
  KEY `acct_idx` (`AccountId`),
  CONSTRAINT `acct` FOREIGN KEY (`AccountId`) REFERENCES `customer_data` (`AccountId`),
  CONSTRAINT `LOC` FOREIGN KEY (`TransactionLocation`) REFERENCES `us_cities` (`CityName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `us_cities`
--

DROP TABLE IF EXISTS `us_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `us_cities` (
  `Id` int DEFAULT NULL,
  `CityCode` text,
  `CityName` varchar(100) DEFAULT NULL,
  UNIQUE KEY `CityName_UNIQUE` (`CityName`),
  KEY `idx` (`CityName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-05 15:49:53



-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: finhub
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `account_type`
--

LOCK TABLES `account_type` WRITE;
/*!40000 ALTER TABLE `account_type` DISABLE KEYS */;
INSERT INTO `account_type` VALUES (1,'Savings'),(2,'Current'),(3,'Overdraft'),(4,'Checking'),(5,'Recurring deposit account'),(6,'Salary account'),(7,'Fixed deposit account');
/*!40000 ALTER TABLE `account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES ('BR001',' Downtown Branch'),('BR002',' Midtown Branch'),('BR003',' Riverside Branch'),('BR004',' Central Branch'),('BR005',' Westside Branch'),('BR006',' East End Branch'),('BR007',' Northside Branch'),('BR008',' Southside Branch'),('BR009',' Uptown Branch'),('BR010',' Greenfield Branch'),('BR011',' Lakeside Branch'),('BR012',' Hilltop Branch'),('BR013',' Parkview Branch'),('BR014',' Seaside Branch'),('BR015',' Valley Branch'),('BR016',' Gateway Branch'),('BR017',' City Center Branch'),('BR018',' University Branch'),('BR019',' Industrial Branch'),('BR020',' Market Square Branch'),('BR021',' Heritage Branch'),('BR022',' Pine Grove Branch'),('BR023',' Oakwood Branch'),('BR024',' Sunrise Branch'),('BR025',' Sunset Branch'),('BR026',' Metro Branch'),('BR027',' Airport Branch'),('BR028',' Station Branch'),('BR029',' Grand Avenue Branch'),('BR030',' Harbor Branch');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Afghanistan','AF','Asia'),(2,'Albania','AL','Europe'),(3,'Algeria','DZ','Africa'),(4,'Andorra','AD','Europe'),(5,'Angola','AO','Africa'),(6,'Antigua and Barbuda','AG','North America'),(7,'Argentina','AR','South America'),(8,'Armenia','AM','Asia'),(9,'Australia','AU','Oceania'),(10,'Austria','AT','Europe'),(11,'Azerbaijan','AZ','Asia'),(12,'Bahamas','BS','North America'),(13,'Bahrain','BH','Asia'),(14,'Bangladesh','BD','Asia'),(15,'Barbados','BB','North America'),(16,'Belarus','BY','Europe'),(17,'Belgium','BE','Europe'),(18,'Belize','BZ','North America'),(19,'Benin','BJ','Africa'),(20,'Bhutan','BT','Asia'),(21,'Bolivia','BO','South America'),(22,'Bosnia and Herzegovina','BA','Europe'),(23,'Botswana','BW','Africa'),(24,'Brazil','BR','South America'),(25,'Brunei Darussalam','BN','Asia'),(26,'Bulgaria','BG','Europe'),(27,'Burkina Faso','BF','Africa'),(28,'Burundi','BI','Africa'),(29,'Cabo Verde','CV','Africa'),(30,'Cambodia','KH','Asia'),(31,'Cameroon','CM','Africa'),(32,'Canada','CA','North America'),(33,'Central African Republic','CF','Africa'),(34,'Chad','TD','Africa'),(35,'Chile','CL','South America'),(36,'China','CN','Asia'),(37,'Colombia','CO','South America'),(38,'Comoros','KM','Africa'),(39,'Congo','CG','Africa'),(40,'Costa Rica','CR','North America'),(41,'Croatia','HR','Europe'),(42,'Cuba','CU','North America'),(43,'Cyprus','CY','Asia'),(44,'Czech Republic','CZ','Europe'),(45,'Denmark','DK','Europe'),(46,'Djibouti','DJ','Africa'),(47,'Dominica','DM','North America'),(48,'Dominican Republic','DO','North America'),(49,'Ecuador','EC','South America'),(50,'Egypt','EG','Africa'),(51,'El Salvador','SV','North America'),(52,'Equatorial Guinea','GQ','Africa'),(53,'Eritrea','ER','Africa'),(54,'Estonia','EE','Europe'),(55,'Eswatini','SZ','Africa'),(56,'Ethiopia','ET','Africa'),(57,'Fiji','FJ','Oceania'),(58,'Finland','FI','Europe'),(59,'France','FR','Europe'),(60,'Gabon','GA','Africa'),(61,'Gambia','GM','Africa'),(62,'Georgia','GE','Asia'),(63,'Germany','DE','Europe'),(64,'Ghana','GH','Africa'),(65,'Greece','GR','Europe'),(66,'Grenada','GD','North America'),(67,'Guatemala','GT','North America'),(68,'Guinea','GN','Africa'),(69,'Guinea-Bissau','GW','Africa'),(70,'Guyana','GY','South America'),(71,'Haiti','HT','North America'),(72,'Honduras','HN','North America'),(73,'Hungary','HU','Europe'),(74,'Iceland','IS','Europe'),(75,'India','IN','Asia'),(76,'Indonesia','ID','Asia'),(77,'Iran','IR','Asia'),(78,'Iraq','IQ','Asia'),(79,'Ireland','IE','Europe'),(80,'Israel','IL','Asia'),(81,'Italy','IT','Europe'),(82,'Jamaica','JM','North America'),(83,'Japan','JP','Asia'),(84,'Jordan','JO','Asia'),(85,'Kazakhstan','KZ','Asia'),(86,'Kenya','KE','Africa'),(87,'Kiribati','KI','Oceania'),(88,'Korea (North)','KP','Asia'),(89,'Korea (South)','KR','Asia'),(90,'Kuwait','KW','Asia'),(91,'Kyrgyzstan','KG','Asia'),(92,'Lao People\'s Democratic Republic','LA','Asia'),(93,'Latvia','LV','Europe'),(94,'Lebanon','LB','Asia'),(95,'Lesotho','LS','Africa'),(96,'Liberia','LR','Africa'),(97,'Libya','LY','Africa'),(98,'Liechtenstein','LI','Europe'),(99,'Lithuania','LT','Europe'),(100,'Luxembourg','LU','Europe'),(101,'Madagascar','MG','Africa'),(102,'Malawi','MW','Africa'),(103,'Malaysia','MY','Asia'),(104,'Maldives','MV','Asia'),(105,'Mali','ML','Africa'),(106,'Malta','MT','Europe'),(107,'Marshall Islands','MH','Oceania'),(108,'Mauritania','MR','Africa'),(109,'Mauritius','MU','Africa'),(110,'Mexico','MX','North America'),(111,'Micronesia','FM','Oceania'),(112,'Moldova','MD','Europe'),(113,'Monaco','MC','Europe'),(114,'Mongolia','MN','Asia'),(115,'Montenegro','ME','Europe'),(116,'Morocco','MA','Africa'),(117,'Mozambique','MZ','Africa'),(118,'Myanmar','MM','Asia'),(119,'Namibia','NA','Africa'),(120,'Nauru','NR','Oceania'),(121,'Nepal','NP','Asia'),(122,'Netherlands','NL','Europe'),(123,'New Zealand','NZ','Oceania'),(124,'Nicaragua','NI','North America'),(125,'Niger','NE','Africa'),(126,'Nigeria','NG','Africa'),(127,'North Macedonia','MK','Europe'),(128,'Norway','NO','Europe'),(129,'Oman','OM','Asia'),(130,'Pakistan','PK','Asia'),(131,'Palau','PW','Oceania'),(132,'Panama','PA','North America'),(133,'Papua New Guinea','PG','Oceania'),(134,'Paraguay','PY','South America'),(135,'Peru','PE','South America'),(136,'Philippines','PH','Asia'),(137,'Poland','PL','Europe'),(138,'Portugal','PT','Europe'),(139,'Qatar','QA','Asia'),(140,'Romania','RO','Europe'),(141,'Russia','RU','Europe'),(142,'Rwanda','RW','Africa'),(143,'Saint Kitts and Nevis','KN','North America'),(144,'Saint Lucia','LC','North America'),(145,'Saint Vincent and the Grenadines','VC','North America'),(146,'Samoa','WS','Oceania'),(147,'San Marino','SM','Europe'),(148,'Sao Tome and Principe','ST','Africa'),(149,'Saudi Arabia','SA','Asia'),(150,'Senegal','SN','Africa'),(151,'Serbia','RS','Europe'),(152,'Seychelles','SC','Africa'),(153,'Sierra Leone','SL','Africa'),(154,'Singapore','SG','Asia'),(155,'Slovakia','SK','Europe'),(156,'Slovenia','SI','Europe'),(157,'Solomon Islands','SB','Oceania'),(158,'Somalia','SO','Africa'),(159,'South Africa','ZA','Africa'),(160,'South Sudan','SS','Africa'),(161,'Spain','ES','Europe'),(162,'Sri Lanka','LK','Asia'),(163,'Sudan','SD','Africa'),(164,'Suriname','SR','South America'),(165,'Sweden','SE','Europe'),(166,'Switzerland','CH','Europe'),(167,'Syrian Arab Republic','SY','Asia'),(168,'Tajikistan','TJ','Asia'),(169,'Tanzania','TZ','Africa'),(170,'Thailand','TH','Asia'),(171,'Timor-Leste','TL','Asia'),(172,'Togo','TG','Africa'),(173,'Tonga','TO','Oceania'),(174,'Trinidad and Tobago','TT','North America'),(175,'Tunisia','TN','Africa'),(176,'Turkey','TR','Asia'),(177,'Turkmenistan','TM','Asia'),(178,'Tuvalu','TV','Oceania'),(179,'Uganda','UG','Africa'),(180,'Ukraine','UA','Europe'),(181,'United Arab Emirates','AE','Asia'),(182,'United Kingdom','GB','Europe'),(183,'United States','US','North America'),(184,'Uruguay','UY','South America'),(185,'Uzbekistan','UZ','Asia'),(186,'Vanuatu','VU','Oceania'),(187,'Venezuela','VE','South America'),(188,'Vietnam','VN','Asia'),(189,'Yemen','YE','Asia'),(190,'Zambia','ZM','Africa'),(191,'Zimbabwe','ZW','Africa');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer_data`
--

LOCK TABLES `customer_data` WRITE;
/*!40000 ALTER TABLE `customer_data` DISABLE KEYS */;
INSERT INTO `customer_data` VALUES (101,'Alice Johnson','alice.j@example.com','5/21/1990','ACCT-10002345','Savings','BR001','United States','1/15/2020',12000),(102,'Bob Smith','bob.smith@xyz.com','8/15/1985','ACCT-10005678','Checking','BR002','United States','11/30/2019',3000),(103,'Cathy Davis','cathy.davis@example.com','11/3/1992','ACCT-10007891','Savings','BR003','United States','6/1/2021',8500),(104,'David Lee','david.l@xyz.com','2/28/1978','ACCT-10001234','Savings','BR004','United States','3/20/2021',5000),(105,'Eva Turner','No Email Provided','4/7/1989','ACCT-10003456','Checking','BR005','United States','7/19/2020',-1000),(106,'Frank Zhang','frank.zhang@xyz.com','12/13/1975','ACCT-10004567','Savings','BR006','United States','9/11/2018',7500),(107,'Gina King','gina.k@example.com','3/20/1993','ACCT-10008901','Savings','BR007','Canada','1/9/2022',20000),(108,'Harry Brown','harry.b@xyz.com','9/15/1987','ACCT-10006789','Checking','BR008','United States','8/21/2020',3500),(109,'Ivy Scott','ivy.scott@example.com','','ACCT-10009876','Savings','BR009','Canada','11/14/2021',8000),(110,'John Doe','No Email Provided','1/1/1990','ACCT-10005432','Savings','BR010','United States','3/29/2022',0),(111,'Karen Green','karen.g@example.com','11/11/1984','ACCT-10007654','Savings','BR011','United States','12/5/2021',6000),(112,'Liam Miller','liam.m@xyz.com','2/22/1991','ACCT-10004321','Checking','BR012','United Kingdom','5/25/2019',5500),(113,'Mona Blue','mona.b@example.com','','ACCT-10002134','Savings','BR013','United States','1/18/2022',4000),(114,'Nate White','No Email Provided','10/10/1995','ACCT-10006543','Checking','BR014','Canada','6/30/2018',10000),(115,'Olivia Black','olivia.b@xyz.com','6/16/1982','ACCT-10003210','Savings','BR015','United States','7/19/2021',1500),(116,'Paul Walker','paul.w@example.com','7/5/1998','ACCT-10005478','Savings','BR016','Australia','9/25/2020',-500),(117,'Quinn Red','quinn.r@xyz.com','4/22/1979','ACCT-10008765','Savings','BR017','United Kingdom','2/14/2019',23000),(118,'Rose Pink','rose.p@example.com','8/8/1986','ACCT-10002301','Checking','BR018','New Zealand','3/9/2022',8700),(119,'Sam Grey','sam.g@example.com','9/18/1990','ACCT-10007621','Checking','BR019','United Kingdom','4/4/2020',500),(120,'Tim Orange','No Email Provided','12/31/1983','ACCT-10003489','Savings','BR020','Canada','7/23/2019',9200);
/*!40000 ALTER TABLE `customer_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transaction_data`
--

LOCK TABLES `transaction_data` WRITE;
/*!40000 ALTER TABLE `transaction_data` DISABLE KEYS */;
INSERT INTO `transaction_data` VALUES (201,'ACCT-10002345','01/05/2022','Deposit',500,'New York'),(202,'ACCT-10005678','02/15/2022','Withdrawal',200,'New York'),(203,'ACCT-10007891','03/15/2022','Deposit',300,'Los Angeles'),(204,'ACCT-10001234','04/10/2022','Withdrawal',-400,'Cincinnati'),(205,'ACCT-10003456','04/30/2022','Deposit',450,'San Francisco'),(206,'ACCT-10004567','05/20/2022','Withdrawal',100,'Texas'),(207,'ACCT-10008901','06/25/2022','Deposit',750,'Dallas'),(208,'ACCT-10006789','07/05/2022','Withdrawal',200,'Dallas'),(209,'ACCT-10009876','08/15/2022','Deposit',600,'New York'),(210,'ACCT-10005432','09/01/2022','Withdrawal',0,'New York'),(211,'ACCT-10007654','10/12/2022','Deposit',400,'San Francisco'),(212,'ACCT-10004321','11/11/2022','Withdrawal',100,'San Francisco'),(213,'ACCT-10002134','12/25/2022','Deposit',250,'Los Angeles'),(214,'ACCT-10006543','01/15/2022','Deposit',1000,'Cincinnati'),(215,'ACCT-10003210','02/28/2022','Withdrawal',-200,'Dallas'),(216,'ACCT-10005478','03/14/2022','Deposit',500,'Dallas'),(217,'ACCT-10008765','04/22/2022','Deposit',800,'New York'),(218,'ACCT-10002301','05/30/2022','Withdrawal',700,'New York'),(219,'ACCT-10007621','06/15/2022','Deposit',350,'San Francisco'),(220,'ACCT-10003489','07/20/2022','Withdrawal',600,'San Francisco');
/*!40000 ALTER TABLE `transaction_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `us_cities`
--

LOCK TABLES `us_cities` WRITE;
/*!40000 ALTER TABLE `us_cities` DISABLE KEYS */;
INSERT INTO `us_cities` VALUES (1,'ABQ','Albuquerque'),(2,'AMA','Amarillo'),(3,'ANA','Anaheim'),(4,'ANC','Anchorage'),(5,'ARL','Arlington'),(6,'ATL','Atlanta'),(7,'AUG','Augusta'),(8,'AUR','Aurora'),(9,'AUS','Austin'),(10,'BAK','Bakersfield'),(11,'BAL','Baltimore'),(12,'BAT','Baton Rouge'),(13,'BIR','Birmingham'),(14,'BOI','Boise'),(15,'BOS','Boston'),(16,'BUF','Buffalo'),(17,'CC','Corpus Christi'),(18,'CC','Cape Coral'),(19,'CHA','Chandler'),(20,'CHI','Chicago'),(21,'CHS','Chesapeake'),(22,'CIN','Cincinnati'),(23,'CLE','Cleveland'),(24,'CLT','Charlotte'),(25,'COL','Columbus'),(26,'CS','Colorado Springs'),(27,'CV','Chula Vista'),(28,'DAL','Dallas'),(29,'DC','Washington'),(30,'DEN','Denver'),(31,'DET','Detroit'),(32,'DSM','Des Moines'),(33,'DUR','Durham'),(34,'ELP','El Paso'),(35,'FAY','Fayetteville'),(36,'FON','Fontana'),(37,'FRE','Fresno'),(38,'FRE','Fremont'),(39,'FRI','Frisco'),(40,'FTW','Fort Worth'),(41,'FW','Fort Wayne'),(42,'GAR','Garland'),(43,'GIL','Gilbert'),(44,'GLA','Glendale'),(45,'GR','Grand Rapids'),(46,'GRE','Greensboro'),(47,'HB','Huntington Beach'),(48,'HEN','Henderson'),(49,'HIA','Hialeah'),(50,'HNL','Honolulu'),(51,'HOU','Houston'),(52,'HUN','Huntsville'),(53,'IND','Indianapolis'),(54,'IRV','Irvine'),(55,'IRV','Irving'),(56,'JAX','Jacksonville'),(57,'JC','Jersey City'),(58,'KC','Kansas City'),(59,'LA','Los Angeles'),(60,'LAR','Laredo'),(61,'LB','Long Beach'),(62,'LEX','Lexington'),(63,'LNK','Lincoln'),(64,'LOU','Louisville'),(65,'LR','Little Rock'),(66,'LUB','Lubbock'),(67,'LV','Las Vegas'),(68,'MAD','Madison'),(69,'MCK','McKinney'),(70,'MEM','Memphis'),(71,'MES','Mesa'),(72,'MIA','Miami'),(73,'MIL','Milwaukee'),(74,'MOD','Modesto'),(75,'MON','Montgomery'),(76,'MSP','Minneapolis'),(77,'MV','Moreno Valley'),(78,'NLV','North Las Vegas'),(79,'NO','New Orleans'),(80,'NOR','Norfolk'),(81,'NSH','Nashville'),(82,'NWK','Newark'),(83,'NY','New York'),(84,'OAK','Oakland'),(85,'OKC','Oklahoma City'),(86,'OMA','Omaha'),(87,'ORL','Orlando'),(88,'OXN','Oxnard'),(89,'PDX','Portland'),(90,'PHL','Philadelphia'),(91,'PHX','Phoenix'),(92,'PIT','Pittsburgh'),(93,'PLA','Plano'),(94,'PSL','Port St. Lucie'),(95,'RAL','Raleigh'),(96,'REN','Reno'),(97,'RIC','Richmond'),(98,'RIV','Riverside'),(99,'ROC','Rochester'),(100,'SA','Santa Ana'),(101,'SAC','Sacramento'),(102,'SAT','San Antonio'),(103,'SBD','San Bernardino'),(104,'SC','Scottsdale'),(105,'SC','Santa Clarita'),(106,'SD','San Diego'),(107,'SEA','Seattle'),(108,'SF','San Francisco'),(109,'SJ','San Jose'),(110,'SLC','Salt Lake City'),(111,'SP','St. Paul'),(112,'SPB','St. Petersburg'),(113,'SPO','Spokane'),(114,'STK','Stockton'),(115,'STL','St. Louis'),(116,'TAC','Tacoma'),(117,'TEM','Tempe'),(118,'TOL','Toledo'),(119,'TPA','Tampa'),(120,'TUC','Tucson'),(121,'TUL','Tulsa'),(122,'TX','Texas'),(123,'VB','Virginia Beach'),(124,'WIC','Wichita'),(125,'WS','Winston-Salem'),(126,'YON','Yonkers');
/*!40000 ALTER TABLE `us_cities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-05 15:51:00
