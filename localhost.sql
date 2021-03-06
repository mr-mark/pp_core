-- phpMyAdmin SQL Dump
-- version 3.2.2.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 09, 2010 at 08:15 PM
-- Server version: 5.1.37
-- PHP Version: 5.2.10-2ubuntu6.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `parspake`
--
CREATE DATABASE `parspake` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `parspake`;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(45) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `type` tinyint(4) NOT NULL,
  `message` text NOT NULL,
  `checked` tinyint(1) unsigned NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=82 ;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `from`, `to`, `date`, `ip`, `status`, `type`, `message`, `checked`, `title`) VALUES
(81, 1, 3, '2010-12-09 17:47:27', '127.0.0.3', 0, 1, 'درخواست دوستی از طرف <a href="__USER_URL__">__USER_NAME__</a>  <BR/>\nدر صورت تمایل <a href="__ACCEPT_URL">قبول کن</a> در غیر ابنصورت درخواست را <a href="__REJECT_URL__">رد کن</a>', 0, 'درخواست دوستی'),
(80, 1, 3, '2010-12-09 17:15:10', '127.0.0.3', 0, 1, 'درخواست دوستی از طرف <a href="__USER_URL__">__USER_NAME__</a>  <BR/>\nدر صورت تمایل <a href="__ACCEPT_URL">قبول کن</a> در غیر ابنصورت درخواست را <a href="__REJECT_URL__">رد کن</a>', 0, 'درخواست دوستی');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `city` varchar(255) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `sex`, `city`, `photo`, `birthdate`) VALUES
(1, 1, 1, 'esfehan', '', '0000-00-00'),
(2, 2, 2, 'city2', '', '0000-00-00'),
(3, 3, 1, 'city3', '', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `relations`
--

CREATE TABLE IF NOT EXISTS `relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inviter` int(10) unsigned NOT NULL,
  `guest` int(10) unsigned NOT NULL,
  `invitation_date` datetime NOT NULL,
  `status` tinyint(1) unsigned zerofill NOT NULL COMMENT '0:wait, 1:accept, 2:reject',
  `answer_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=97 ;

--
-- Dumping data for table `relations`
--

INSERT INTO `relations` (`id`, `inviter`, `guest`, `invitation_date`, `status`, `answer_date`) VALUES
(90, 3, 2, '0000-00-00 00:00:00', 1, '0000-00-00 00:00:00'),
(95, 1, 3, '2010-12-09 17:47:27', 1, '2010-12-09 19:30:06');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(50) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('b0e18e65870f97a32d94ca67d9e54321', '127.0.0.3', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8', 1291912867, 'a:16:{s:2:"id";s:1:"1";s:10:"first_name";s:6:"javad2";s:9:"last_name";s:7:"mehrabi";s:5:"email";s:19:"example@example.com";s:8:"password";s:32:"1a79a4d60de6718e8e5b326e338ae533";s:3:"sex";s:1:"1";s:15:"registration_ip";s:9:"127.0.0.3";s:17:"registration_date";s:19:"2010-11-23 20:22:38";s:6:"logins";s:2:"16";s:13:"last_login_ip";s:0:"";s:15:"last_login_date";s:19:"2010-12-09 17:48:16";s:7:"user_id";s:1:"1";s:4:"city";s:7:"esfehan";s:5:"photo";s:0:"";s:9:"birthdate";s:10:"0000-00-00";s:9:"logged_in";s:1:"1";}'),
('27b715e0bde669c5f0b0976e380565c3', '127.0.0.3', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8', 1291904260, 'a:16:{s:2:"id";s:1:"1";s:10:"first_name";s:6:"javad2";s:9:"last_name";s:7:"mehrabi";s:5:"email";s:19:"example@example.com";s:8:"password";s:32:"1a79a4d60de6718e8e5b326e338ae533";s:3:"sex";s:1:"1";s:15:"registration_ip";s:9:"127.0.0.3";s:17:"registration_date";s:19:"2010-11-23 20:22:38";s:6:"logins";s:2:"15";s:13:"last_login_ip";s:0:"";s:15:"last_login_date";s:19:"2010-12-09 15:35:40";s:7:"user_id";s:1:"1";s:4:"city";s:7:"esfehan";s:5:"photo";s:0:"";s:9:"birthdate";s:10:"0000-00-00";s:9:"logged_in";s:1:"1";}'),
('e5e16116b44d92c6b40b63b694384711', '127.0.0.3', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8', 1291904126, 'a:16:{s:2:"id";s:1:"1";s:10:"first_name";s:6:"javad2";s:9:"last_name";s:7:"mehrabi";s:5:"email";s:19:"example@example.com";s:8:"password";s:32:"1a79a4d60de6718e8e5b326e338ae533";s:3:"sex";s:1:"1";s:15:"registration_ip";s:9:"127.0.0.3";s:17:"registration_date";s:19:"2010-11-23 20:22:38";s:6:"logins";s:2:"14";s:13:"last_login_ip";s:0:"";s:15:"last_login_date";s:19:"2010-12-07 16:29:50";s:7:"user_id";s:1:"1";s:4:"city";s:7:"esfehan";s:5:"photo";s:0:"";s:9:"birthdate";s:10:"0000-00-00";s:9:"logged_in";s:1:"1";}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `email` varchar(250) CHARACTER SET utf8 NOT NULL,
  `password` varchar(250) CHARACTER SET utf8 NOT NULL,
  `sex` tinyint(1) unsigned zerofill NOT NULL COMMENT '0:male',
  `registration_ip` varchar(45) CHARACTER SET utf8 NOT NULL,
  `registration_date` datetime NOT NULL,
  `logins` int(10) unsigned NOT NULL,
  `last_login_ip` varchar(45) CHARACTER SET utf8 NOT NULL,
  `last_login_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `sex`, `registration_ip`, `registration_date`, `logins`, `last_login_ip`, `last_login_date`) VALUES
(1, 'javad2', 'mehrabi', 'example@example.com', '1a79a4d60de6718e8e5b326e338ae533', 0, '127.0.0.3', '2010-11-23 20:22:38', 17, '', '2010-12-09 17:48:30'),
(2, 'first_name2', 'last_name2', 'example2@example2.com', '66b375b08fc869632935c9e6a9c7f8da', 0, '127.0.0.3', '2010-11-29 16:31:38', 1, '', '2010-11-29 16:32:26'),
(3, 'first_name3', 'last_name3', 'example3@example3.com', 'c458fb5edb84c54f4dc42804622aa0c5', 0, '127.0.0.3', '2010-11-29 17:02:10', 0, '', '0000-00-00 00:00:00');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
