-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  mar. 09 juil. 2019 à 12:39
-- Version du serveur :  10.3.15-MariaDB
-- Version de PHP :  7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `besafe_bd`
--
CREATE DATABASE IF NOT EXISTS `besafe_bd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `besafe_bd`;

-- --------------------------------------------------------

--
-- Structure de la table `cars_users`
--

CREATE TABLE `cars_users` (
  `id` bigint(255) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `matricule` varchar(10) NOT NULL,
  `type_relation` enum('driver','owner') NOT NULL COMMENT 'Chauffeur ou proprietaire',
  `type_owner` varchar(10) DEFAULT NULL COMMENT 'Type de proprietaire',
  `num_driver` varchar(15) DEFAULT NULL COMMENT 'Numero badge du chauffeur',
  `status` tinyint(1) NOT NULL COMMENT 'Validité enregistrement',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cust_emails`
--

CREATE TABLE `cust_emails` (
  `id` bigint(255) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `email` varchar(150) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cust_identications`
--

CREATE TABLE `cust_identications` (
  `id` bigint(255) NOT NULL COMMENT 'Id enregistrement',
  `userid` varchar(62) NOT NULL,
  `doc_type` enum('IDCARD','PASSPORT','OTHER','') NOT NULL COMMENT 'Type de document identification',
  `doc_number` varchar(50) NOT NULL COMMENT 'Numero identification',
  `start_date` date NOT NULL COMMENT 'Date delivrance',
  `end_date` date NOT NULL COMMENT 'Date expiration',
  `status` tinyint(1) NOT NULL COMMENT 'Document exploitable ou non',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cust_phones`
--

CREATE TABLE `cust_phones` (
  `id` bigint(255) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `userid` varchar(62) NOT NULL,
  `pseudo` varchar(190) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(190) DEFAULT NULL,
  `lastname` varchar(190) DEFAULT NULL,
  `gender` enum('female','male') DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `town` varchar(190) DEFAULT NULL,
  `place` varchar(190) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `job_description` text DEFAULT NULL,
  `is_activated` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(255) NOT NULL,
  `matricule` varchar(10) NOT NULL COMMENT 'Immatriculation',
  `mark` varchar(20) NOT NULL COMMENT 'Marque du vehicule',
  `color` varchar(15) NOT NULL,
  `year` int(4) NOT NULL COMMENT 'Annee de sortie',
  `status` tinyint(1) NOT NULL COMMENT 'En circulation ou pas',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cars_users`
--
ALTER TABLE `cars_users`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cust_emails`
--
ALTER TABLE `cust_emails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `cust_identications`
--
ALTER TABLE `cust_identications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `doc_number` (`doc_number`);

--
-- Index pour la table `cust_phones`
--
ALTER TABLE `cust_phones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `pseudo` (`pseudo`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cars_users`
--
ALTER TABLE `cars_users`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cust_emails`
--
ALTER TABLE `cust_emails`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cust_identications`
--
ALTER TABLE `cust_identications`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT COMMENT 'Id enregistrement';

--
-- AUTO_INCREMENT pour la table `cust_phones`
--
ALTER TABLE `cust_phones`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
