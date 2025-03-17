-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 17, 2025 at 04:30 PM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebsardb`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `PatientID` int(11) NOT NULL,
  `DoctorID` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `reason` varchar(500) NOT NULL,
  `status` enum('Pending','Confirmed','Done') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `PatientID`, `DoctorID`, `date`, `time`, `reason`, `status`) VALUES
(1111, 1111, 2222, '2025-05-20', '15:00:00', 'Eye pain', 'Pending'),
(2222, 2222, 3333, '2025-07-16', '17:00:00', 'Routine eye check-up', 'Confirmed'),
(3333, 3333, 2222, '2025-02-23', '11:00:00', 'Difficulty seeing ', 'Pending'),
(4444, 1111, 4444, '2025-02-14', '10:00:00', 'Glasses prescription update\r\n', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `uniqueFileName` varchar(300) NOT NULL,
  `SpecialityID` int(11) DEFAULT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `firstName`, `lastName`, `uniqueFileName`, `SpecialityID`, `emailAddress`, `password`) VALUES
(1111, 'Joud', 'Alhussayen', 'doc_67d84ac73897e.jpg', 4444, 'joud@gmail.com', '$2y$10$sc06TLyrK3OY/VuqnW.bF.8GLB9anxabV5sTEdJpjyU3P1Mt.abIi'),
(2222, 'Sara', 'Almutairi', 'doc_67d84bd25a077.jpg', 2222, 'sara@gmail.com', '$2y$10$gQOhedurxX1c6xisbjbBGOqKrLHGMgCAt55Q2DJRSDERFndeA.2ja'),
(3333, 'Abdullah', 'Alshammari', 'doc_67d84c3f6d011.jpg', 2222, 'abdullah@gmail.com', '$2y$10$2ioMkB6OoQUvB82dJDP9PO0pT8EaohkdGfxqM3XbQ9BDnbffjxCMK'),
(4444, 'Youssef', 'Alharbi', 'doc_67d84ccc4d784.jpg', 5555, 'youssef@gmail.com', '$2y$10$YBs6nCY9/FBAkbv475VZuOQDpbsDrcXC0vvVwdO8IkXydqXywoavy');

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `id` int(11) NOT NULL,
  `MedicationName` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medication`
--

INSERT INTO `medication` (`id`, `MedicationName`) VALUES
(1111, 'Lubricating Eye Drops'),
(2222, 'Antibiotic Eye Drops'),
(3333, 'Anti-inflammatory Gel'),
(4444, 'Pain Reliever'),
(5555, 'Antihistamine Eye Drops'),
(6666, 'Dry Eye Ointment'),
(7777, 'Allergy Eye Drops');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `Gender` varchar(1) NOT NULL,
  `DOB` date NOT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `firstName`, `lastName`, `Gender`, `DOB`, `emailAddress`, `password`) VALUES
(1111, 'Najla Khalid', 'Alharbi', 'F', '2003-02-05', 'najla@gmail.com', '$2y$10$rtXC5i8FSIAGydN2yfYjuuCfr3LLRvd6dU/kaHwZ7ESs1g2Hgn3Be'),
(2222, 'Nora Saad', 'Alotaibi', 'F', '2010-03-15', 'nora@gmail.com', '$2y$10$EklkFpaCurviZ8KtbS5i3.5FknBhGPBFbvMQwH/0R3MC.N/ocktni'),
(3333, 'Majed Ahmad', 'Alqahtani', 'M', '1980-07-20', 'majed@gmail.com', '$2y$10$tITOteA.wYbyhfVO3quVLeT5L2HNUWkSGmsQA5rUDGw/YcTA6n8Ci');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE `prescription` (
  `id` int(11) NOT NULL,
  `AppointmentID` int(11) NOT NULL,
  `MedicationID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`id`, `AppointmentID`, `MedicationID`) VALUES
(1111, 1111, 2222),
(2222, 2222, 3333),
(3333, 3333, 5555),
(4444, 4444, 6666);

-- --------------------------------------------------------

--
-- Table structure for table `speciality`
--

CREATE TABLE `speciality` (
  `id` int(11) NOT NULL,
  `speciality` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `speciality`
--

INSERT INTO `speciality` (`id`, `speciality`) VALUES
(1111, 'Vision Therapy'),
(2222, 'Contact Lenses'),
(3333, 'Ocular Disease'),
(4444, 'Pediatric Optometry'),
(5555, 'General Ophthalmology');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SpecialityID` (`SpecialityID`);

--
-- Indexes for table `medication`
--
ALTER TABLE `medication`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prescription`
--
ALTER TABLE `prescription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `AppointmentID` (`AppointmentID`),
  ADD KEY `MedicationID` (`MedicationID`);

--
-- Indexes for table `speciality`
--
ALTER TABLE `speciality`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4447;

--
-- AUTO_INCREMENT for table `medication`
--
ALTER TABLE `medication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7778;

--
-- AUTO_INCREMENT for table `prescription`
--
ALTER TABLE `prescription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4445;

--
-- AUTO_INCREMENT for table `speciality`
--
ALTER TABLE `speciality`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8889;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
