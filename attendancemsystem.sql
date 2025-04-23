-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2024 at 10:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendancemsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `Id` int(10) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`Id`, `firstName`, `lastName`, `emailAddress`, `password`) VALUES
(1, 'Admin', '', 'admin@gmail.com', 'c670ddc55c979ea11545f3d52d1b9f5f');

-- --------------------------------------------------------

--
-- Table structure for table `tblattendance`
--

CREATE TABLE `tblattendance` (
  `attendanceID` int(50) NOT NULL,
  `studentRegistrationNumber` varchar(100) NOT NULL,
  `course` varchar(100) NOT NULL,
  `attendanceStatus` varchar(100) NOT NULL,
  `dateMarked` date NOT NULL,
  `unit` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblattendance`
--

INSERT INTO `tblattendance` (`attendanceID`, `studentRegistrationNumber`, `course`, `attendanceStatus`, `dateMarked`, `unit`) VALUES
(554, '21AI011', 'AI', 'Present', '2024-11-14', 'DS'),
(555, '21AI012', 'AI', 'Absent', '2024-11-14', 'DS'),
(556, '21AI014', 'AI', 'Absent', '2024-11-14', 'DS'),
(557, '21AI016', 'AI', 'Absent', '2024-11-14', 'DS'),
(745, '21AI011', 'AI', 'present', '2024-11-21', 'AI'),
(746, '21AI012', 'AI', 'present', '2024-11-21', 'AI'),
(747, '21AI014', 'AI', 'present', '2024-11-21', 'AI'),
(748, '21AI016', 'AI', 'present', '2024-11-21', 'AI'),
(933, '21AI011', 'AI', 'Absent', '2024-11-29', 'DL'),
(934, '21AI012', 'AI', 'Absent', '2024-11-29', 'DL'),
(935, '21AI014', 'AI', 'Absent', '2024-11-29', 'DL'),
(936, '21AI016', 'AI', 'Absent', '2024-11-29', 'DL'),
(961, '21AI011', 'AI', 'Absent', '2024-11-29', 'AI'),
(962, '21AI012', 'AI', 'Absent', '2024-11-29', 'AI'),
(963, '21AI014', 'AI', 'Absent', '2024-11-29', 'AI'),
(964, '21AI016', 'AI', 'Absent', '2024-11-29', 'AI'),
(965, '21AI011', 'AI', 'Absent', '2024-11-29', 'DS'),
(966, '21AI012', 'AI', 'Absent', '2024-11-29', 'DS'),
(967, '21AI014', 'AI', 'Absent', '2024-11-29', 'DS'),
(968, '21AI016', 'AI', 'Absent', '2024-11-29', 'DS'),
(969, '21AI011', 'AI', 'Present', '2024-11-30', 'AI'),
(970, '21AI012', 'AI', 'Present', '2024-11-30', 'AI'),
(971, '21AI014', 'AI', 'Present', '2024-11-30', 'AI'),
(972, '21AI016', 'AI', 'Present', '2024-11-30', 'AI');

-- --------------------------------------------------------

--
-- Table structure for table `tblcourse`
--

CREATE TABLE `tblcourse` (
  `ID` int(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `facultyID` int(50) NOT NULL,
  `dateCreated` date NOT NULL,
  `courseCode` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblcourse`
--

INSERT INTO `tblcourse` (`ID`, `name`, `facultyID`, `dateCreated`, `courseCode`) VALUES
(1, 'Artificial Intelligence', 1, '2024-10-16', 'AI');

-- --------------------------------------------------------

--
-- Table structure for table `tblfaculty`
--

CREATE TABLE `tblfaculty` (
  `Id` int(10) NOT NULL,
  `facultyName` varchar(255) NOT NULL,
  `facultyCode` varchar(50) NOT NULL,
  `dateRegistered` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblfaculty`
--

INSERT INTO `tblfaculty` (`Id`, `facultyName`, `facultyCode`, `dateRegistered`) VALUES
(1, 'Artificial Intelligence', 'AI', '2024-10-16'),
(2, 'Full Stack', 'FS', '2024-10-16'),
(3, 'Data Science', 'DS', '2024-10-16'),
(7, 'Cloud computing', 'CC', '2024-10-16'),
(5, 'Machine learning', 'ML', '2024-10-16'),
(6, 'Data Science', 'DS', '2024-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `tbllecture`
--

CREATE TABLE `tbllecture` (
  `Id` int(10) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNo` varchar(50) NOT NULL,
  `facultyCode` varchar(50) NOT NULL,
  `dateCreated` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbllecture`
--

INSERT INTO `tbllecture` (`Id`, `firstName`, `lastName`, `emailAddress`, `password`, `phoneNo`, `facultyCode`, `dateCreated`) VALUES
(21, 'Ravi', 'S', 'ravi@gmail.com', '15c1469d0495004588968a3bde955397', '9876543345', 'AI', '2024-10-16'),
(22, 'Veeran', 'k', 'veeran@gmail.com', '15c1469d0495004588968a3bde955397', '9876543567', 'FS', '2024-10-16'),
(25, 'Gowtham', 'Raj', 'gowtham@gmail.com', '15c1469d0495004588968a3bde955397', '9876544567', 'DS', '2024-10-16'),
(26, 'Mani', 'H', 'mani@gmail.com', '15c1469d0495004588968a3bde955397', '9876543567', 'CC', '2024-10-16'),
(23, 'Raja', 'R', 'raja@gmail.com', '15c1469d0495004588968a3bde955397', '9876543454', 'ML', '2024-10-16'),
(24, 'Syed', 'M', 'syed@gmail.com', '15c1469d0495004588968a3bde955397', '8765432897', 'DL', '2024-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudents`
--

CREATE TABLE `tblstudents` (
  `Id` int(10) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `registrationNumber` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `faculty` varchar(10) NOT NULL,
  `courseCode` varchar(20) NOT NULL,
  `studentImage1` varchar(300) NOT NULL,
  `studentImage2` varchar(300) NOT NULL,
  `dateRegistered` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstudents`
--

INSERT INTO `tblstudents` (`Id`, `firstName`, `lastName`, `registrationNumber`, `email`, `faculty`, `courseCode`, `studentImage1`, `studentImage2`, `dateRegistered`) VALUES
(11, 'Gokul', '', '21AI011', 'gokul@gmail.com', 'AI\n', 'AI', 'CIT-222-003-2020_image1.png', 'CIT-222-003-2020_image2.png', '2024-10-16'),
(12, 'Gowtham', 'Raj', '21AI012', 'gowtham@gmail.com', 'AI', 'AI', 'CIT-222-002-2020_image1.png', 'CIT-222-002-2020_image2.png', '2024-10-16'),
(14, 'Harish', 'Babu', '21AI014', 'harishbabu@gmail.com', 'AI', 'AI', 'CIT-222-001-2020_image1.png', 'CIT-222-001-2020_image2.png', '2024-10-16'),
(16, 'Jagadeeshwaran', '', '21AI016', 'jagadeeshwaran@gmail.com', 'AI', 'AI', 'CIT-222-001-2020_image1.png', 'CIT-222-001-2020_image2.png', '2024-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `tblunit`
--

CREATE TABLE `tblunit` (
  `ID` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `unitCode` varchar(50) NOT NULL,
  `courseID` varchar(50) NOT NULL,
  `dateCreated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblunit`
--

INSERT INTO `tblunit` (`ID`, `name`, `unitCode`, `courseID`, `dateCreated`) VALUES
(31, 'Artificial Intelligence', 'AI', '1', '2024-10-16'),
(32, 'Data Science', 'DS', '1', '2024-10-16'),
(33, 'Machine Learning', 'ML', '1', '2024-10-16'),
(34, 'Cloud Computing', 'CC', '1', '2024-10-16'),
(35, 'Deep Learning', 'DL', '1', '2024-10-16'),
(36, 'Full Stack', 'FS', '1', '2024-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `tblvenue`
--

CREATE TABLE `tblvenue` (
  `ID` int(10) NOT NULL,
  `className` varchar(50) NOT NULL,
  `facultyCode` varchar(50) NOT NULL,
  `currentStatus` varchar(50) NOT NULL,
  `capacity` int(10) NOT NULL,
  `classification` varchar(50) NOT NULL,
  `dateCreated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblvenue`
--

INSERT INTO `tblvenue` (`ID`, `className`, `facultyCode`, `currentStatus`, `capacity`, `classification`, `dateCreated`) VALUES
(41, '301', 'AI', 'available', 60, 'class', '2024-10-16'),
(42, '302', 'DS', 'available', 60, 'class', '2024-10-16'),
(43, '303', 'ML', 'available', 60, 'class', '2024-10-16'),
(44, '304', 'DL', 'available', 60, 'class', '2024-10-16'),
(45, 'AI LAB', 'AI', 'available', 60, 'computerLab', '2024-10-16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblattendance`
--
ALTER TABLE `tblattendance`
  ADD PRIMARY KEY (`attendanceID`);

--
-- Indexes for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblfaculty`
--
ALTER TABLE `tblfaculty`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tbllecture`
--
ALTER TABLE `tbllecture`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblstudents`
--
ALTER TABLE `tblstudents`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tblunit`
--
ALTER TABLE `tblunit`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tblvenue`
--
ALTER TABLE `tblvenue`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblattendance`
--
ALTER TABLE `tblattendance`
  MODIFY `attendanceID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=981;

--
-- AUTO_INCREMENT for table `tblcourse`
--
ALTER TABLE `tblcourse`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tblfaculty`
--
ALTER TABLE `tblfaculty`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbllecture`
--
ALTER TABLE `tbllecture`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `tblstudents`
--
ALTER TABLE `tblstudents`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `tblunit`
--
ALTER TABLE `tblunit`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `tblvenue`
--
ALTER TABLE `tblvenue`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
