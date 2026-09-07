-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Wrz 07, 2026 at 02:38 AM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `musicker`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `genre`
--

CREATE TABLE `genre` (
  `idgenre` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`idgenre`, `name`) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Rap'),
(4, 'Edm'),
(5, 'Soundtrack');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `list`
--

CREATE TABLE `list` (
  `idlist` int(11) NOT NULL,
  `rental_idrental` int(11) NOT NULL,
  `song_idsong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`idlist`, `rental_idrental`, `song_idsong`) VALUES
(9, 5, 1),
(10, 5, 3),
(11, 6, 2),
(12, 6, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `permission`
--

CREATE TABLE `permission` (
  `idpermission` int(11) NOT NULL,
  `users_iduser` int(11) NOT NULL,
  `role_idrole` int(11) NOT NULL,
  `whengiven` timestamp NULL DEFAULT current_timestamp(),
  `whenrevoked` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`idpermission`, `users_iduser`, `role_idrole`, `whengiven`, `whenrevoked`) VALUES
(1, 14, 2, '2026-09-07 00:14:59', NULL),
(2, 14, 1, '2026-09-07 00:15:14', NULL),
(3, 14, 3, '2026-09-07 00:15:22', NULL),
(4, 37, 2, '2026-09-07 00:29:30', NULL),
(5, 38, 3, '2026-09-07 00:29:57', NULL),
(6, 39, 1, '2026-09-07 00:30:15', NULL),
(7, 40, 1, '2026-09-07 00:36:01', '2026-09-07 00:36:29');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rental`
--

CREATE TABLE `rental` (
  `idrental` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  `whenrented` timestamp NULL DEFAULT NULL,
  `whenends` timestamp NULL DEFAULT NULL,
  `issent` tinyint(1) DEFAULT NULL,
  `isaccepted` tinyint(1) DEFAULT NULL,
  `howlong` int(11) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rental`
--

INSERT INTO `rental` (`idrental`, `user_iduser`, `whenrented`, `whenends`, `issent`, `isaccepted`, `howlong`, `cost`) VALUES
(5, 39, '2026-09-07 00:32:42', '2026-09-07 04:32:42', 1, 1, 4, 28),
(6, 14, '2026-09-07 00:34:16', '2026-09-07 12:34:16', 1, 1, 12, 108);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role`
--

CREATE TABLE `role` (
  `idrole` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `whencreated` timestamp NULL DEFAULT current_timestamp(),
  `whendisabled` timestamp NULL DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`idrole`, `name`, `whencreated`, `whendisabled`, `isactive`) VALUES
(1, 'user', '2023-05-28 17:20:48', NULL, 1),
(2, 'admin', '2023-05-28 17:23:51', NULL, 1),
(3, 'worker', '2023-05-28 17:47:19', NULL, 1);

--
-- Wyzwalacze `role`
--
DELIMITER $$
CREATE TRIGGER `disabledTrigger` BEFORE UPDATE ON `role` FOR EACH ROW BEGIN
	IF(NEW.isactive = 0) THEN
    SET NEW.whendisabled = CURRENT_TIMESTAMP;
    ELSE
    SET NEW.whendisabled = null;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `song`
--

CREATE TABLE `song` (
  `idsong` int(11) NOT NULL,
  `artist` varchar(30) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `genre_idgenre` int(11) NOT NULL,
  `price` float DEFAULT NULL,
  `whenpublished` date DEFAULT NULL,
  `isavailable` tinyint(1) DEFAULT NULL,
  `file` varchar(50) DEFAULT NULL,
  `cover` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `song`
--

INSERT INTO `song` (`idsong`, `artist`, `title`, `genre_idgenre`, `price`, `whenpublished`, `isavailable`, `file`, `cover`) VALUES
(1, 'Kevin MacLeod', 'Cool Hard Facts', 1, 5, '2006-01-01', 1, 'kevin_macleod_cool_hard_facts.mp3', 'kevin_macleod_cool_hard_facts.jpg'),
(2, 'Kevin MacLeod', 'Raving Energy (faster)', 4, 4, '2019-06-11', 1, 'kevin_macleod_raving_energy_(faster).mp3', 'kevin_macleod_raving_energy_(faster).jpg'),
(3, 'Kevin MacLeod', 'Adventures in Adventureland', 5, 2, '2021-09-20', 1, 'kevin_macleod_adventures_in_adventureland.mp3', 'kevin_macleod_adventures_in_adventureland.jpg');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `iduser` int(11) NOT NULL,
  `login` varchar(15) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `whocreated` int(11) DEFAULT NULL,
  `whencreated` timestamp NULL DEFAULT current_timestamp(),
  `wholastmodified` int(11) DEFAULT NULL,
  `whenlastmodified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`iduser`, `login`, `password`, `whocreated`, `whencreated`, `wholastmodified`, `whenlastmodified`) VALUES
(14, 'all', '$2y$10$SRyh4y0ETecvKME.F96N2uMfxM.1GB9JWnsqXvrsbbTcMbIS2n79.', 14, '2023-05-29 16:27:41', 14, '2026-09-07 00:29:02'),
(37, 'admin', '$2y$10$oymTjP08BzqHmyH.yFrrbu9I/SnNJNvzAenrfvQadHdF3QevZRozW', 14, '2026-09-07 00:29:30', 14, '2026-09-07 00:29:30'),
(38, 'worker', '$2y$10$8J/j7qJkeg4rdDGgUTAxs.rNUo9YcAuIxyigxGImU7uHSqsRKIWre', 14, '2026-09-07 00:29:57', 14, '2026-09-07 00:29:57'),
(39, 'user', '$2y$10$iIkAebjhEDCrimoTESYQf.1V1tIJcetv7YLPkXtStKx6YheD.7r86', 14, '2026-09-07 00:30:15', 14, '2026-09-07 00:30:15'),
(40, 'inactive', '$2y$10$J5X8z1mmvaeuDRXHivRlC.35QSadN1/1TAkbq8Z1/MvNOOTesPmAu', 37, '2026-09-07 00:36:01', 37, '2026-09-07 00:36:01');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`idgenre`);

--
-- Indeksy dla tabeli `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`idlist`,`rental_idrental`,`song_idsong`) USING BTREE,
  ADD KEY `cons8` (`song_idsong`),
  ADD KEY `cons7` (`rental_idrental`);

--
-- Indeksy dla tabeli `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`idpermission`,`users_iduser`,`role_idrole`) USING BTREE,
  ADD KEY `cons13` (`role_idrole`),
  ADD KEY `cons14` (`users_iduser`);

--
-- Indeksy dla tabeli `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`idrental`),
  ADD KEY `cons6` (`user_iduser`);

--
-- Indeksy dla tabeli `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idrole`);

