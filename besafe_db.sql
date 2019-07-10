-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 10, 2019 at 03:06 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `besafe_db`
--
CREATE DATABASE IF NOT EXISTS `besafe_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `besafe_db`;

-- --------------------------------------------------------

--
-- Table structure for table `cars_driving`
--

DROP TABLE IF EXISTS `cars_driving`;
CREATE TABLE IF NOT EXISTS `cars_driving` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `start_driving` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_driving` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cars_users`
--

DROP TABLE IF EXISTS `cars_users`;
CREATE TABLE IF NOT EXISTS `cars_users` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userid` varchar(62) NOT NULL,
  `matricule` varchar(10) NOT NULL,
  `type_relation` enum('driver','owner') NOT NULL COMMENT 'Chauffeur ou proprietaire',
  `type_owner` varchar(10) DEFAULT NULL COMMENT 'Type de proprietaire',
  `num_driver` varchar(15) DEFAULT NULL COMMENT 'Numero badge du chauffeur',
  `start_date` date NOT NULL COMMENT 'Date de debut du contrat du chauffeur',
  `status` tinyint(1) NOT NULL COMMENT 'Validité enregistrement',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cust_emails`
--

DROP TABLE IF EXISTS `cust_emails`;
CREATE TABLE IF NOT EXISTS `cust_emails` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userid` varchar(62) NOT NULL,
  `email` varchar(150) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cust_identications`
--

DROP TABLE IF EXISTS `cust_identications`;
CREATE TABLE IF NOT EXISTS `cust_identications` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT COMMENT 'Id enregistrement',
  `userid` varchar(62) NOT NULL,
  `doc_type` enum('IDCARD','PASSPORT','OTHER','') NOT NULL COMMENT 'Type de document identification',
  `doc_number` varchar(50) NOT NULL COMMENT 'Numero identification',
  `start_date` date NOT NULL COMMENT 'Date delivrance',
  `end_date` date NOT NULL COMMENT 'Date expiration',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Document exploitable ou non',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doc_number` (`doc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cust_phones`
--

DROP TABLE IF EXISTS `cust_phones`;
CREATE TABLE IF NOT EXISTS `cust_phones` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userid` varchar(62) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(62) NOT NULL,
  `pseudo` varchar(190) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(190) DEFAULT NULL,
  `lastname` varchar(190) DEFAULT NULL,
  `gender` enum('female','male') DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `town` varchar(190) DEFAULT NULL,
  `place` varchar(190) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `job_description` text,
  `is_activated` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `pseudo` (`pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users_managers`
--

DROP TABLE IF EXISTS `users_managers`;
CREATE TABLE IF NOT EXISTS `users_managers` (
  `user_login` varchar(20) NOT NULL,
  `user_password` varchar(32) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL,
  PRIMARY KEY (`user_login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) NOT NULL COMMENT 'Immatriculation',
  `mark` varchar(20) NOT NULL COMMENT 'Marque du vehicule',
  `color` varchar(15) NOT NULL,
  `year` int(4) NOT NULL COMMENT 'Annee de sortie',
  `status` tinyint(1) NOT NULL COMMENT 'En circulation ou pas',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricule` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
