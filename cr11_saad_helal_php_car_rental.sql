-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2018 at 04:49 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cr11_saad_helal_php_car_rental`
--

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `car_id` int(11) NOT NULL,
  `car_type` varchar(255) COLLATE utf8_bin NOT NULL,
  `car_model` varchar(255) COLLATE utf8_bin NOT NULL,
  `car_img` varchar(255) COLLATE utf8_bin NOT NULL,
  `availability` enum('available','rented') COLLATE utf8_bin NOT NULL,
  `fk_car_spec_id` int(11) NOT NULL,
  `fk_gps_system_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`car_id`, `car_type`, `car_model`, `car_img`, `availability`, `fk_car_spec_id`, `fk_gps_system_id`) VALUES
(7, 'SUV', 'Jeep Cherokee', 'https://a0cf08ce8751764387d1-8df1ebe24a992af98a2f3ca2c1dd9f4c.ssl.cf1.rackcdn.com/1C4PJMBX6KD127618/e00748847e50c30798b0a0c85f83e6b4.jpg', 'available', 1, 1),
(8, 'SUV', 'Audi Q7', 'https://1-photos7.motorcar.com/new-2018-audi-q7-30tfsipremiumplus-12487-17167461-4-1024.jpg', 'available', 2, 2),
(10, 'Economy', 'Citroen C1', 'https://www.nationwidevehiclecontracts.co.uk/m/2/citroen-c1-white-exterior-front-2.jpg', 'rented', 3, 3),
(11, 'Economy', 'Volkswagen Golf', 'https://upload.wikimedia.org/wikipedia/commons/e/e9/2002_Volkswagen_Golf_TDi_1.9_Front.jpg', 'rented', 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `car_specifications`
--

CREATE TABLE `car_specifications` (
  `car_spec_id` int(11) NOT NULL,
  `color` varchar(255) COLLATE utf8_bin NOT NULL,
  `fuel_type` enum('gas','diesel','electric') COLLATE utf8_bin NOT NULL,
  `year_of_production` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `car_specifications`
--

INSERT INTO `car_specifications` (`car_spec_id`, `color`, `fuel_type`, `year_of_production`) VALUES
(1, 'white', 'gas', '2015'),
(2, 'white', 'gas', '2016'),
(3, 'white', 'electric', '2017'),
(4, 'black', 'diesel', '2012');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `fk_user_id` int(255) NOT NULL,
  `fk_rent_id` int(11) NOT NULL,
  `fk_return_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `gps_system_id` int(11) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `fk_location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `gps`
--

INSERT INTO `gps` (`gps_system_id`, `latitude`, `longitude`, `fk_location_id`) VALUES
(1, 48.1763, 16.3267, 1),
(2, 48.2043, 16.3408, 2),
(3, 48.1805, 16.3297, 3),
(4, 48.1845, 16.3361, 4);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `street` varchar(255) COLLATE utf8_bin NOT NULL,
  `city` varchar(255) COLLATE utf8_bin NOT NULL,
  `postal_code` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `street`, `city`, `postal_code`) VALUES
(1, 'spittelbreitengasse', 'Vienna', 1120),
(2, 'burggasse', 'vienna', 1070),
(3, 'meidlinger hauptstrasse', 'vienna', 1120),
(4, 'langenfieldgasse', 'vienna', 1120);

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

CREATE TABLE `office` (
  `office_id` int(11) NOT NULL,
  `fk_location_id` int(255) NOT NULL,
  `fk_car_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `office`
--

INSERT INTO `office` (`office_id`, `fk_location_id`, `fk_car_id`) VALUES
(1, 1, 7),
(2, 3, 8);

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

CREATE TABLE `rent` (
  `rent_id` int(11) NOT NULL,
  `pickup_date` varchar(255) COLLATE utf8_bin NOT NULL,
  `fk_car_id` int(11) NOT NULL,
  `fk_office_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `return`
--

CREATE TABLE `return` (
  `return_id` int(11) NOT NULL,
  `return_date` varchar(255) COLLATE utf8_bin NOT NULL,
  `fk_car_id` int(11) NOT NULL,
  `fk_office_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int(11) NOT NULL,
  `user_name` varchar(60) COLLATE utf8_bin NOT NULL,
  `user_email` varchar(60) COLLATE utf8_bin NOT NULL,
  `user_password` varchar(256) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `user_name`, `user_email`, `user_password`) VALUES
(4, 'Saad', 'saad@gmail.com', '1667327afeddb286cfc59043a24edbb4b4e39d442a1349f71d2210459acd0332'),
(5, 'yosef', 'yosef@gmail.com', 'ab3704dcfd53fb1be5d226ab3cae6a48925d4018b22d2d0b4176f1b7e244b827');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`),
  ADD UNIQUE KEY `fk_car_spec_id` (`fk_car_spec_id`),
  ADD UNIQUE KEY `fk_gps_system_id` (`fk_gps_system_id`);

--
-- Indexes for table `car_specifications`
--
ALTER TABLE `car_specifications`
  ADD PRIMARY KEY (`car_spec_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `fk_user_name` (`fk_user_id`),
  ADD UNIQUE KEY `fk_rent_id` (`fk_rent_id`),
  ADD UNIQUE KEY `fk_return_id` (`fk_return_id`);

--
-- Indexes for table `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`gps_system_id`),
  ADD UNIQUE KEY `fk_location_id` (`fk_location_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`office_id`),
  ADD UNIQUE KEY `fk_location_id` (`fk_location_id`),
  ADD UNIQUE KEY `fk_car_id` (`fk_car_id`);

--
-- Indexes for table `rent`
--
ALTER TABLE `rent`
  ADD PRIMARY KEY (`rent_id`),
  ADD UNIQUE KEY `fk_car_id` (`fk_car_id`),
  ADD UNIQUE KEY `fk_office_id` (`fk_office_id`);

--
-- Indexes for table `return`
--
ALTER TABLE `return`
  ADD PRIMARY KEY (`return_id`),
  ADD UNIQUE KEY `fk_car_id` (`fk_car_id`),
  ADD UNIQUE KEY `fk_office_id` (`fk_office_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `car`
--
ALTER TABLE `car`
  MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `car_specifications`
--
ALTER TABLE `car_specifications`
  MODIFY `car_spec_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gps_system_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `office`
--
ALTER TABLE `office`
  MODIFY `office_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rent`
--
ALTER TABLE `rent`
  MODIFY `rent_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `return`
--
ALTER TABLE `return`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`fk_gps_system_id`) REFERENCES `gps` (`gps_system_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`fk_rent_id`) REFERENCES `rent` (`rent_id`),
  ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`fk_return_id`) REFERENCES `return` (`return_id`),
  ADD CONSTRAINT `customer_ibfk_3` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`userId`);

--
-- Constraints for table `gps`
--
ALTER TABLE `gps`
  ADD CONSTRAINT `gps_ibfk_1` FOREIGN KEY (`fk_location_id`) REFERENCES `location` (`location_id`);

--
-- Constraints for table `office`
--
ALTER TABLE `office`
  ADD CONSTRAINT `office_ibfk_1` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`),
  ADD CONSTRAINT `office_ibfk_2` FOREIGN KEY (`fk_location_id`) REFERENCES `location` (`location_id`);

--
-- Constraints for table `rent`
--
ALTER TABLE `rent`
  ADD CONSTRAINT `rent_ibfk_1` FOREIGN KEY (`fk_office_id`) REFERENCES `office` (`office_id`),
  ADD CONSTRAINT `rent_ibfk_2` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`);

--
-- Constraints for table `return`
--
ALTER TABLE `return`
  ADD CONSTRAINT `return_ibfk_1` FOREIGN KEY (`fk_office_id`) REFERENCES `office` (`office_id`),
  ADD CONSTRAINT `return_ibfk_2` FOREIGN KEY (`fk_car_id`) REFERENCES `car` (`car_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
