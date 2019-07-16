-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 11, 2019 at 04:47 PM
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

-- --------------------------------------------------------

--
-- Structure de la table `cars_driving`
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
-- Structure de la table `cars_users`
--

DROP TABLE IF EXISTS `cars_users`;
CREATE TABLE IF NOT EXISTS `cars_users` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userid` varchar(62) NOT NULL,
  `reference` varchar(10) NOT NULL,
  `type_relation` enum('driver','owner') NOT NULL COMMENT 'Chauffeur ou proprietaire',
  `type_owner` varchar(10) DEFAULT NULL COMMENT 'Type de proprietaire',
  `num_driver` varchar(15) DEFAULT NULL COMMENT 'Numero badge du chauffeur',
  `start_date` date NOT NULL COMMENT 'Date de debut du contrat du chauffeur',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Validité enregistrement',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `cars_users`
--

INSERT INTO `cars_users` (`id`, `userid`, `reference`, `type_relation`, `type_owner`, `num_driver`, `start_date`, `status`, `created_at`) VALUES
(1, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'CE 547 DV', 'owner', 'Test', '1202585', '2019-07-16', 1, '2019-07-16 15:10:51');

-- --------------------------------------------------------

--
-- Structure de la table `cust_emails`
--

DROP TABLE IF EXISTS `cust_emails`;
CREATE TABLE IF NOT EXISTS `cust_emails` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userid` varchar(62) NOT NULL,
  `email` varchar(150) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `cust_emails`
--

INSERT INTO `cust_emails` (`id`, `userid`, `email`, `status`, `created_at`) VALUES
(1, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'nomoserges@gmail.com', 1, '2019-07-13 12:32:08'),
(2, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'nomo_serges@yahoo.fr', 1, '2019-07-13 12:32:08');

-- --------------------------------------------------------

--
-- Structure de la table `cust_identications`
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
-- Structure de la table `cust_phones`
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `cust_phones`
--

INSERT INTO `cust_phones` (`id`, `userid`, `phone_number`, `status`, `created_at`) VALUES
(1, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '237694088948', 1, '2019-07-13 12:50:05'),
(2, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '237672496868', 1, '2019-07-13 12:50:05'),
(3, 'XYIpcR02UP8hijzQCbqJN7Aa49Sx65fM', '6775858965', 1, '2019-07-15 11:47:36'),
(4, 'XYIpcR02UP8hijzQCbqJN7Aa49Sx65fM', '68588965', 1, '2019-07-15 12:49:50'),
(5, 'XYIpcR02UP8hijzQCbqJN7Aa49Sx65fM', '20562152', 1, '2019-07-15 12:50:35');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(62) NOT NULL,
  `pseudo` varchar(190) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(190) NOT NULL,
  `lastname` varchar(190) NOT NULL,
  `gender` enum('female','male') DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `town` varchar(190) DEFAULT NULL,
  `place` varchar(190) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `job_description` text,
  `is_activated` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `pseudo` (`pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`userid`, `pseudo`, `password`, `firstname`, `lastname`, `gender`, `country`, `town`, `place`, `dob`, `job_title`, `job_description`, `is_activated`, `created_at`, `updated_at`) VALUES
('DyWawf8ReApXUjFuK31LknPO2Jvd95T7', NULL, '', 'sdfqsdf', 'sdfqsdfqf', 'female', 'dsfq', 'dsfqsdfq', 'dsfqsdfq', '2019-07-09', 'dfq', NULL, 1, '2019-07-16 15:29:15', '2019-07-16 15:29:15'),
('f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'seannomo', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'Serge Anselme', 'Mvilongo Nomo', 'male', 'Cameroun', 'Douala', 'Ngousso', '1990-07-11', 'Software Architect', 'Building applications', 1, '2019-07-11 09:10:36', '2019-07-13 10:17:52'),
('lUdmsj81rwSR5iHWYgVJaGoCvAXBcxQF', NULL, '', 'tt', 'tt', 'male', 'tt', 'tt', 'tt', '2019-07-01', 'tt', NULL, 1, '2019-07-16 15:32:55', '2019-07-16 15:32:55'),
('rJtMlvjYdbAFIweTWQH94RGhgzCanZSx', NULL, '', 'MARCEL', 'NGAM', 'male', 'Cameroun', 'NDIKI', 'POINT CHAUD', '1984-02-15', 'IT ENGINEER', NULL, 1, '2019-07-16 15:26:44', '2019-07-16 15:26:44'),
('SUhTaOPesN58GFAuz6rvqVgIkQ34yjYD', NULL, '', 'VIRGINIE', 'LEPOINT', 'female', 'France', 'Paris', 'Deuniève', '2019-07-09', 'MENAGERE', NULL, 1, '2019-07-16 15:28:39', '2019-07-16 15:28:39'),
('vfaVri1B8JUW9chL0Xet6OCmkRdoASZD', NULL, '', 'fqfqf', 'sdfqdfd', 'female', 'sdf', 'dsfq', 'dqsdfq', '2019-07-22', 'dsfq', NULL, 1, '2019-07-15 09:41:42', '2019-07-15 09:46:21'),
('XYIpcR02UP8hijzQCbqJN7Aa49Sx65fM', NULL, '', 'Patrick', 'Moussi', 'male', 'Cameroun', 'Douala', 'Makepe', '2019-07-15', 'Software Engineer', NULL, 1, '2019-07-15 09:55:12', '2019-07-15 09:55:12');

-- --------------------------------------------------------

--
-- Structure de la table `users_managers`
--

DROP TABLE IF EXISTS `users_managers`;
CREATE TABLE IF NOT EXISTS `users_managers` (
  `user_login` varchar(20) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users_managers`
--

INSERT INTO `users_managers` (`user_login`, `user_password`, `userid`, `status`, `created_at`, `last_login`) VALUES
('mvilongo', '9a11dcbcf447427142df3a41510dfa73b7f419f2', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 1, '2019-07-11 14:50:36', '2019-07-11 14:52:17');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) NOT NULL COMMENT 'Immatriculation',
  `mark` varchar(20) NOT NULL COMMENT 'Marque du vehicule',
  `color` varchar(15) NOT NULL,
  `year` int(4) NOT NULL COMMENT 'Annee de sortie',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'En circulation ou pas',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricule` (`reference`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`id`, `reference`, `mark`, `color`, `year`, `status`, `created_at`) VALUES
(1, 'CE 547 DV', 'toyota', '#FFCE9E', 2010, 1, '2019-07-16 13:18:16'),
(2, 'CE 1201 V', 'SUBARU', 'RED', 1988, 1, '2019-07-16 13:26:28'),
(3, 'LT 587 TH', 'GRAY', 'BLACK', 2005, 1, '2019-07-16 13:27:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
