-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2020 at 07:22 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dts`
--

-- --------------------------------------------------------

--
-- Table structure for table `r_course`
--

CREATE TABLE `r_course` (
  `r_course_id` int(11) NOT NULL,
  `r_course_name` varchar(100) NOT NULL,
  `r_course_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_document_category`
--

CREATE TABLE `r_document_category` (
  `r_document_category_id` int(11) NOT NULL,
  `r_document_category_description` varchar(100) NOT NULL,
  `r_document_category_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_document_type`
--

CREATE TABLE `r_document_type` (
  `r_document_type_id` int(11) NOT NULL,
  `r_document_name` varchar(200) NOT NULL,
  `r_document_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_employee`
--

CREATE TABLE `r_employee` (
  `r_employee_id` int(11) NOT NULL,
  `r_employee_name` varchar(100) NOT NULL,
  `r_employee_office_position_id` int(11) NOT NULL,
  `r_employee_address` varchar(100) NOT NULL,
  `r_employee_date_of_birth` date NOT NULL,
  `r_employee_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_office`
--

CREATE TABLE `r_office` (
  `r_office_id` int(11) NOT NULL,
  `r_office_description` varchar(100) NOT NULL,
  `r_office_type` varchar(100) NOT NULL,
  `r_office_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_office_position`
--

CREATE TABLE `r_office_position` (
  `r_office_position_id` int(11) NOT NULL,
  `r_office_position_name` varchar(100) NOT NULL,
  `r_office_position_office_id` int(11) NOT NULL,
  `r_office_position_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `r_student`
--

CREATE TABLE `r_student` (
  `r_student_id` int(11) NOT NULL,
  `r_student_name` varchar(100) NOT NULL,
  `r_student_number` varchar(100) NOT NULL,
  `r_student_course_id` int(11) NOT NULL,
  `r_student_section` varchar(100) NOT NULL,
  `r_student_date_of_birth` date NOT NULL,
  `r_student_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_document`
--

CREATE TABLE `t_document` (
  `t_document_id` int(11) NOT NULL,
  `t_document_code` varchar(100) DEFAULT NULL,
  `t_document_personnel_details_id` int(11) NOT NULL,
  `t_document_date` datetime NOT NULL DEFAULT current_timestamp(),
  `t_document_type_id` int(11) NOT NULL,
  `t_document_category_id` int(11) NOT NULL,
  `t_document_remarks` enum('Pending','Approve','Reject','') NOT NULL DEFAULT 'Pending',
  `t_document_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_document_personnel_details`
--

CREATE TABLE `t_document_personnel_details` (
  `t_document_personnel_details_id` int(11) NOT NULL,
  `t_document_personnel_details_receiver_type` enum('Student','Employee') DEFAULT 'Student',
  `t_document_personnel_details_student_id` int(11) NOT NULL,
  `t_document_personnel_details_employee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `r_course`
--
ALTER TABLE `r_course`
  ADD PRIMARY KEY (`r_course_id`);

--
-- Indexes for table `r_document_category`
--
ALTER TABLE `r_document_category`
  ADD PRIMARY KEY (`r_document_category_id`);

--
-- Indexes for table `r_document_type`
--
ALTER TABLE `r_document_type`
  ADD PRIMARY KEY (`r_document_type_id`);

--
-- Indexes for table `r_employee`
--
ALTER TABLE `r_employee`
  ADD PRIMARY KEY (`r_employee_id`),
  ADD KEY `r_employee_office_position_id` (`r_employee_office_position_id`);

--
-- Indexes for table `r_office`
--
ALTER TABLE `r_office`
  ADD PRIMARY KEY (`r_office_id`);

--
-- Indexes for table `r_office_position`
--
ALTER TABLE `r_office_position`
  ADD PRIMARY KEY (`r_office_position_id`),
  ADD KEY `t_office_position_office_id` (`r_office_position_office_id`);

--
-- Indexes for table `r_student`
--
ALTER TABLE `r_student`
  ADD PRIMARY KEY (`r_student_id`),
  ADD KEY `r_student_course_id` (`r_student_course_id`);

--
-- Indexes for table `t_document`
--
ALTER TABLE `t_document`
  ADD PRIMARY KEY (`t_document_id`),
  ADD UNIQUE KEY `t_document_code` (`t_document_code`),
  ADD KEY `t_document_type_id` (`t_document_type_id`),
  ADD KEY `t_document_category_id` (`t_document_category_id`),
  ADD KEY `t_document_personnel_details_id` (`t_document_personnel_details_id`);

--
-- Indexes for table `t_document_personnel_details`
--
ALTER TABLE `t_document_personnel_details`
  ADD PRIMARY KEY (`t_document_personnel_details_id`),
  ADD KEY `t_document_personnel_details_employee_id` (`t_document_personnel_details_employee_id`),
  ADD KEY `t_document_personnel_details_student_id` (`t_document_personnel_details_student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `r_course`
--
ALTER TABLE `r_course`
  MODIFY `r_course_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_document_category`
--
ALTER TABLE `r_document_category`
  MODIFY `r_document_category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_document_type`
--
ALTER TABLE `r_document_type`
  MODIFY `r_document_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_employee`
--
ALTER TABLE `r_employee`
  MODIFY `r_employee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_office`
--
ALTER TABLE `r_office`
  MODIFY `r_office_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_office_position`
--
ALTER TABLE `r_office_position`
  MODIFY `r_office_position_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_student`
--
ALTER TABLE `r_student`
  MODIFY `r_student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_document`
--
ALTER TABLE `t_document`
  MODIFY `t_document_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_document_personnel_details`
--
ALTER TABLE `t_document_personnel_details`
  MODIFY `t_document_personnel_details_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `r_employee`
--
ALTER TABLE `r_employee`
  ADD CONSTRAINT `r_employee_ibfk_1` FOREIGN KEY (`r_employee_office_position_id`) REFERENCES `r_office_position` (`r_office_position_id`);

--
-- Constraints for table `r_office_position`
--
ALTER TABLE `r_office_position`
  ADD CONSTRAINT `r_office_position_ibfk_1` FOREIGN KEY (`r_office_position_office_id`) REFERENCES `r_office` (`r_office_id`);

--
-- Constraints for table `r_student`
--
ALTER TABLE `r_student`
  ADD CONSTRAINT `r_student_ibfk_1` FOREIGN KEY (`r_student_course_id`) REFERENCES `r_course` (`r_course_id`);

--
-- Constraints for table `t_document`
--
ALTER TABLE `t_document`
  ADD CONSTRAINT `t_document_ibfk_1` FOREIGN KEY (`t_document_type_id`) REFERENCES `r_document_type` (`r_document_type_id`),
  ADD CONSTRAINT `t_document_ibfk_2` FOREIGN KEY (`t_document_category_id`) REFERENCES `r_document_category` (`r_document_category_id`),
  ADD CONSTRAINT `t_document_ibfk_3` FOREIGN KEY (`t_document_personnel_details_id`) REFERENCES `t_document_personnel_details` (`t_document_personnel_details_id`);

--
-- Constraints for table `t_document_personnel_details`
--
ALTER TABLE `t_document_personnel_details`
  ADD CONSTRAINT `t_document_personnel_details_ibfk_1` FOREIGN KEY (`t_document_personnel_details_employee_id`) REFERENCES `r_employee` (`r_employee_id`),
  ADD CONSTRAINT `t_document_personnel_details_ibfk_2` FOREIGN KEY (`t_document_personnel_details_student_id`) REFERENCES `r_student` (`r_student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