--
-- Indeksy dla tabeli `song`
--
ALTER TABLE `song`
  ADD PRIMARY KEY (`idsong`),
  ADD KEY `cons5` (`genre_idgenre`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `cons3` (`whocreated`),
  ADD KEY `cons4` (`wholastmodified`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `idgenre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `idlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `idpermission` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rental`
--
ALTER TABLE `rental`
  MODIFY `idrental` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `idrole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `song`
--
ALTER TABLE `song`
  MODIFY `idsong` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `list`
--
ALTER TABLE `list`
  ADD CONSTRAINT `cons7` FOREIGN KEY (`rental_idrental`) REFERENCES `rental` (`idrental`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cons8` FOREIGN KEY (`song_idsong`) REFERENCES `song` (`idsong`);

--
-- Constraints for table `permission`
--
ALTER TABLE `permission`
  ADD CONSTRAINT `cons13` FOREIGN KEY (`role_idrole`) REFERENCES `role` (`idrole`),
  ADD CONSTRAINT `cons14` FOREIGN KEY (`users_iduser`) REFERENCES `users` (`iduser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `cons6` FOREIGN KEY (`user_iduser`) REFERENCES `users` (`iduser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `song`
--
ALTER TABLE `song`
  ADD CONSTRAINT `cons5` FOREIGN KEY (`genre_idgenre`) REFERENCES `genre` (`idgenre`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `cons3` FOREIGN KEY (`whocreated`) REFERENCES `users` (`iduser`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `cons4` FOREIGN KEY (`wholastmodified`) REFERENCES `users` (`iduser`) ON DELETE SET NULL ON UPDATE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
