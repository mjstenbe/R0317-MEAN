-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 11, 2021 at 09:52 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yritys`
--

-- --------------------------------------------------------

--
-- Table structure for table `henkilo`
--

CREATE TABLE `henkilo` (
  `htun` char(4) NOT NULL,
  `enimi` varchar(10) DEFAULT NULL,
  `snimi` varchar(10) DEFAULT NULL,
  `kunta` varchar(8) DEFAULT NULL,
  `tutk` char(6) DEFAULT NULL,
  `palkka` decimal(7,2) DEFAULT NULL,
  `veropr` decimal(3,1) DEFAULT NULL,
  `pvm` datetime DEFAULT NULL,
  `ostun` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `henkilo`
--

INSERT INTO `henkilo` (`htun`, `enimi`, `snimi`, `kunta`, `tutk`, `palkka`, `veropr`, `pvm`, `ostun`) VALUES
('2222', 'Saku', 'Koivu', 'Turku', 'Yo', '2900.00', '24.0', '2005-03-01 00:00:00', 3),
('2233', 'Hannu', 'Virta', 'Turku', 'FM', '3100.00', '32.0', '1995-10-10 00:00:00', 1),
('2234', 'Liisa', 'Lehtipuu', 'Kerava', 'FK', '2200.00', '18.0', '1999-12-01 00:00:00', 4),
('2333', 'Katja', 'Kataja', 'Turku', NULL, '2300.00', '19.0', '2005-05-01 00:00:00', 3),
('2345', 'Keijo', 'Kuusi', 'Kerava', 'Trad.', '2580.00', '24.0', '2000-08-12 00:00:00', NULL),
('3567', 'Kari', 'Mänty', 'Helsinki', 'Yo', '2650.00', '22.0', '1997-09-15 00:00:00', 1),
('3568', 'Hannu', 'Haapanen', 'Helsinki', 'DI', '3400.00', '37.0', '1993-05-10 00:00:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oma_taulu`
--

CREATE TABLE `oma_taulu` (
  `tuotenimi` varchar(20) NOT NULL,
  `hinta` int(11) DEFAULT NULL,
  `valmistaja` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oma_taulu`
--

INSERT INTO `oma_taulu` (`tuotenimi`, `hinta`, `valmistaja`) VALUES
('Näytönohjain', 249, 'NVidia');

-- --------------------------------------------------------

--
-- Table structure for table `osasto`
--

CREATE TABLE `osasto` (
  `ostun` smallint(6) NOT NULL,
  `osnimi` varchar(15) NOT NULL,
  `koodi` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `osasto`
--

INSERT INTO `osasto` (`ostun`, `osnimi`, `koodi`) VALUES
(1, 'Tietohallinto', 'THa'),
(2, 'Talousosasto', 'TaO'),
(3, 'Tuotanto', 'Tuo'),
(4, 'Markkinointi', 'Mar');

-- --------------------------------------------------------

--
-- Table structure for table `projekti`
--

CREATE TABLE `projekti` (
  `ptun` varchar(4) NOT NULL,
  `pnimi` varchar(30) NOT NULL,
  `priorit` smallint(6) DEFAULT NULL,
  `sijainti` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projekti`
--

INSERT INTO `projekti` (`ptun`, `pnimi`, `priorit`, `sijainti`) VALUES
('P1', 'Sähköinen laskutus', 2, 'Turku'),
('P2', 'Raportoinnin parannus', 1, 'Kerava'),
('P3', 'Tilastointi', NULL, NULL),
('P4', 'Henkilöstön koulutus', 2, 'Turku'),
('P5', 'Asiakaspalvelu', 3, 'Joensuu'),
('P6', 'SAP-käyttöönotto', 1, 'Kerava');

-- --------------------------------------------------------

--
-- Table structure for table `proj_henk`
--

CREATE TABLE `proj_henk` (
  `ptun` char(4) NOT NULL,
  `htun` char(4) NOT NULL,
  `tunnit` smallint(6) DEFAULT NULL,
  `tunnit_suun` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `proj_henk`
--

INSERT INTO `proj_henk` (`ptun`, `htun`, `tunnit`, `tunnit_suun`) VALUES
('P1', '2222', 300, 300),
('P1', '2233', 150, 200),
('P1', '2333', 200, 200),
('P1', '2345', 100, 100),
('P2', '2222', 0, 100),
('P4', '2333', 150, NULL),
('P4', '2345', 200, 250),
('P4', '3567', 300, 200),
('P5', '2233', 500, 600),
('P5', '3567', 200, 200);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `henkilo`
--
ALTER TABLE `henkilo`
  ADD PRIMARY KEY (`htun`),
  ADD KEY `henk_os_fk` (`ostun`);

--
-- Indexes for table `oma_taulu`
--
ALTER TABLE `oma_taulu`
  ADD PRIMARY KEY (`tuotenimi`);

--
-- Indexes for table `osasto`
--
ALTER TABLE `osasto`
  ADD PRIMARY KEY (`ostun`);

--
-- Indexes for table `projekti`
--
ALTER TABLE `projekti`
  ADD PRIMARY KEY (`ptun`);

--
-- Indexes for table `proj_henk`
--
ALTER TABLE `proj_henk`
  ADD PRIMARY KEY (`ptun`,`htun`),
  ADD KEY `prhe_henk` (`htun`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `henkilo`
--
ALTER TABLE `henkilo`
  ADD CONSTRAINT `henk_os_fk` FOREIGN KEY (`ostun`) REFERENCES `osasto` (`ostun`) ON DELETE SET NULL;

--
-- Constraints for table `proj_henk`
--
ALTER TABLE `proj_henk`
  ADD CONSTRAINT `prhe_henk` FOREIGN KEY (`htun`) REFERENCES `henkilo` (`htun`),
  ADD CONSTRAINT `prhe_proj` FOREIGN KEY (`ptun`) REFERENCES `projekti` (`ptun`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
