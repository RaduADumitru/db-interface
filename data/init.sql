CREATE DATABASE  IF NOT EXISTS `gestionare_angajati_companie_aeriana` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestionare_angajati_companie_aeriana`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: gestionare_angajati_companie_aeriana
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `aeroport`
--

DROP TABLE IF EXISTS `aeroport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aeroport` (
  `id_aeroport` varchar(4) NOT NULL,
  `nume` varchar(45) NOT NULL,
  `categorie` decimal(1,0) unsigned NOT NULL,
  `oras` varchar(45) NOT NULL,
  `tara` varchar(45) NOT NULL,
  PRIMARY KEY (`id_aeroport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aeroport`
--

LOCK TABLES `aeroport` WRITE;
/*!40000 ALTER TABLE `aeroport` DISABLE KEYS */;
INSERT INTO `aeroport` VALUES ('BBU','Baneasa',2,'Bucuresti','Romania'),('CLJ','Cluj-Napoca',1,'Cluj-Napoca','Romania'),('MAD','Madrid-Barajas',1,'Madrid','Spania'),('OTP','Otopeni',1,'Bucuresti','Romania'),('SOF','Sofia',3,'Sofia','Bulgaria');
/*!40000 ALTER TABLE `aeroport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `angajat`
--

DROP TABLE IF EXISTS `angajat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `angajat` (
  `id_angajat` int unsigned NOT NULL,
  `nume` varchar(45) NOT NULL,
  `prenume` varchar(45) NOT NULL,
  `nr_telefon` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `data_nasterii` date DEFAULT NULL,
  `cod_functie` varchar(3) NOT NULL,
  `id_aeroport` varchar(4) NOT NULL,
  PRIMARY KEY (`id_angajat`),
  KEY `id_aeroport_idx` (`id_aeroport`),
  KEY `angajat-functie_idx` (`cod_functie`),
  CONSTRAINT `angajat-aeroport` FOREIGN KEY (`id_aeroport`) REFERENCES `aeroport` (`id_aeroport`) ON DELETE CASCADE,
  CONSTRAINT `angajat-functie` FOREIGN KEY (`cod_functie`) REFERENCES `functie` (`cod_functie`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `angajat`
--

LOCK TABLES `angajat` WRITE;
/*!40000 ALTER TABLE `angajat` DISABLE KEYS */;
INSERT INTO `angajat` VALUES (1,'Alexandrescu','Mihai','+40734272919','alexandrescu.mihai@gmail.com','1977-02-27','CC','OTP'),(2,'Tudose','Andrei','+40764272333','andreitudose@yahoo.com','1969-03-05','CMD','OTP'),(3,'Dimitrie','Ana Daria','+40745678678',NULL,'1975-04-05','SCC','CLJ'),(4,'Lespezanu','Alex','',NULL,'1960-05-09','COP','CLJ'),(5,'Blagoev','Viktor','+359888123456','viktorblagoev@gmail.com','1965-05-10','CMD','SOF'),(6,'Constantin','Marian','+40745678679','constantinmarian@yahoo.com','1985-05-25','COP','OTP'),(7,'Lenghel','Ioan','+40734272333','lenghelioan@yahoo.com','1976-10-10','CMD','CLJ'),(8,'Vasiljeva','Marija','+359888123555','marijav@gmail.com','1970-05-06','CC','SOF'),(9,'Ivanov','Andrei','+359879102939','andrei_iv@gmail.com','1984-01-15','SCC','SOF'),(10,'Demetriad','Sorina','+40325635210','sorinad@gmail.com','1975-09-13','CC','OTP');
/*!40000 ALTER TABLE `angajat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `SchimbareAeroportUpdate` BEFORE UPDATE ON `angajat` FOR EACH ROW BEGIN
if not (lower(new.id_aeroport) like lower(old.id_aeroport))
then
delete from asociere_zbor where id_angajat = new.id_angajat;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `asociere_indisponibilitate`
--

