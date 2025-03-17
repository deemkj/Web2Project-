-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 17, 2025 at 03:29 AM
-- Server version: 8.0.40
-- PHP Version: 8.3.14

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
  `id` int NOT NULL,
  `PatientID` int NOT NULL,
  `DoctorID` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `reason` varchar(500) NOT NULL,
  `status` enum('Pending','Confirmed','Done') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `PatientID`, `DoctorID`, `date`, `time`, `reason`, `status`) VALUES
(1111, 1111, 2222, '2025-05-20', '15:00:00', 'Eye pain', 'Pending'),
(2222, 2222, 3333, '2025-07-16', '17:00:00', 'Routine eye check-up', 'Confirmed'),
(3333, 3333, 5555, '2025-02-23', '11:00:00', 'Difficulty seeing ', 'Pending'),
(4444, 1111, 4444, '2025-02-14', '10:00:00', 'Glasses prescription update\r\n', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `uniqueFileName` varchar(10) NOT NULL,
  `SpecialityID` int DEFAULT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `firstName`, `lastName`, `uniqueFileName`, `SpecialityID`, `emailAddress`, `password`) VALUES
(1111, 'Joud', 'Alhussayen', 'doc1.jpg', 4444, 'joud@gmail.com', 'docpass1'),
(2222, 'Sara', 'Almutairi', 'doc3.jpg', 1111, 'sara@gmail.com', 'docpass2'),
(3333, 'Lama', 'Alotaibi', 'doc4.jpg', 2222, 'lama@gmail.com', 'docpass3'),
(4444, 'Abdullah', 'Alshammari', 'doc2.jpg', 3333, 'abdullah@gmail.com', 'docpass4'),
(5555, 'Youssef', 'Alharbi', 'doc5.jpg', 4444, 'youssef@gmail.com', 'docpass5'),
(6666, 'Saleh', 'Alqahtani', 'doc6.jpg', 5555, 'saleh@gmail.com', 'docpass6');

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `id` int NOT NULL,
  `MedicationName` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
  `id` int NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `Gender` varchar(1) NOT NULL,
  `DOB` date NOT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `firstName`, `lastName`, `Gender`, `DOB`, `emailAddress`, `password`) VALUES
(1111, 'Najla Khalid', 'Alharbi', 'F', '2003-02-05', 'najla@gmail.com', 'pass123'),
(2222, 'Nora Saad', 'Alotaibi', 'F', '2010-03-15', 'nora@gmail.com', 'pass456'),
(3333, 'Majed Ahmad', 'Alqahtani', 'M', '1980-07-20', 'majed@gmail.com', 'pass789');

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE `prescription` (
  `id` int NOT NULL,
  `AppointmentID` int NOT NULL,
  `MedicationID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
  `id` int NOT NULL,
  `speciality` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `speciality`
--

INSERT INTO `speciality` (`id`, `speciality`) VALUES
(1111, 'Vision Therapy'),
(2222, 'Contact Lenses'),
(3333, 'Ocular Disease'),
(4444, 'Pediatric Optometry'),
(5555, 'General Ophthalmology'),
(6666, 'Ophthalmic Surgery'),
(7777, 'Retina Specialist'),
(8888, 'Oculoplastic Surgery');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4447;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6667;

--
-- AUTO_INCREMENT for table `medication`
--
ALTER TABLE `medication`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7778;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3334;

--
-- AUTO_INCREMENT for table `prescription`
--
ALTER TABLE `prescription`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4445;

--
-- AUTO_INCREMENT for table `speciality`
--
ALTER TABLE `speciality`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8889;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
