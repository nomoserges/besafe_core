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

--
-- Structure de la table `cars_driving`
--

CREATE TABLE `cars_driving` (
  `id` bigint(255) NOT NULL,
  `reference` varchar(10) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `start_driving` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_driving` timestamp NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `start_date` date NOT NULL COMMENT 'Date de debut du contrat du chauffeur',
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
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `cust_identications` (
  `id` bigint(255) NOT NULL COMMENT 'Id enregistrement',
  `userid` varchar(62) NOT NULL,
  `doc_type` enum('IDCARD','PASSPORT','OTHER','') NOT NULL COMMENT 'Type de document identification',
  `doc_number` varchar(50) NOT NULL COMMENT 'Numero identification',
  `start_date` date NOT NULL COMMENT 'Date delivrance',
  `end_date` date NOT NULL COMMENT 'Date expiration',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Document exploitable ou non',
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
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `cust_phones`
--

INSERT INTO `cust_phones` (`id`, `userid`, `phone_number`, `status`, `created_at`) VALUES
(1, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '237694088948', 1, '2019-07-13 12:50:05'),
(2, 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', '237672496868', 1, '2019-07-13 12:50:05');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
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
  `job_description` text DEFAULT NULL,
  `is_activated` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`userid`, `pseudo`, `password`, `firstname`, `lastname`, `gender`, `country`, `town`, `place`, `dob`, `job_title`, `job_description`, `is_activated`, `created_at`, `updated_at`) VALUES
('f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'seannomo', 'f7c3bc1d808e04732adf679965ccc34ca7ae3441', 'Serge Anselme', 'Mvilongo Nomo', 'male', 'Cameroun', 'Douala', 'Ngousso', '1990-07-11', 'Software Architect', 'Building applications', 1, '2019-07-11 09:10:36', '2019-07-13 10:17:52');

-- --------------------------------------------------------

--
-- Structure de la table `users_managers`
--

CREATE TABLE `users_managers` (
  `user_login` varchar(20) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `userid` varchar(62) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
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

CREATE TABLE `vehicles` (
  `id` bigint(255) NOT NULL,
  `reference` varchar(10) NOT NULL COMMENT 'Immatriculation',
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
-- Index pour la table `cars_driving`
--
ALTER TABLE `cars_driving`
  ADD PRIMARY KEY (`id`);

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
-- Index pour la table `users_managers`
--
ALTER TABLE `users_managers`
  ADD PRIMARY KEY (`user_login`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`reference`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cars_driving`
--
ALTER TABLE `cars_driving`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cars_users`
--
ALTER TABLE `cars_users`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cust_emails`
--
ALTER TABLE `cust_emails`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cust_identications`
--
ALTER TABLE `cust_identications`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT COMMENT 'Id enregistrement';

--
-- AUTO_INCREMENT pour la table `cust_phones`
--
ALTER TABLE `cust_phones`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
