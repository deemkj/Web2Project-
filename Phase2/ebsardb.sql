-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 16, 2025 at 02:54 PM
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
(1, 1, 2, '2025-05-20', '15:00:00', 'Eye pain', 'Pending'),
(2, 2, 3, '2025-07-16', '17:00:00', 'Routine eye check-up', 'Confirmed'),
(3, 3, 5, '2025-02-23', '11:00:00', 'Difficulty seeing ', 'Pending'),
(4, 1, 4, '2025-02-14', '10:00:00', 'Glasses prescription update\r\n', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `uniqueFileName` varchar(10) NOT NULL,
  `SpecialityID` int(11) DEFAULT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `firstName`, `lastName`, `uniqueFileName`, `SpecialityID`, `emailAddress`, `password`) VALUES
(1, 'Joud', 'Alhussayen', 'doc1.jpg', 4, 'joud@gmail.com', 'docpass1'),
(2, 'Sara', 'Almutairi', 'doc3.jpg', 1, 'sara@gmail.com', 'docpass2'),
(3, 'Lama', 'Alotaibi', 'doc4.jpg', 2, 'lama@gmail.com', 'docpass3'),
(4, 'Abdullah', 'Alshammari', 'doc2.jpg', 3, 'abdullah@gmail.com', 'docpass4'),
(5, 'Youssef', 'Alharbi', 'doc5.jpg', 4, 'youssef@gmail.com', 'docpass5'),
(6, 'Saleh', 'Alqahtani', 'doc6.jpg', 5, 'saleh@gmail.com', 'docpass6');

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
(1, 'Lubricating Eye Drops'),
(2, 'Antibiotic Eye Drops'),
(3, 'Anti-inflammatory Gel'),
(4, 'Pain Reliever'),
(5, 'Antihistamine Eye Drops'),
(6, 'Dry Eye Ointment'),
(7, 'Allergy Eye Drops');

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
(1, 'Najla Khalid', 'Alharbi', 'F', '2003-02-05', 'najla@gmail.com', 'pass123'),
(2, 'Nora Saad', 'Alotaibi', 'F', '2010-03-15', 'nora@gmail.com', 'pass456'),
(3, 'Majed Ahmad', 'Alqahtani', 'M', '1980-07-20', 'majed@gmail.com', 'pass789');

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
(1, 1, 2),
(2, 2, 3),
(3, 3, 5),
(4, 4, 6);

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
(1, 'Vision Therapy'),
(2, 'Contact Lenses'),
(3, 'Ocular Disease'),
(4, 'Pediatric Optometry'),
(5, 'General Ophthalmology'),
(6, 'Ophthalmic Surgery'),
(7, 'Retina Specialist'),
(8, 'Oculoplastic Surgery');

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
