-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 14, 2025 at 02:15 AM
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
-- Database: `EbsarDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `Appointment`
--

CREATE TABLE `Appointment` (
  `id` int NOT NULL,
  `PatientID` int NOT NULL,
  `DoctorID` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `reason` varchar(500) NOT NULL,
  `status` enum('Pending','Confirmed','Done') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Appointment`
--

INSERT INTO `Appointment` (`id`, `PatientID`, `DoctorID`, `date`, `time`, `reason`, `status`) VALUES
(1, 1, 2, '2025-05-20', '15:00:00', 'Headache', 'Pending'),
(2, 2, 3, '2025-07-16', '17:00:00', 'Back Pain', 'Confirmed'),
(3, 3, 5, '2025-02-23', '11:00:00', 'Stomach Pain', 'Pending'),
(4, 1, 4, '2025-02-14', '10:00:00', 'Vision Checkup', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `Doctor`
--

CREATE TABLE `Doctor` (
  `id` int NOT NULL,
  `firstName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uniqueFileName` varchar(10) NOT NULL,
  `SpecialityID` int DEFAULT NULL,
  `emailAddress` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Doctor`
--

INSERT INTO `Doctor` (`id`, `firstName`, `lastName`, `uniqueFileName`, `SpecialityID`, `emailAddress`, `password`) VALUES
(1, 'Joud', 'Alhussayen', 'doc1.jpg', 4, 'joud@gmail.com', 'docpass1'),
(2, 'Sara', 'Almutairi', 'doc3.jpg', 1, 'sara@gmail.com', 'docpass2'),
(3, 'Lama', 'Alotaibi', 'doc4.jpg', 2, 'lama@gmail.com', 'docpass3'),
(4, 'Abdullah', 'Alshammari', 'doc2.jpg', 3, 'abdullah@gmail.com', 'docpass4'),
(5, 'Youssef', 'Alharbi', 'doc5.jpg', 4, 'youssef@gmail.com', 'docpass5'),
(6, 'Saleh', 'Alqahtani', 'doc6.jpg', 5, 'saleh@gmail.com', 'docpass6');

-- --------------------------------------------------------

--
-- Table structure for table `Medication`
--

CREATE TABLE `Medication` (
  `id` int NOT NULL,
  `MedicationName` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Medication`
--

INSERT INTO `Medication` (`id`, `MedicationName`) VALUES
(1, 'Lubricating Eye Drops'),
(2, 'Antibiotic Eye Drops'),
(3, 'Anti-inflammatory Gel'),
(4, 'Pain Reliever'),
(5, 'Antihistamine Eye Drops'),
(6, 'Dry Eye Ointment'),
(7, 'Allergy Eye Drops');

-- --------------------------------------------------------

--
-- Table structure for table `Patient`
--

CREATE TABLE `Patient` (
  `id` int NOT NULL,
  `firstName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Gender` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DoB` date NOT NULL,
  `emailAddress` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Patient`
--

INSERT INTO `Patient` (`id`, `firstName`, `lastName`, `Gender`, `DoB`, `emailAddress`, `password`) VALUES
(1, 'Najla Khalid', 'Alharbi', 'F', '2003-02-05', 'najla@gmail.com', 'pass123'),
(2, 'Nora Saad', 'Alotaibi', 'F', '2010-03-15', 'nora@gmail.com', 'pass456'),
(3, 'Majed Ahmad', 'Alqahtani', 'M', '1980-07-20', 'majed@gmail.com', 'pass789');

-- --------------------------------------------------------

--
-- Table structure for table `Prescription`
--

CREATE TABLE `Prescription` (
  `id` int NOT NULL,
  `AppointmentID` int NOT NULL,
  `MedicationID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Prescription`
--

INSERT INTO `Prescription` (`id`, `AppointmentID`, `MedicationID`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 5),
(4, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `Speciality`
--

CREATE TABLE `Speciality` (
  `id` int NOT NULL,
  `speciality` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Speciality`
--

INSERT INTO `Speciality` (`id`, `speciality`) VALUES
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
-- Indexes for table `Appointment`
--
ALTER TABLE `Appointment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- Indexes for table `Doctor`
--
ALTER TABLE `Doctor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniqueFileName` (`uniqueFileName`),
  ADD KEY `SpecialityID` (`SpecialityID`),
  ADD KEY `SpecialityID_2` (`SpecialityID`),
  ADD KEY `SpecialityID_3` (`SpecialityID`);

--
-- Indexes for table `Medication`
--
ALTER TABLE `Medication`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Patient`
--
ALTER TABLE `Patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Prescription`
--
ALTER TABLE `Prescription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `AppointmentID` (`AppointmentID`),
  ADD KEY `MedicationID` (`MedicationID`);

--
-- Indexes for table `Speciality`
--
ALTER TABLE `Speciality`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Appointment`
--
ALTER TABLE `Appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `Doctor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`PatientID`) REFERENCES `Patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Doctor`
--
ALTER TABLE `Doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`SpecialityID`) REFERENCES `Speciality` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Prescription`
--
ALTER TABLE `Prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `Appointment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`MedicationID`) REFERENCES `Medication` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
