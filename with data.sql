-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2020 at 07:21 AM
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

--
-- Dumping data for table `r_course`
--

INSERT INTO `r_course` (`r_course_id`, `r_course_name`, `r_course_display_status`) VALUES
(1, 'BSIT', 1),
(2, 'BBTE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `r_document_category`
--

CREATE TABLE `r_document_category` (
  `r_document_category_id` int(11) NOT NULL,
  `r_document_category_description` varchar(100) NOT NULL,
  `r_document_category_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `r_document_category`
--

INSERT INTO `r_document_category` (`r_document_category_id`, `r_document_category_description`, `r_document_category_display_status`) VALUES
(1, 'For OSAS', 1),
(2, 'For Registrar', 1);

-- --------------------------------------------------------

--
-- Table structure for table `r_document_type`
--

CREATE TABLE `r_document_type` (
  `r_document_type_id` int(11) NOT NULL,
  `r_document_name` varchar(200) NOT NULL,
  `r_document_display_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `r_document_type`
--

INSERT INTO `r_document_type` (`r_document_type_id`, `r_document_name`, `r_document_display_status`) VALUES
(1, 'Grades', 1),
(2, 'TOR', 1);

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

--
-- Dumping data for table `r_employee`
--

INSERT INTO `r_employee` (`r_employee_id`, `r_employee_name`, `r_employee_office_position_id`, `r_employee_address`, `r_employee_date_of_birth`, `r_employee_display_status`) VALUES
(1, 'John Pedro', 2, 'Somewhere in qc', '1995-02-19', 1);

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

--
-- Dumping data for table `r_office`
--

INSERT INTO `r_office` (`r_office_id`, `r_office_description`, `r_office_type`, `r_office_display_status`) VALUES
(1, 'for the students', 'Office of student affairs', 1),
(2, 'Sample description', 'Registrar', 1);

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

--
-- Dumping data for table `r_office_position`
--

INSERT INTO `r_office_position` (`r_office_position_id`, `r_office_position_name`, `r_office_position_office_id`, `r_office_position_display_status`) VALUES
(1, 'OSAS Head', 1, 1),
(2, 'Registrar', 2, 1);

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

--
-- Dumping data for table `r_student`
--

INSERT INTO `r_student` (`r_student_id`, `r_student_name`, `r_student_number`, `r_student_course_id`, `r_student_section`, `r_student_date_of_birth`, `r_student_display_status`) VALUES
(1, 'Juan Dela Cruz', '2020-00001-cm-0', 1, '4-1', '2000-09-16', 1),
(2, 'Wally Go', '2013-00001-cm-0', 2, '1-2', '2000-03-17', 1);

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

--
-- Dumping data for table `t_document`
--

INSERT INTO `t_document` (`t_document_id`, `t_document_code`, `t_document_personnel_details_id`, `t_document_date`, `t_document_type_id`, `t_document_category_id`, `t_document_remarks`, `t_document_display_status`) VALUES
(1, 'DOC00001', 1, '2020-03-05 00:48:55', 2, 2, 'Pending', 0),
(2, 'DOC00002', 2, '2020-03-28 00:50:45', 2, 2, 'Pending', 0),
(3, 'DOC00003', 9, '2020-03-28 10:59:07', 2, 1, 'Reject', 0),
(4, 'DOC00004', 10, '2020-03-28 10:59:19', 2, 1, 'Reject', 0),
(5, 'DOC00005', 11, '2020-03-28 10:59:25', 2, 1, 'Reject', 0),
(6, 'DOC00006', 12, '2020-03-28 10:59:50', 2, 1, 'Reject', 0),
(7, 'DOC00007', 13, '2020-03-28 11:01:21', 1, 2, 'Reject', 0),
(8, 'DOC00008', 14, '2020-03-28 11:02:39', 1, 2, 'Approve', 0),
(9, 'DOC00009', 15, '2020-03-28 11:21:59', 2, 1, 'Reject', 1),
(10, 'DOC00010', 16, '2020-03-28 11:27:07', 1, 2, 'Pending', 1),
(11, 'DOC00011', 17, '2020-03-28 12:13:47', 1, 2, 'Approve', 1),
(12, 'DOC00012', 18, '2020-03-28 12:24:27', 1, 1, 'Pending', 0),
(13, 'DOC00013', 19, '2020-03-28 12:47:09', 1, 2, 'Pending', 1),
(14, 'DOC00014', 20, '2020-03-28 12:49:11', 1, 1, 'Reject', 0),
(15, 'DOC00015', 21, '2020-03-28 13:26:55', 1, 2, 'Approve', 1),
(16, 'DOC00016', 22, '2020-03-28 13:37:07', 1, 1, 'Pending', 1),
(17, 'DOC00017', 23, '2020-03-28 13:38:53', 1, 1, 'Pending', 1),
(18, 'DOC00018', 24, '2020-03-28 13:41:14', 1, 1, 'Pending', 1),
(19, 'DOC00019', 25, '2020-03-28 13:43:35', 1, 1, 'Approve', 1),
(20, 'DOC00020', 26, '2020-03-28 13:45:41', 1, 2, 'Reject', 1),
(21, 'DOC00021', 27, '2020-03-28 13:47:31', 2, 1, 'Approve', 0);

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
-- Dumping data for table `t_document_personnel_details`
--

INSERT INTO `t_document_personnel_details` (`t_document_personnel_details_id`, `t_document_personnel_details_receiver_type`, `t_document_personnel_details_student_id`, `t_document_personnel_details_employee_id`) VALUES
(1, 'Student', 1, 1),
(2, 'Employee', 2, 1),
(3, 'Student', 2, 1),
(4, 'Employee', 2, 1),
(5, 'Student', 1, 1),
(6, 'Student', 1, 1),
(7, 'Student', 1, 1),
(8, 'Student', 1, 1),
(9, 'Student', 1, 1),
(10, 'Student', 1, 1),
(11, 'Student', 1, 1),
(12, 'Student', 1, 1),
(13, 'Student', 2, 1),
(14, 'Student', 1, 1),
(15, 'Student', 1, 1),
(16, 'Student', 2, 1),
(17, 'Employee', 1, 1),
(18, 'Student', 1, 1),
(19, 'Student', 2, 1),
(20, 'Employee', 2, 1),
(21, 'Employee', 1, 1),
(22, 'Student', 1, 1),
(23, 'Student', 1, 1),
(24, 'Student', 2, 1),
(25, 'Student', 1, 1),
(26, 'Student', 2, 1),
(27, 'Student', 1, 1);

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
  MODIFY `r_course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_document_category`
--
ALTER TABLE `r_document_category`
  MODIFY `r_document_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_document_type`
--
ALTER TABLE `r_document_type`
  MODIFY `r_document_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_employee`
--
ALTER TABLE `r_employee`
  MODIFY `r_employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `r_office`
--
ALTER TABLE `r_office`
  MODIFY `r_office_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_office_position`
--
ALTER TABLE `r_office_position`
  MODIFY `r_office_position_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_student`
--
ALTER TABLE `r_student`
  MODIFY `r_student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_document`
--
ALTER TABLE `t_document`
  MODIFY `t_document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `t_document_personnel_details`
--
ALTER TABLE `t_document_personnel_details`
  MODIFY `t_document_personnel_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