DROP TABLE IF EXISTS `asociere_indisponibilitate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asociere_indisponibilitate` (
  `id_angajat` int unsigned NOT NULL,
  `id_indisponibilitate` int unsigned NOT NULL,
  PRIMARY KEY (`id_angajat`,`id_indisponibilitate`),
  KEY `asociere_indisponibilitate-indisponibilitate_idx` (`id_indisponibilitate`),
  CONSTRAINT `asociere_indisponibilitate-angajat` FOREIGN KEY (`id_angajat`) REFERENCES `angajat` (`id_angajat`) ON DELETE CASCADE,
  CONSTRAINT `asociere_indisponibilitate-indisponibilitate` FOREIGN KEY (`id_indisponibilitate`) REFERENCES `indisponibilitate` (`id_indisponibilitate`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asociere_indisponibilitate`
--

LOCK TABLES `asociere_indisponibilitate` WRITE;
/*!40000 ALTER TABLE `asociere_indisponibilitate` DISABLE KEYS */;
INSERT INTO `asociere_indisponibilitate` VALUES (2,1),(3,2),(1,3),(2,3),(3,3),(4,3),(5,4);
/*!40000 ALTER TABLE `asociere_indisponibilitate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asociere_zbor`
--

DROP TABLE IF EXISTS `asociere_zbor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asociere_zbor` (
  `id_angajat` int unsigned NOT NULL,
  `nr_zbor` decimal(4,0) unsigned NOT NULL,
  `plecare_dus` datetime NOT NULL,
  PRIMARY KEY (`id_angajat`,`nr_zbor`,`plecare_dus`),
  KEY `nr_zbor, plecare_dus_idx` (`nr_zbor`,`plecare_dus`),
  CONSTRAINT `asociere_zbor-angajat` FOREIGN KEY (`id_angajat`) REFERENCES `angajat` (`id_angajat`) ON DELETE CASCADE,
  CONSTRAINT `asociere_zbor-zbor` FOREIGN KEY (`nr_zbor`, `plecare_dus`) REFERENCES `zbor` (`nr_zbor`, `plecare_dus`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asociere_zbor`
--

LOCK TABLES `asociere_zbor` WRITE;
/*!40000 ALTER TABLE `asociere_zbor` DISABLE KEYS */;
INSERT INTO `asociere_zbor` VALUES (1,201,'2022-01-02 21:55:00'),(10,201,'2022-01-02 21:55:00'),(1,201,'2022-01-03 07:50:00'),(2,201,'2022-01-03 07:50:00'),(1,361,'2022-01-02 08:35:00'),(2,361,'2022-01-02 08:35:00'),(6,361,'2022-01-02 08:35:00'),(5,641,'2022-01-01 07:35:00'),(8,641,'2022-01-01 07:35:00'),(9,641,'2022-01-01 07:35:00'),(1,6181,'1950-01-04 05:50:00'),(2,6181,'1950-01-04 05:50:00'),(6,6181,'1950-01-04 05:50:00'),(10,6181,'1950-01-04 05:50:00');
/*!40000 ALTER TABLE `asociere_zbor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `SuprapunereZboruriInsert` BEFORE INSERT ON `asociere_zbor` FOR EACH ROW BEGIN
declare pd datetime;
declare si datetime;
set @pd := (select z1.plecare_dus
from zbor z1
where z1.nr_zbor = new.nr_zbor
and z1.plecare_dus = new.plecare_dus);
set @si := (select z2.sosire_intors
from zbor z2
where z2.nr_zbor = new.nr_zbor
and z2.plecare_dus = new.plecare_dus);
if exists (select *
from zbor z3
where ((z3.nr_zbor, z3.plecare_dus) in 
(select asoc.nr_zbor, asoc.plecare_dus
from asociere_zbor asoc
where asoc.id_angajat = new.id_angajat
and not (asoc.nr_zbor = new.nr_zbor
and asoc.plecare_dus = new.plecare_dus))
and (not ((@si <= z3.plecare_dus ) or (z3.plecare_intors <= @pd)))))
then
signal sqlstate '45000' 
set message_text = 'Zbor se suprapune cu alte zboruri ale angajatului!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AeroporturiDiferiteInsert` BEFORE INSERT ON `asociere_zbor` FOR EACH ROW begin
if exists(select * from (select * from asociere_zbor where nr_zbor = new.nr_zbor) as asoc
join angajat a on asoc.id_angajat = a.id_angajat
where a.id_aeroport not in (select a2.id_aeroport from angajat a2 where a2.id_angajat = new.id_angajat))
then signal sqlstate '45000' set message_text = 'Angajat desemnat la alt aeroport decat ceilalti angajati ai zborului!';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AeroporturiDiferiteUpdate` BEFORE UPDATE ON `asociere_zbor` FOR EACH ROW BEGIN
if exists(select * from (select * from asociere_zbor where nr_zbor = new.nr_zbor) as asoc
join angajat a on asoc.id_angajat = a.id_angajat
where a.id_aeroport not in (select a2.id_aeroport from angajat a2 where a2.id_angajat = new.id_angajat))
then signal sqlstate '45000' set message_text = 'Angajat desemnat la alt aeroport decat ceilalti angajati ai zborului!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `SuprapunereZboruriUpdate` BEFORE UPDATE ON `asociere_zbor` FOR EACH ROW BEGIN
declare pd datetime;
declare si datetime;
set @pd := (select z1.plecare_dus
from zbor z1
where z1.nr_zbor = new.nr_zbor
and z1.plecare_dus = new.plecare_dus);
set @si := (select z2.sosire_intors
from zbor z2
where z2.nr_zbor = new.nr_zbor
and z2.plecare_dus = new.plecare_dus);
if exists (select *
from zbor z3
where ((z3.nr_zbor, z3.plecare_dus) in 
(select asoc.nr_zbor, asoc.plecare_dus
from asociere_zbor asoc
where asoc.id_angajat = new.id_angajat
and not (asoc.nr_zbor = new.nr_zbor
and asoc.plecare_dus = new.plecare_dus))
and (not ((@si <= z3.plecare_dus ) or (z3.plecare_intors <= @pd)))))
then
signal sqlstate '45000' 
set message_text = 'Zbor se suprapune cu alte zboruri ale angajatului!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `avion`
--

DROP TABLE IF EXISTS `avion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avion` (
  `id_avion` varchar(5) NOT NULL,
  `tip` varchar(45) NOT NULL,
  `data_iesire_fabrica` datetime DEFAULT NULL,
  PRIMARY KEY (`id_avion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci KEY_BLOCK_SIZE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avion`
--

LOCK TABLES `avion` WRITE;
/*!40000 ALTER TABLE `avion` DISABLE KEYS */;
INSERT INTO `avion` VALUES ('1','BOEING-737','1992-01-15 00:00:00'),('2','BOEING-747','2007-02-17 00:00:00'),('3','AIRBUS A380','2020-05-06 00:00:00'),('4','BOEING-737','1998-01-12 00:00:00'),('5','AIRBUS A380','1999-01-12 00:00:00'),('6','BOEING-747',NULL);
/*!40000 ALTER TABLE `avion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ZboruriAvionInvalideUpdate` BEFORE UPDATE ON `avion` FOR EACH ROW BEGIN
if exists(
select *
from zbor z
where z.id_avion = new.id_avion
and z.sosire_intors <= new.data_iesire_fabrica)
and new.data_iesire_fabrica is not null
then
signal sqlstate '45000' 
set message_text = 'Setarea acestei date de iesire din fabrica ar invalida cel putin un zbor efectuat de acest avion!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `functie`
--

DROP TABLE IF EXISTS `functie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `functie` (
  `cod_functie` varchar(3) NOT NULL,
  `denumire` varchar(45) NOT NULL,
  `fisa_functie` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_functie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functie`
--

LOCK TABLES `functie` WRITE;
/*!40000 ALTER TABLE `functie` DISABLE KEYS */;
INSERT INTO `functie` VALUES ('CC','Cabin Crew','cabincrew.pdf'),('CMD','Comandant','comandant.pdf'),('COP','Copilot','copilot.pdf'),('SCC','Senior Cabin Crew','seniorcabincrew.pdf');
/*!40000 ALTER TABLE `functie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indisponibilitate`
--

DROP TABLE IF EXISTS `indisponibilitate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indisponibilitate` (
  `id_indisponibilitate` int unsigned NOT NULL,
  `data_inceput` date NOT NULL,
  `data_final` date NOT NULL,
  `tip` varchar(45) NOT NULL,
  `fisa_concediu` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_indisponibilitate`),
  CONSTRAINT `CHK_OrdineDate` CHECK ((`data_inceput` <= `data_final`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indisponibilitate`
--

LOCK TABLES `indisponibilitate` WRITE;
/*!40000 ALTER TABLE `indisponibilitate` DISABLE KEYS */;
INSERT INTO `indisponibilitate` VALUES (1,'2021-12-01','2021-12-22','medical','tudosea1.pdf'),(2,'2021-12-05','2022-12-05','maternitate','dimitriea1.pdf'),(3,'2021-12-24','2022-01-02','odihna','concediuiarna21-22.pdf'),(4,'2022-01-13','2022-01-15','odihna','blagoevv_vakantsiya1.pdf');
/*!40000 ALTER TABLE `indisponibilitate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licenta`
--

DROP TABLE IF EXISTS `licenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenta` (
  `cod_licenta` varchar(10) NOT NULL,
  `data_expirare` date DEFAULT NULL,
  `tip` varchar(45) NOT NULL,
  `id_angajat` int unsigned NOT NULL,
  PRIMARY KEY (`cod_licenta`),
  KEY `id_angajat_idx` (`id_angajat`),
  CONSTRAINT `licenta-angajat` FOREIGN KEY (`id_angajat`) REFERENCES `angajat` (`id_angajat`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licenta`
--

LOCK TABLES `licenta` WRITE;
/*!40000 ALTER TABLE `licenta` DISABLE KEYS */;
INSERT INTO `licenta` VALUES ('cc_1','2022-03-06','CC',2),('cc_2','2022-02-09','CC',1),('cmd_1','2022-06-01','CMD_A',2),('cmd_2','2022-05-14','CMD_B',5),('cop_1','2022-04-06','COP',4),('scc_1','2022-02-03','SCC',3);
/*!40000 ALTER TABLE `licenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zbor`
--

DROP TABLE IF EXISTS `zbor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zbor` (
  `nr_zbor` decimal(4,0) unsigned NOT NULL,
  `plecare_dus` datetime NOT NULL,
  `sosire_dus` datetime NOT NULL,
  `plecare_intors` datetime NOT NULL,
  `sosire_intors` datetime NOT NULL,
  `destinatie` varchar(45) NOT NULL,
  `id_avion` varchar(5) NOT NULL,
  PRIMARY KEY (`nr_zbor`,`plecare_dus`),
  KEY `zbor-avion_idx` (`id_avion`),
  CONSTRAINT `zbor-avion` FOREIGN KEY (`id_avion`) REFERENCES `avion` (`id_avion`) ON DELETE CASCADE,
  CONSTRAINT `CHK_OrdineOre` CHECK (((`plecare_dus` < `sosire_dus`) and (`sosire_dus` < `plecare_intors`) and (`plecare_intors` < `sosire_intors`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zbor`
--

LOCK TABLES `zbor` WRITE;
/*!40000 ALTER TABLE `zbor` DISABLE KEYS */;
INSERT INTO `zbor` VALUES (201,'2022-01-02 21:55:00','2022-01-02 23:05:00','2022-01-03 05:25:00','2022-01-03 06:40:00','Kiev','4'),(201,'2022-01-03 07:50:00','2022-01-03 09:00:00','2022-01-03 09:30:00','2022-01-03 10:50:00','Kiev','2'),(361,'2022-01-02 08:35:00','2022-01-02 10:40:00','2022-01-02 11:40:00','2022-01-02 15:25:00','Amsterdam','3'),(641,'2022-01-01 07:35:00','2022-01-01 08:45:00','2022-01-01 09:10:00','2022-01-01 10:20:00','Cluj','1'),(1029,'2022-01-04 12:10:00','2022-01-04 12:45:00','2022-01-04 14:10:00','2022-01-04 14:45:00','Cluj','1'),(6181,'1950-01-04 05:50:00','1950-01-04 09:00:00','1950-01-04 09:55:00','1950-01-04 13:20:00','Hurghada','5'),(6181,'2022-01-01 05:50:00','2022-01-01 09:00:00','2022-01-01 09:55:00','2022-01-01 13:20:00','Hurghada','3');
/*!40000 ALTER TABLE `zbor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AvionIndisponibilInsert` BEFORE INSERT ON `zbor` FOR EACH ROW BEGIN
if exists(
select *
from zbor z
where(z.id_avion = new.id_avion
and not(new.sosire_intors <= z.plecare_dus 
or new.plecare_dus >= z.sosire_intors 
or (new.plecare_dus >= z.sosire_dus and new.sosire_intors <= z.plecare_intors))))
then
signal sqlstate '45000' 
set message_text = 'Avionul efectueaza mai multe zboruri in acelasi timp!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DataAvionInvalidaInsert` BEFORE INSERT ON `zbor` FOR EACH ROW BEGIN
declare di datetime;
set @di := (select av.data_iesire_fabrica
from avion av
where new.id_avion = av.id_avion);
if (new.plecare_dus <= @di
and @di is not null)
then
signal sqlstate '45000' 
set message_text = 'Avionul nu a fost inca pregatit sa efectueze zboruri in perioada respectiva!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AvionIndisponibilUpdate` BEFORE UPDATE ON `zbor` FOR EACH ROW BEGIN
if exists(
select *
from zbor z
where(z.id_avion = new.id_avion
and not(new.nr_zbor = z.nr_zbor and new.plecare_dus = z.plecare_dus)
and not(new.sosire_intors <= z.plecare_dus 
or new.plecare_dus >= z.sosire_intors 
or (new.plecare_dus >= z.sosire_dus and new.sosire_intors <= z.plecare_intors))))
then
signal sqlstate '45000' 
set message_text = 'Avionul efectueaza mai multe zboruri in acelasi timp!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DataAvionInvalidaUpdate` BEFORE UPDATE ON `zbor` FOR EACH ROW BEGIN
declare di datetime;
set @di := (select av.data_iesire_fabrica
from avion av
where new.id_avion = av.id_avion);
if (new.plecare_dus <= @di
and @di is not null)
then
signal sqlstate '45000' 
set message_text = 'Avionul nu a fost inca pregatit sa efectueze zboruri in perioada respectiva!';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-20 21:06:43
