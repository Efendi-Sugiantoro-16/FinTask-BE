-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 13 Jun 2026 pada 05.58
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fintask_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `badge`
--

CREATE TABLE `badge` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `iconUrl` varchar(191) NOT NULL DEFAULT '',
  `category` varchar(191) NOT NULL,
  `requirement` text NOT NULL,
  `xpReward` int(11) NOT NULL DEFAULT 25
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `badge`
--

INSERT INTO `badge` (`id`, `name`, `code`, `description`, `iconUrl`, `category`, `requirement`, `xpReward`) VALUES
('0216defc-a6c3-45e0-9d84-579cf2604d12', 'Marathon', 'marathon', 'Login 30 hari berturut-turut', '🏃', 'streak', '{\"type\":\"login_streak\",\"count\":30}', 100),
('051ecb15-bfe7-4fb8-a8db-5b6309c2463d', 'Task Master', 'task_master', 'Selesaikan 100 task', '📋', 'productivity', '{\"type\":\"task_complete\",\"count\":100}', 100),
('11111111-1111-1111-1111-111111111111', 'Early Bird', 'early_bird', 'Login sebelum pukul 6 selama 7 hari berturut-turut', '🌅', 'streak', '{\"type\":\"early_login\",\"count\":7}', 60),
('15fc4eea-d45a-4555-b0d4-bc690a72a40f', 'Goal Getter', 'goal_getter', 'Selesaikan semua weekly task dalam 1 minggu', '🎯', 'productivity', '{\"type\":\"weekly_complete\",\"count\":1}', 75),
('22222222-2222-2222-2222-222222222222', 'Night Owl', 'night_owl', 'Login setelah pukul 22 selama 7 hari berturut-turut', '🦉', 'streak', '{\"type\":\"late_login\",\"count\":7}', 60),
('33333333-3333-3333-3333-333333333333', 'Financial Guru', 'financial_guru', 'Catat 50 transaksi keuangan', '💳', 'finance', '{\"type\":\"transaction_count\",\"count\":50}', 100),
('44444444-4444-4444-4444-444444444444', 'Budget Master', 'budget_master', 'Capai target penghematan 1 juta', '🎯', 'finance', '{\"type\":\"savings_goal\",\"amount\":1000000}', 150),
('55555555-5555-5555-5555-555555555555', 'Calendar King', 'calendar_king', 'Buat 100 calendar events', '👑', 'productivity', '{\"type\":\"calendar_events\",\"count\":100}', 100),
('66666666-6666-6666-6666-666666666666', 'Team Player', 'team_player', 'Selesaikan 10 task dengan kategori \"Team\"', '🤝', 'social', '{\"type\":\"team_tasks\",\"count\":10}', 80),
('77777777-7777-7777-7777-777777777777', 'Learning Machine', 'learning_machine', 'Selesaikan 20 task dengan kategori \"Belajar\"', '📚', 'learning', '{\"type\":\"learning_tasks\",\"count\":20}', 120),
('88888888-8888-8888-8888-888888888888', 'Health Hero', 'health_hero', 'Selesaikan 15 task dengan kategori \"Kesehatan\"', '💪', 'health', '{\"type\":\"health_tasks\",\"count\":15}', 90),
('8d643d00-5981-4178-88b5-cd5835a1fccb', 'On Fire', 'streak_3', 'Login 3 hari berturut-turut', '🔥', 'streak', '{\"type\":\"login_streak\",\"count\":3}', 50),
('99999999-9999-9999-9999-999999999999', 'Creative Mind', 'creative_mind', 'Selesaikan 10 task dengan kategori \"Kreatif\"', '🎨', 'creative', '{\"type\":\"creative_tasks\",\"count\":10}', 70),
('9ecc1171-d2f8-4019-b008-9a3ad9ea8370', 'Speed Demon', 'speed_demon', 'Selesaikan 5 task dalam 1 hari', '⚡', 'productivity', '{\"type\":\"daily_task\",\"count\":5}', 50),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Speed Runner', 'speed_runner', 'Selesaikan 10 task dalam 1 hari', '⚡', 'productivity', '{\"type\":\"daily_task\",\"count\":10}', 80),
('b5dfdc5c-0c98-4eb5-8e2c-290b379a433c', 'Zen Initiate', 'zen_initiate', 'Selesaikan sesi fokus pertama Anda', '🧘', 'productivity', '{\"type\":\"pomodoro_complete\",\"count\":1}', 25),
('b9a08471-c4ad-4c09-aec3-ca0cb786a16f', 'Focus Warrior', 'focus_warrior', 'Selesaikan 50 sesi Pomodoro', '🍅', 'productivity', '{\"type\":\"pomodoro_complete\",\"count\":50}', 75),
('d0099733-6b1e-4e2c-a386-451b7ffdedbd', 'Productive Starter', 'productive_starter', 'Selesaikan tugas pertama Anda', '🌟', 'productivity', '{\"type\":\"task_complete\",\"count\":1}', 25),
('d05db1da-d65c-4bce-baf2-e70c4a0ee2db', 'Wealthy Mind', 'wealthy_mind', 'Catat transaksi pemasukan pertama Anda', '💰', 'finance', '{\"type\":\"income_added\",\"count\":1}', 25),
('f5978541-f244-4add-8327-22c4c6e452d4', 'Time Lord', 'time_lord', 'Buat 50 calendar events', '📅', 'productivity', '{\"type\":\"calendar_events\",\"count\":50}', 50);

-- --------------------------------------------------------

--
-- Struktur dari tabel `calendarevent`
--

CREATE TABLE `calendarevent` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `taskId` varchar(191) DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `startDate` datetime(3) NOT NULL,
  `endDate` datetime(3) NOT NULL,
  `allDay` tinyint(1) NOT NULL DEFAULT 0,
  `recurrence` varchar(191) NOT NULL DEFAULT 'none',
  `color` varchar(191) NOT NULL DEFAULT '#4F46E5',
  `reminder` varchar(191) NOT NULL DEFAULT 'none',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `calendarevent`
--

INSERT INTO `calendarevent` (`id`, `userId`, `taskId`, `title`, `description`, `startDate`, `endDate`, `allDay`, `recurrence`, `color`, `reminder`, `createdAt`) VALUES
('11111111-1111-1111-1111-111111111122', '11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111113', 'Client Meeting', 'Presentasi project FinTask', '2026-04-08 10:00:00.000', '2026-04-08 11:30:00.000', 0, 'none', '#FF6B6B', '15min', '2026-04-05 08:00:00.000'),
('11111111-1111-1111-1111-111111111123', '11111111-1111-1111-1111-111111111111', NULL, 'Team Standup', 'Daily standup meeting', '2026-04-07 09:00:00.000', '2026-04-07 09:15:00.000', 0, 'daily', '#4ECDC4', '5min', '2026-04-05 08:15:00.000'),
('11111111-1111-1111-1111-111111111124', '11111111-1111-1111-1111-111111111111', NULL, 'Gym Session', 'Workout rutin', '2026-04-06 18:00:00.000', '2026-04-06 19:00:00.000', 0, 'weekly', '#95E77E', '30min', '2026-04-05 07:00:00.000'),
('17a51a68-3c1c-4d34-a4fc-4ca15a973b39', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', NULL, 'Test Event', '', '2026-04-02 02:00:00.000', '2026-04-02 03:00:00.000', 0, 'none', '#4F46E5', 'none', '2026-04-02 11:08:54.004'),
('22222222-2222-2222-2222-222222222231', '22222222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222223', 'Design Review', 'Review UI dengan team', '2026-04-07 14:00:00.000', '2026-04-07 15:30:00.000', 0, 'none', '#FF6B6B', '15min', '2026-04-04 09:00:00.000'),
('22222222-2222-2222-2222-222222222232', '22222222-2222-2222-2222-222222222222', NULL, 'Yoga Class', 'Yoga pagi', '2026-04-07 06:00:00.000', '2026-04-07 07:00:00.000', 0, 'weekly', '#95E77E', '30min', '2026-04-04 10:00:00.000'),
('28a78345-3555-4c0e-bf46-fc7367556bcd', '03fdc079-15e4-48a0-97a2-b95faa984d84', NULL, 'Proyek RBPL 1', 'Pengembangan RBPL', '2026-05-13 02:00:00.000', '2026-05-13 09:30:00.000', 0, 'none', '#4F46E5', '1hour', '2026-04-25 12:22:28.597'),
('33333333-3333-3333-3333-333333333343', '33333333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333335', 'Code Review', 'Review code junior dev', '2026-04-07 14:00:00.000', '2026-04-07 16:00:00.000', 0, 'none', '#FF6B6B', '15min', '2026-04-04 08:00:00.000'),
('33333333-3333-3333-3333-333333333344', '33333333-3333-3333-3333-333333333333', NULL, 'Tech Talk', 'Tech talk Docker', '2026-04-10 19:00:00.000', '2026-04-10 20:30:00.000', 0, 'none', '#4ECDC4', '1hour', '2026-04-04 09:00:00.000'),
('5115cd78-5599-4e3c-8609-019d69df4d61', '03fdc079-15e4-48a0-97a2-b95faa984d84', NULL, 'Kelinling dunia 1', 'Jalan jalan dan tourney ', '2026-03-03 20:45:00.000', '2026-04-30 16:15:00.000', 0, 'none', '#4F46E5', 'none', '2026-04-05 20:31:55.171'),
('55555555-5555-5555-5555-555555555565', '55555555-5555-5555-5555-555555555555', '55555555-5555-5555-5555-555555555557', 'Team Meeting', 'Q2 Planning meeting', '2026-04-07 09:00:00.000', '2026-04-07 11:00:00.000', 0, 'none', '#FF6B6B', '30min', '2026-04-04 07:00:00.000'),
('55555555-5555-5555-5555-555555555566', '55555555-5555-5555-5555-555555555555', NULL, '1-on-1 with Manager', 'Monthly check-in', '2026-04-09 15:00:00.000', '2026-04-09 16:00:00.000', 0, 'monthly', '#4ECDC4', '15min', '2026-04-04 08:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaf', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaac', 'Strategy Meeting', 'Q2 Strategic Planning', '2026-04-08 10:00:00.000', '2026-04-08 12:00:00.000', 0, 'none', '#FF6B6B', '30min', '2026-04-04 16:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaag', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, 'Workshop', 'Digital Marketing Workshop', '2026-04-15 13:00:00.000', '2026-04-15 17:00:00.000', 0, 'none', '#4ECDC4', '1hour', '2026-04-04 17:00:00.000');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notification`
--

CREATE TABLE `notification` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'info',
  `title` varchar(191) NOT NULL,
  `message` text NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT 0,
  `link` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pomodorosession`
--

CREATE TABLE `pomodorosession` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `taskId` varchar(191) DEFAULT NULL,
  `focusDuration` int(11) NOT NULL DEFAULT 25,
  `breakDuration` int(11) NOT NULL DEFAULT 5,
  `status` varchar(191) NOT NULL DEFAULT 'running',
  `startedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `endedAt` datetime(3) DEFAULT NULL,
  `xpEarned` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pomodorosession`
--

INSERT INTO `pomodorosession` (`id`, `userId`, `taskId`, `focusDuration`, `breakDuration`, `status`, `startedAt`, `endedAt`, `xpEarned`) VALUES
('05f0fda1-92e0-467d-bd46-6d12219b2a59', '03fdc079-15e4-48a0-97a2-b95faa984d84', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 1, 1, 'running', '2026-04-03 12:51:04.877', NULL, 0),
('11111111-1111-1111-1111-111111111125', '11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111112', 25, 5, 'completed', '2026-04-06 08:00:00.000', '2026-04-06 08:25:00.000', 25),
('11111111-1111-1111-1111-111111111126', '11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111114', 45, 10, 'completed', '2026-04-06 18:30:00.000', '2026-04-06 19:15:00.000', 45),
('11111111-1111-1111-1111-111111111127', '11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111116', 30, 5, 'running', '2026-04-06 20:00:00.000', NULL, 0),
('22222222-2222-2222-2222-222222222233', '22222222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222223', 50, 10, 'completed', '2026-04-05 13:00:00.000', '2026-04-05 13:50:00.000', 50),
('22222222-2222-2222-2222-222222222234', '22222222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222226', 25, 5, 'completed', '2026-04-05 19:00:00.000', '2026-04-05 19:25:00.000', 25),
('33333333-3333-3333-3333-333333333345', '33333333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333334', 60, 15, 'completed', '2026-04-05 14:00:00.000', '2026-04-05 15:00:00.000', 60),
('33333333-3333-3333-3333-333333333346', '33333333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333336', 45, 10, 'running', '2026-04-06 19:00:00.000', NULL, 0),
('39ee731b-d2e2-47b1-aa98-fe9073e80960', '03fdc079-15e4-48a0-97a2-b95faa984d84', NULL, 25, 5, 'cancelled', '2026-04-03 03:04:06.683', '2026-04-03 12:47:49.853', 0),
('422ba2c5-6598-40a5-a9d0-be7addc8e65f', '03fdc079-15e4-48a0-97a2-b95faa984d84', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 25, 5, 'cancelled', '2026-04-03 12:47:55.083', '2026-04-03 12:47:56.962', 0),
('4a38ed7b-77f9-4972-9abb-a3cfc9315fe5', '03fdc079-15e4-48a0-97a2-b95faa984d84', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 1, 1, 'running', '2026-04-03 12:49:45.363', NULL, 0),
('508bab30-2e7b-457f-9ab9-728f719b8240', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '90191986-8f7b-4cc1-b459-04338c306348', 25, 5, 'running', '2026-04-03 14:38:53.867', NULL, 0),
('55555555-5555-5555-5555-555555555567', '55555555-5555-5555-5555-555555555555', '55555555-5555-5555-5555-555555555556', 90, 20, 'completed', '2026-04-05 16:00:00.000', '2026-04-05 17:30:00.000', 90),
('55555555-5555-5555-5555-555555555568', '55555555-5555-5555-5555-555555555555', NULL, 25, 5, 'running', '2026-04-06 08:30:00.000', NULL, 0),
('575a06fd-11c3-4b55-a484-6d1f6f6fc777', '03fdc079-15e4-48a0-97a2-b95faa984d84', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 1, 1, 'running', '2026-04-03 12:48:39.635', NULL, 0),
('6fe5b6da-c0bf-4479-b6b4-f0dbc1a96531', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', NULL, 25, 5, 'cancelled', '2026-04-02 11:21:17.673', '2026-04-02 11:24:24.619', 0),
('8d42aec2-7399-4927-b029-308b02185fcc', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'cb17d992-c1e1-40b0-a634-a72a49144f7d', 25, 5, 'running', '2026-04-13 10:18:49.175', NULL, 0),
('8d5358ec-4c5f-4b8e-bd8d-dd07fdc5f9c6', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '90191986-8f7b-4cc1-b459-04338c306348', 25, 5, 'running', '2026-04-03 14:38:47.189', NULL, 0),
('a41baf64-07f6-481f-a4b0-6010ebd3fb4f', '03fdc079-15e4-48a0-97a2-b95faa984d84', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 25, 5, 'running', '2026-04-05 19:51:33.663', NULL, 0),
('a8332637-94c4-49b6-94d6-eff252a660c2', '03fdc079-15e4-48a0-97a2-b95faa984d84', NULL, 25, 5, 'completed', '2026-04-03 03:05:15.848', '2026-04-03 03:30:17.352', 25),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaah', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaab', 120, 30, 'completed', '2026-04-06 09:00:00.000', '2026-04-06 11:00:00.000', 120),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaai', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaad', 60, 15, 'running', '2026-04-06 20:30:00.000', NULL, 0),
('ac13e166-8842-4615-b22d-d1ef8b3f8dc5', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '90191986-8f7b-4cc1-b459-04338c306348', 25, 5, 'running', '2026-04-02 11:24:26.008', NULL, 0),
('d660ba49-b933-4b4d-9f70-76d91743e1d7', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'cb17d992-c1e1-40b0-a634-a72a49144f7d', 25, 5, 'running', '2026-04-05 20:30:00.407', NULL, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `qrsession`
--

CREATE TABLE `qrsession` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) DEFAULT NULL,
  `token` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `expiresAt` datetime(3) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `qrsession`
--

INSERT INTO `qrsession` (`id`, `userId`, `token`, `status`, `expiresAt`, `createdAt`) VALUES
('0a4f30b6-3723-4ed5-9121-aae5f057d7f4', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '1a2ad99e-e0d8-4577-81e5-73e5bccca3e2', 'verified', '2026-04-02 11:52:01.613', '2026-04-02 11:37:01.615'),
('0ffdc556-04e2-4f99-86af-951c275ac835', '03fdc079-15e4-48a0-97a2-b95faa984d84', '11ec940f-341e-461b-a010-6335899f81e5', 'verified', '2026-04-12 11:51:49.506', '2026-04-12 11:36:49.507'),
('15745a5b-d0c5-41f4-bc4b-2382e796f3c3', NULL, '5e5fd7c9-85bb-4deb-86e6-b6ec998654a2', 'pending', '2026-04-04 16:23:48.189', '2026-04-04 16:18:48.289'),
('1694a0f6-f91a-45ae-a0c4-cc0e4ad4b7ba', '03fdc079-15e4-48a0-97a2-b95faa984d84', '963fde85-33e0-46ed-aaa6-0e398c03daa7', 'verified', '2026-04-06 16:27:08.836', '2026-04-06 16:12:08.837'),
('17236ae3-dd34-48ab-ae3c-59c33845bf1a', NULL, 'de115276-fc2f-4e6b-8a0a-4bc24e75fea7', 'pending', '2026-04-04 15:53:59.091', '2026-04-04 15:48:59.123'),
('1aa4207a-d6c7-488e-be08-c30023b40fba', NULL, '3bd9f9d7-c206-4fcc-b219-14affe93d84e', 'pending', '2026-04-04 15:53:59.212', '2026-04-04 15:48:59.213'),
('1efddb47-860a-4e50-9159-71a826d596bf', '03fdc079-15e4-48a0-97a2-b95faa984d84', '48c878d8-f065-47a3-a4b3-410ff5681ad4', 'verified', '2026-04-06 16:26:44.792', '2026-04-06 16:11:44.794'),
('1f9cfaad-c148-49b3-9e33-26c3ec09d284', NULL, '4304df24-1e69-4105-b09e-588cbf940b32', 'pending', '2026-04-02 11:08:56.386', '2026-04-02 11:03:56.390'),
('20777944-002b-4c80-954b-63aa18102234', '03fdc079-15e4-48a0-97a2-b95faa984d84', '0c1fff8c-86ad-4a70-bed4-11ffba78b7fb', 'verified', '2026-04-12 11:51:50.081', '2026-04-12 11:36:50.082'),
('214d6697-fa29-4122-8a3d-c1f98a2a2350', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '9b27bf47-4bb9-4dcd-9733-1218b2dca150', 'verified', '2026-04-02 11:35:06.286', '2026-04-02 11:20:06.288'),
('232fc92d-3c56-4b38-9aec-8c2d246df5fd', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'a98a6059-3492-4b7e-b437-64c6faec5389', 'verified', '2026-04-02 12:01:45.665', '2026-04-02 11:46:45.666'),
('287a1dbe-ad7e-42a7-8c6a-6ef4f440fc74', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '9b2b9b08-979e-47ee-8ba6-1070d44b3bda', 'verified', '2026-04-02 11:52:03.128', '2026-04-02 11:37:03.130'),
('2f523049-3255-499b-88b9-52cc11782b6a', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '679cc3b7-4746-4e21-b0c0-bf0cd92869dd', 'verified', '2026-04-02 11:52:03.911', '2026-04-02 11:37:03.912'),
('37a6bd74-0d65-455a-baec-a388188f3343', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'c5c4ceb2-08aa-4af5-93a9-c53845a71417', 'verified', '2026-04-06 16:27:05.957', '2026-04-06 16:12:05.958'),
('384fecc0-641e-48a3-bf86-f181fcd3dc98', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '92eeca0d-63e9-4f6b-893a-8160849c66cc', 'verified', '2026-04-02 11:52:04.614', '2026-04-02 11:37:04.616'),
('3b037da1-3d17-4d96-8df5-d72a539a832f', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'aee38c1a-42bd-4f70-b6d5-f6eb7620bf4d', 'verified', '2026-04-06 16:26:56.664', '2026-04-06 16:11:56.666'),
('4503a426-91fa-49f7-87a5-5145e2df4698', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'ddd7fa6a-69ef-43f7-8ac8-303c9b39db8a', 'verified', '2026-04-02 11:52:03.650', '2026-04-02 11:37:03.652'),
('453fe35f-534f-4ffb-bc01-97b5cf6c4e81', NULL, 'b5a4fdc5-3691-4164-a23c-bd9b2673eed5', 'pending', '2026-04-04 13:39:47.688', '2026-04-04 13:34:47.690'),
('457d4908-fd1a-4b1d-83cb-2d72ef6052f2', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'de929d7e-4ee3-479b-945c-ce4f509d63e4', 'verified', '2026-04-06 06:07:44.096', '2026-04-06 05:52:44.102'),
('4928fc5a-9c0e-4d35-8b82-345c006cb127', NULL, 'd2fcaadc-7681-49a5-93b4-62e24ab7373f', 'pending', '2026-04-04 16:09:00.330', '2026-04-04 16:04:00.333'),
('4bda83b7-5076-4c29-b7d2-ebebe8dd8fb4', '03fdc079-15e4-48a0-97a2-b95faa984d84', '65a622d4-bfdc-4e7f-bf5f-0152eb76c0e5', 'verified', '2026-04-06 16:26:55.780', '2026-04-06 16:11:55.781'),
('4d64702d-b58e-478f-8096-e731e7e6dc36', '03fdc079-15e4-48a0-97a2-b95faa984d84', '828fe723-71f2-47d1-8cb4-2d79b19af8d0', 'verified', '2026-04-06 16:27:01.565', '2026-04-06 16:12:01.566'),
('504d898c-5082-45b8-b234-e22365a5008b', NULL, '0639cee6-dbe7-4cd3-91ce-b4413425cf0e', 'pending', '2026-04-04 15:34:25.880', '2026-04-04 15:29:25.881'),
('51d26a1e-5e99-4202-95e5-38686ea1a769', NULL, '3057f989-5657-4efd-b944-f8451722f2fa', 'pending', '2026-04-03 09:27:36.894', '2026-04-03 09:22:36.899'),
('549da01b-85d1-492e-a2ba-ec75164bc595', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'dc8a4149-4e28-4e70-9006-db659076b9ea', 'verified', '2026-04-06 16:27:05.177', '2026-04-06 16:12:05.178'),
('57b61bbc-d35a-4f4d-9a52-19e6bfd20775', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'a7ec3d05-b192-44a6-976a-352f22050282', 'verified', '2026-04-02 11:52:04.128', '2026-04-02 11:37:04.129'),
('5ab8b2f5-3294-4904-afc5-d7f517c98f3d', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '7d7e5af0-bd9b-4f0b-b3d3-e6ca397a74d9', 'verified', '2026-04-02 11:52:02.774', '2026-04-02 11:37:02.776'),
('5cf30f59-dcf5-48e2-b95c-bd4f52f68a33', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'fff04913-1577-4e25-96da-b55eef3f1fd2', 'verified', '2026-04-02 11:51:41.272', '2026-04-02 11:36:41.273'),
('613c96bd-03b7-425d-9c2b-09e2d736367e', '03fdc079-15e4-48a0-97a2-b95faa984d84', '16165142-40b3-4a0d-b6ff-3e65f2403e07', 'verified', '2026-04-06 16:27:06.804', '2026-04-06 16:12:06.805'),
('61ef6c8a-918a-4c4a-9132-c26b7dc38e14', '03fdc079-15e4-48a0-97a2-b95faa984d84', '22da08a6-4640-4006-a80f-839c0798485d', 'verified', '2026-04-04 16:22:32.236', '2026-04-04 16:07:32.238'),
('630e41ea-acae-4422-b002-44e6ae9b150b', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'f2e0f9dc-754f-4f1d-8a18-34f0e49f737a', 'verified', '2026-04-02 11:52:05.100', '2026-04-02 11:37:05.102'),
('63a12096-3a7b-4536-a586-2c26e3a0a345', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'fbe9b140-8529-4439-bc23-d713f810ce5e', 'verified', '2026-04-02 12:26:47.173', '2026-04-02 12:11:47.175'),
('658dfb52-ea72-446d-a8f7-3f260d35a5c9', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'dfe6e965-1558-4e65-90f5-7f361f9701fb', 'verified', '2026-04-04 17:03:45.700', '2026-04-04 16:48:45.702'),
('6e5afc54-d3c5-4fd3-9af4-638190aeab60', NULL, 'bf82444b-cfc8-4224-bff6-2591f245829e', 'pending', '2026-04-04 16:12:46.972', '2026-04-04 16:07:46.975'),
('70783598-a60f-492e-8cb6-43cd47f48e3d', NULL, 'eaa80c8b-80c7-44d1-bfc5-6b2b8c8c95b3', 'pending', '2026-04-04 15:55:12.217', '2026-04-04 15:50:12.219'),
('707bfb32-6d3c-4457-bb20-84f9de4a5336', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '4dc6b113-e122-43ac-84a7-9e35616a0f52', 'verified', '2026-04-02 12:16:29.605', '2026-04-02 12:01:29.607'),
('74fec8d2-199e-4db7-8a8d-8df5319821d1', NULL, 'a88be1be-4f97-454b-a0e4-a39fd5fc349c', 'pending', '2026-04-04 16:09:00.398', '2026-04-04 16:04:00.401'),
('75c9e78b-4290-47d2-800d-599dddabfefb', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'e86b9653-fc60-4d25-b58b-2b8f0ceba5de', 'verified', '2026-04-06 06:08:23.459', '2026-04-06 05:53:23.460'),
('75ebb3d9-8423-4ba7-930c-5439f6ebe69b', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '78aa3fe7-2d09-4a67-ad2f-3bb5622a83b5', 'verified', '2026-04-02 11:52:02.394', '2026-04-02 11:37:02.396'),
('7cd91cf2-f1b4-460d-9af3-f33a7d6d5bfd', '03fdc079-15e4-48a0-97a2-b95faa984d84', '937a21dd-bd42-4e1d-89ba-97b5bf22bdd1', 'verified', '2026-04-06 16:26:50.602', '2026-04-06 16:11:50.604'),
('81e28986-3c38-4da7-baf7-4b3798f9fe45', '03fdc079-15e4-48a0-97a2-b95faa984d84', '651e2688-b5fb-4cff-8455-882da38ecddb', 'verified', '2026-04-04 15:50:34.504', '2026-04-04 15:35:34.506'),
('82043c5b-9528-4fbf-a676-ef98179d9bc5', NULL, '2d18e68d-3263-48aa-a86f-07a8fe35c4b1', 'pending', '2026-04-02 11:08:56.505', '2026-04-02 11:03:56.506'),
('8743df73-0f2c-440e-8249-a32517a72495', '03fdc079-15e4-48a0-97a2-b95faa984d84', '9a300395-b40e-4f24-b224-4424198a8444', 'verified', '2026-04-06 06:58:09.021', '2026-04-06 06:43:09.023'),
('8a6235b9-8060-47fe-8207-b5fb0f92455c', '03fdc079-15e4-48a0-97a2-b95faa984d84', '7be7a338-c362-41b9-9647-2ce6c76ffc6d', 'verified', '2026-04-04 16:19:38.944', '2026-04-04 16:04:38.946'),
('8ce02435-41e2-4c0b-9ce2-1904bca43888', NULL, '4d9d9745-cb6c-423d-879b-c5901a6edbab', 'pending', '2026-04-16 06:09:44.848', '2026-04-16 06:04:44.850'),
('8f7c1554-2f93-4440-a894-aa79af88aeea', '03fdc079-15e4-48a0-97a2-b95faa984d84', '72961b52-717b-4f84-80ed-d6d9a0001e96', 'verified', '2026-04-06 16:27:02.348', '2026-04-06 16:12:02.349'),
('8fb4ef9d-0044-47d2-acce-92a2a9be6670', NULL, 'cdbff7c7-ce00-4c87-a54a-c29747830fb7', 'pending', '2026-04-16 06:08:31.686', '2026-04-16 06:03:31.687'),
('9077c3e0-ea3b-4d55-b102-e9264030faa5', NULL, '3e0b13f2-65d7-4b02-b005-d9db7d641040', 'pending', '2026-04-03 09:27:37.027', '2026-04-03 09:22:37.031'),
('90e238d1-a56e-40ee-a5f2-b5280349e663', '03fdc079-15e4-48a0-97a2-b95faa984d84', '405c9d08-ba22-4acf-9d16-57a9c1ceb499', 'verified', '2026-04-04 17:21:11.745', '2026-04-04 17:06:11.747'),
('94030dd9-6da8-4aa7-a8fd-0ed090966fd1', '03fdc079-15e4-48a0-97a2-b95faa984d84', '7ce69338-bc50-413c-8f67-7d1aeb5a2bdc', 'verified', '2026-04-06 16:27:08.191', '2026-04-06 16:12:08.192'),
('9750054b-786f-4883-a339-9d714423fc92', '03fdc079-15e4-48a0-97a2-b95faa984d84', '84331eba-4f2f-43fb-9d53-53085017878d', 'verified', '2026-04-06 16:27:03.729', '2026-04-06 16:12:03.730'),
('98afdab8-5eb0-49df-8739-640efe47374e', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'e95b8ecb-b4ba-4933-8685-5879a7a06182', 'verified', '2026-04-02 11:52:03.399', '2026-04-02 11:37:03.401'),
('998a0cdb-9473-4256-99e5-33fc46d12aac', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '23e55582-8ede-4869-9e84-5c5382079179', 'verified', '2026-04-02 11:52:00.604', '2026-04-02 11:37:00.605'),
('9aff6b14-a12f-4bdf-9b6c-29ecbe173475', '03fdc079-15e4-48a0-97a2-b95faa984d84', '8c55ad9e-6023-4df6-aa0c-89672cf306be', 'verified', '2026-04-12 11:51:51.512', '2026-04-12 11:36:51.513'),
('9d5a746a-8b6a-4b2b-9f53-25f7ddf9c644', '03fdc079-15e4-48a0-97a2-b95faa984d84', '3400e93b-ff0c-4c48-add7-4dab143a40cd', 'verified', '2026-04-12 11:51:42.949', '2026-04-12 11:36:42.950'),
('9ea94eed-c2f0-49ed-825e-9bdb0088d8ce', '03fdc079-15e4-48a0-97a2-b95faa984d84', '69939220-1ff1-4b7b-96c3-f35e7d46c378', 'verified', '2026-04-06 16:26:54.152', '2026-04-06 16:11:54.154'),
('a198aef6-91fc-4b03-8f32-ed3462df00ba', NULL, '3f28f3b1-701a-4ea9-9bba-20af2f4bd59d', 'pending', '2026-04-04 16:12:46.906', '2026-04-04 16:07:46.908'),
('a573582f-6541-4578-9b10-f4b726671abe', '03fdc079-15e4-48a0-97a2-b95faa984d84', '444ef477-bdb1-487d-88eb-7848cd1a69a0', 'verified', '2026-04-06 16:27:04.447', '2026-04-06 16:12:04.448'),
('a8871b65-45b1-4fc8-bfc3-b52e20fee01b', NULL, '92fe2650-4250-4751-a0d3-3c6cd7e67844', 'pending', '2026-04-02 11:13:35.377', '2026-04-02 11:08:35.379'),
('a8b7c4cd-b480-47c9-ad9c-0ddb0d72bb4c', NULL, 'c7e05da8-99b9-40a9-b34b-990ee314d0ae', 'pending', '2026-04-03 09:30:19.454', '2026-04-03 09:25:19.456'),
('aa00c6d6-1417-4ea9-bd3f-a91e618f7cd6', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'f355ea7c-fb6d-4074-9bd5-882ac89f0dfb', 'verified', '2026-04-02 11:52:04.881', '2026-04-02 11:37:04.882'),
('ab48da20-65d4-4311-8b77-6db038d8dc69', '03fdc079-15e4-48a0-97a2-b95faa984d84', '040c777b-735d-4676-a10d-fcbe74f5dd1c', 'verified', '2026-04-06 16:27:00.225', '2026-04-06 16:12:00.227'),
('af532668-9122-4c75-959f-265b51b297cd', NULL, '38909555-27b4-4172-bcdc-19da5dea469c', 'pending', '2026-04-04 13:39:47.497', '2026-04-04 13:34:47.564'),
('b8595548-73d7-4600-92ca-5d9463f03f56', NULL, '1de9f61d-4ea4-460b-b4d4-141ee62a2381', 'pending', '2026-04-03 09:36:03.649', '2026-04-03 09:31:03.651'),
('b8622bb9-e45e-4cc5-a66b-5bd5d4c971fc', NULL, 'f2bd5f83-5608-4929-bdb1-2a6b702f3067', 'pending', '2026-04-04 15:55:12.178', '2026-04-04 15:50:12.179'),
('bbbf6fa5-c6f8-4a3f-b937-f1ecc5e1878c', '03fdc079-15e4-48a0-97a2-b95faa984d84', '270db44f-e826-4774-b753-31c90d464be1', 'verified', '2026-04-12 11:51:52.122', '2026-04-12 11:36:52.123'),
('bd89f438-f757-4083-a140-8a1b449a985a', '03fdc079-15e4-48a0-97a2-b95faa984d84', '7c71e20e-d4ba-471b-80c3-ef50b1543933', 'verified', '2026-04-12 11:51:48.852', '2026-04-12 11:36:48.853'),
('bf9e7333-0780-4d3f-b996-b545f8a3b808', '03fdc079-15e4-48a0-97a2-b95faa984d84', '85c35d16-bad4-472c-9987-c77cd309a963', 'verified', '2026-04-06 16:26:51.785', '2026-04-06 16:11:51.786'),
('c209f728-4208-497b-8d60-3b26330b13ba', NULL, 'd23b9dd2-30f4-44a8-8f41-9453f36f923b', 'pending', '2026-04-03 09:30:19.521', '2026-04-03 09:25:19.523'),
('c414b81f-26bf-41d6-905f-5a15b1d32e76', NULL, '7bd15daf-7670-4aea-a21b-e856db4471be', 'pending', '2026-04-04 15:34:25.786', '2026-04-04 15:29:25.787'),
('c70cd146-0fc8-4131-bae3-ac6c6d4c7281', NULL, '945b0e1f-54c2-434b-a5e5-b66e00b1c5b9', 'pending', '2026-04-04 16:23:48.412', '2026-04-04 16:18:48.414'),
('c74c2ba9-ad9b-4d8f-bcb2-b82edba3b333', '03fdc079-15e4-48a0-97a2-b95faa984d84', '6ea33db5-6e79-451e-92c2-237edbb7d90f', 'verified', '2026-04-06 16:26:59.415', '2026-04-06 16:11:59.417'),
('c99a27bb-494f-4ee2-882f-b174a4cb2984', '03fdc079-15e4-48a0-97a2-b95faa984d84', '1221a062-d51e-477f-b62d-93132e7d7d0f', 'verified', '2026-04-04 16:17:29.809', '2026-04-04 16:02:29.811'),
('c9d48009-e335-454f-94f9-d9d3108277b1', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '01c0324f-f089-434a-a015-f105134b86ba', 'verified', '2026-04-02 11:52:55.050', '2026-04-02 11:37:55.052'),
('cb0aea81-5cb6-4fad-9f76-db33d36fcd5a', '03fdc079-15e4-48a0-97a2-b95faa984d84', '3a1dcb4c-40ba-4ccb-879f-24d18d2842e2', 'verified', '2026-04-12 11:51:52.598', '2026-04-12 11:36:52.599'),
('cbdf4363-53e5-4a7e-bdda-f8c025cdc5f9', '03fdc079-15e4-48a0-97a2-b95faa984d84', '95652e50-4062-4f42-8071-ea6962aae367', 'verified', '2026-04-06 16:26:55.009', '2026-04-06 16:11:55.010'),
('cd8b1876-607a-4961-ae1f-a796e4e95c75', '03fdc079-15e4-48a0-97a2-b95faa984d84', '4ae192ab-098a-4cb5-9c03-512e5b2a6d2f', 'verified', '2026-04-06 16:27:03.064', '2026-04-06 16:12:03.065'),
('ce666882-ab6c-4165-8e1e-9da184d979a5', '03fdc079-15e4-48a0-97a2-b95faa984d84', '1a9b988a-7462-4789-9b91-b75801543e57', 'verified', '2026-04-06 16:27:09.591', '2026-04-06 16:12:09.592'),
('d117baa4-52fb-4337-a604-7e25c6e0ceb6', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'b138bcbc-e78f-4a9c-a0d8-078134816a29', 'verified', '2026-04-12 11:51:47.212', '2026-04-12 11:36:47.213'),
('d241a838-b966-4594-b4d2-fc835f849d72', '03fdc079-15e4-48a0-97a2-b95faa984d84', '436fafa3-519a-4c9a-89b6-305572178a89', 'verified', '2026-04-06 16:27:00.936', '2026-04-06 16:12:00.938'),
('d454f74b-9570-48ae-a788-d98e84ad386d', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'a04ea3fc-daca-4946-9877-9ab54b7d6597', 'verified', '2026-04-04 16:19:33.693', '2026-04-04 16:04:33.696'),
('db5de2e6-0dbd-4108-9696-34910e4f6cd3', NULL, '694b1daa-121f-4c17-a75d-bd81f3708192', 'pending', '2026-04-02 11:13:35.444', '2026-04-02 11:08:35.445'),
('dbec69c5-41a1-4cbc-b94e-7fe20e26ed01', NULL, '93941f28-e6cf-4b56-87cd-0a5ecfe18c52', 'pending', '2026-04-04 13:40:01.641', '2026-04-04 13:35:01.643'),
('dc0703c9-ce42-4d8b-9ddc-e1866218ad5a', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '59769d58-4218-493b-beef-d139726ac9dd', 'verified', '2026-04-02 11:52:04.375', '2026-04-02 11:37:04.376'),
('e231e536-8a2c-43e3-a3ec-0dd7a66e50f8', '03fdc079-15e4-48a0-97a2-b95faa984d84', '3c8b3b47-06b3-4438-918e-b66b87e43072', 'verified', '2026-04-06 16:27:07.440', '2026-04-06 16:12:07.442'),
('e601f72c-8bf2-4f48-8e11-a1e679adf6b5', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'dad49d3b-5003-4210-a4ac-2a6938732cd3', 'verified', '2026-04-12 11:51:50.938', '2026-04-12 11:36:50.939'),
('e93196d6-c4bd-4532-b630-5fa27c400a99', '03fdc079-15e4-48a0-97a2-b95faa984d84', '26b18d05-6dd8-44a8-8159-b8e87e3df6d3', 'verified', '2026-04-12 11:51:48.068', '2026-04-12 11:36:48.069'),
('f623ad6c-9f1b-425a-b477-efaf75888fbd', NULL, '91033f45-4eac-474a-a7a1-70f05dd00d1e', 'pending', '2026-04-04 13:40:01.544', '2026-04-04 13:35:01.547'),
('f79c17a2-dca9-4424-ad5c-be7c706ff5ab', '03fdc079-15e4-48a0-97a2-b95faa984d84', '1d3ca9b9-7cab-4dda-8e00-675ce8848d9a', 'verified', '2026-04-16 06:09:44.864', '2026-04-16 06:04:44.865'),
('fd3ab86a-7177-4f7d-a780-57e9688b88f8', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'fdd87931-c1ec-469a-9168-8b2822233e91', 'verified', '2026-04-02 11:52:14.865', '2026-04-02 11:37:14.866');

-- --------------------------------------------------------

--
-- Struktur dari tabel `task`
--

CREATE TABLE `task` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` varchar(191) NOT NULL DEFAULT 'medium',
  `status` varchar(191) NOT NULL DEFAULT 'todo',
  `category` varchar(191) DEFAULT NULL,
  `dueDate` datetime(3) DEFAULT NULL,
  `completedAt` datetime(3) DEFAULT NULL,
  `isDaily` tinyint(1) NOT NULL DEFAULT 0,
  `isWeekly` tinyint(1) NOT NULL DEFAULT 0,
  `xpReward` int(11) NOT NULL DEFAULT 10,
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `task`
--

INSERT INTO `task` (`id`, `userId`, `title`, `description`, `priority`, `status`, `category`, `dueDate`, `completedAt`, `isDaily`, `isWeekly`, `xpReward`, `sortOrder`, `createdAt`, `updatedAt`) VALUES
('11111111-1111-1111-1111-111111111112', '11111111-1111-1111-1111-111111111111', 'Review Code Pull Request', 'Review dan approve PR dari team development', 'high', 'done', 'Kerja', '2026-04-07 17:00:00.000', '2026-04-06 09:30:00.000', 0, 0, 35, 1, '2026-04-05 08:00:00.000', '2026-04-06 09:30:00.000'),
('11111111-1111-1111-1111-111111111113', '11111111-1111-1111-1111-111111111111', 'Meeting dengan Client', 'Presentasi progress project ke client', 'urgent', 'todo', 'Kerja', '2026-04-08 10:00:00.000', NULL, 0, 0, 50, 2, '2026-04-05 08:15:00.000', '2026-04-05 08:15:00.000'),
('11111111-1111-1111-1111-111111111114', '11111111-1111-1111-1111-111111111111', 'Update Documentation', 'Update API documentation untuk project baru', 'medium', 'todo', 'Kerja', '2026-04-10 15:00:00.000', NULL, 0, 0, 20, 3, '2026-04-05 08:30:00.000', '2026-04-05 08:30:00.000'),
('11111111-1111-1111-1111-111111111115', '11111111-1111-1111-1111-111111111111', 'Workout di Gym', 'Latihan fitness 1 jam', 'low', 'done', 'Kesehatan', '2026-04-06 18:00:00.000', '2026-04-06 19:30:00.000', 1, 0, 15, 4, '2026-04-05 07:00:00.000', '2026-04-06 19:30:00.000'),
('11111111-1111-1111-1111-111111111116', '11111111-1111-1111-1111-111111111111', 'Belajar React Native', 'Tutorial React Native chapter 5-7', 'medium', 'todo', 'Belajar', '2026-04-12 20:00:00.000', NULL, 0, 0, 25, 5, '2026-04-05 09:00:00.000', '2026-04-05 09:00:00.000'),
('1699495e-51fd-42f6-adc9-24c6b9ffa855', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'Kerja 3', 'Kerja 3', 'low', 'done', 'Kerja', '2026-04-25 16:15:00.000', '2026-04-16 05:58:09.781', 0, 0, 10, 0, '2026-04-05 20:29:37.785', '2026-04-16 05:58:09.802'),
('22222222-2222-2222-2222-222222222223', '22222222-2222-2222-2222-222222222222', 'Design UI Dashboard', 'Create mockup untuk dashboard baru', 'high', 'done', 'Kreatif', '2026-04-07 16:00:00.000', '2026-04-05 14:20:00.000', 0, 0, 30, 1, '2026-04-04 09:00:00.000', '2026-04-05 14:20:00.000'),
('22222222-2222-2222-2222-222222222224', '22222222-2222-2222-2222-222222222222', 'Weekly Report', 'Buat laporan mingguan untuk manager', 'medium', 'todo', 'Kerja', '2026-04-07 17:00:00.000', NULL, 1, 0, 20, 2, '2026-04-04 10:00:00.000', '2026-04-04 10:00:00.000'),
('22222222-2222-2222-2222-222222222225', '22222222-2222-2222-2222-222222222222', 'Yoga Session', 'Yoga pagi di taman', 'low', 'done', 'Kesehatan', '2026-04-06 06:00:00.000', '2026-04-06 07:00:00.000', 1, 0, 15, 3, '2026-04-05 05:30:00.000', '2026-04-06 07:00:00.000'),
('22222222-2222-2222-2222-222222222226', '22222222-2222-2222-2222-222222222222', 'Belajar Figma', 'Tutorial advanced Figma techniques', 'medium', 'todo', 'Belajar', '2026-04-15 19:00:00.000', NULL, 0, 0, 25, 4, '2026-04-04 11:00:00.000', '2026-04-04 11:00:00.000'),
('33333333-3333-3333-3333-333333333334', '33333333-3333-3333-3333-333333333333', 'Database Optimization', 'Optimize query untuk report system', 'urgent', 'done', 'Kerja', '2026-04-06 12:00:00.000', '2026-04-05 16:45:00.000', 0, 0, 45, 1, '2026-04-04 08:00:00.000', '2026-04-05 16:45:00.000'),
('33333333-3333-3333-3333-333333333335', '33333333-3333-3333-3333-333333333333', 'Code Review Session', 'Review code dari junior developer', 'high', 'todo', 'Kerja', '2026-04-07 14:00:00.000', NULL, 0, 0, 35, 2, '2026-04-04 09:00:00.000', '2026-04-04 09:00:00.000'),
('33333333-3333-3333-3333-333333333336', '33333333-3333-3333-3333-333333333333', 'Belajar Docker', 'Docker containerization tutorial', 'medium', 'todo', 'Belajar', '2026-04-20 18:00:00.000', NULL, 0, 0, 25, 3, '2026-04-04 10:00:00.000', '2026-04-04 10:00:00.000'),
('33333333-3333-3333-3333-333333333337', '33333333-3333-3333-3333-333333333333', 'Running 5K', 'Lari pagi 5 kilometer', 'low', 'done', 'Kesehatan', '2026-04-06 05:30:00.000', '2026-04-06 06:30:00.000', 1, 0, 15, 4, '2026-04-05 05:00:00.000', '2026-04-06 06:30:00.000'),
('3cfc0c67-e5fb-4d13-b7bb-d3ebe45e1c82', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', 'Verify Premium Datepicker', 'Testing the new datepicker functionality.', 'medium', 'todo', 'Kerja', NULL, NULL, 0, 0, 20, 0, '2026-04-03 16:34:04.937', '2026-04-03 16:34:04.937'),
('441cfa86-28e6-45bf-a94e-a1dcdfe69898', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'Kerja 1', 'Kerja bagian admin', 'high', 'done', 'Kerja', '2026-08-12 17:00:00.000', '2026-04-05 19:04:17.429', 0, 0, 35, 0, '2026-04-03 12:46:49.234', '2026-04-05 19:04:17.434'),
('44444444-4444-4444-4444-444444444445', '44444444-4444-4444-4444-444444444444', 'Social Media Content', 'Create content untuk Instagram campaign', 'medium', 'todo', 'Kreatif', '2026-04-08 11:00:00.000', NULL, 0, 0, 20, 1, '2026-04-03 10:00:00.000', '2026-04-03 10:00:00.000'),
('44444444-4444-4444-4444-444444444446', '44444444-4444-4444-4444-444444444444', 'Email Campaign', 'Setup email marketing campaign', 'high', 'todo', 'Kerja', '2026-04-09 15:00:00.000', NULL, 0, 0, 30, 2, '2026-04-03 11:00:00.000', '2026-04-03 11:00:00.000'),
('44444444-4444-4444-4444-444444444447', '44444444-4444-4444-4444-444444444444', 'Meditation', 'Meditasi 15 menit', 'low', 'done', 'Kesehatan', '2026-04-06 20:00:00.000', '2026-04-06 20:15:00.000', 1, 0, 10, 3, '2026-04-05 19:30:00.000', '2026-04-06 20:15:00.000'),
('4a4fde96-1a02-432e-8a19-2a445e67ecd4', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', 'Judul Tugas yang Sangat Panjang Sekali Ini 12345', '', 'medium', 'todo', 'Belajar', NULL, NULL, 0, 0, 20, 0, '2026-04-05 03:36:26.349', '2026-04-05 03:36:26.349'),
('55555555-5555-5555-5555-555555555556', '55555555-5555-5555-5555-555555555555', 'System Architecture Review', 'Review microservices architecture', 'urgent', 'done', 'Kerja', '2026-04-05 17:00:00.000', '2026-04-05 18:30:00.000', 0, 0, 50, 1, '2026-04-04 07:00:00.000', '2026-04-05 18:30:00.000'),
('55555555-5555-5555-5555-555555555557', '55555555-5555-5555-5555-555555555555', 'Team Meeting Preparation', 'Prepare slides untuk team meeting', 'high', 'todo', 'Kerja', '2026-04-07 09:00:00.000', NULL, 0, 0, 35, 2, '2026-04-04 08:00:00.000', '2026-04-04 08:00:00.000'),
('55555555-5555-5555-5555-555555555558', '55555555-5555-5555-5555-555555555555', 'Belajar Kubernetes', 'Kubernetes advanced tutorial', 'medium', 'todo', 'Belajar', '2026-04-25 19:00:00.000', NULL, 0, 0, 25, 3, '2026-04-04 09:00:00.000', '2026-04-04 09:00:00.000'),
('55555555-5555-5555-5555-555555555559', '55555555-5555-5555-5555-555555555555', 'Cycling 10K', 'Bersepeda 10 kilometer', 'low', 'done', 'Kesehatan', '2026-04-06 16:00:00.000', '2026-04-06 17:30:00.000', 1, 0, 15, 4, '2026-04-05 15:00:00.000', '2026-04-06 17:30:00.000'),
('66666666-6666-6666-6666-666666666667', '66666666-6666-6666-6666-666666666666', 'Blog Writing', 'Tulis artikel tentang teknologi', 'medium', 'todo', 'Kreatif', '2026-04-10 14:00:00.000', NULL, 0, 0, 20, 1, '2026-04-04 12:00:00.000', '2026-04-04 12:00:00.000'),
('66666666-6666-6666-6666-666666666668', '66666666-6666-6666-6666-666666666666', 'Customer Support', 'Handle customer tickets', 'high', 'done', 'Kerja', '2026-04-06 10:00:00.000', '2026-04-06 11:30:00.000', 0, 0, 30, 2, '2026-04-05 09:00:00.000', '2026-04-06 11:30:00.000'),
('66666666-6666-6666-6666-666666666669', '66666666-6666-6666-6666-666666666666', 'Pilates', 'Pilates class 1 jam', 'low', 'todo', 'Kesehatan', '2026-04-07 18:00:00.000', NULL, 0, 0, 15, 3, '2026-04-04 13:00:00.000', '2026-04-04 13:00:00.000'),
('77777777-7777-7777-7777-777777777770', '77777777-7777-7777-7777-777777777777', 'Swimming', 'Berenang 30 menit', 'low', 'done', 'Kesehatan', '2026-04-06 17:00:00.000', '2026-04-06 17:30:00.000', 1, 0, 15, 3, '2026-04-05 16:00:00.000', '2026-04-06 17:30:00.000'),
('77777777-7777-7777-7777-777777777778', '77777777-7777-7777-7777-777777777777', 'Security Audit', 'Perform security audit pada aplikasi', 'urgent', 'todo', 'Kerja', '2026-04-08 13:00:00.000', NULL, 0, 0, 50, 1, '2026-04-05 10:00:00.000', '2026-04-05 10:00:00.000'),
('77777777-7777-7777-7777-777777777779', '77777777-7777-7777-7777-777777777777', 'Belajar Cyber Security', 'Online course cyber security module 3', 'medium', 'todo', 'Belajar', '2026-04-18 20:00:00.000', NULL, 0, 0, 25, 2, '2026-04-05 11:00:00.000', '2026-04-05 11:00:00.000'),
('88888888-8888-8888-8888-888888888880', '88888888-8888-8888-8888-888888888888', 'Data Entry', 'Input data ke sistem', 'low', 'done', 'Kerja', '2026-04-05 16:00:00.000', '2026-04-05 17:00:00.000', 0, 0, 15, 2, '2026-04-03 14:00:00.000', '2026-04-05 17:00:00.000'),
('88888888-8888-8888-8888-888888888889', '88888888-8888-8888-8888-888888888888', 'Photography Project', 'Photo shoot untuk produk baru', 'medium', 'todo', 'Kreatif', '2026-04-09 10:00:00.000', NULL, 0, 0, 20, 1, '2026-04-03 13:00:00.000', '2026-04-03 13:00:00.000'),
('90191986-8f7b-4cc1-b459-04338c306348', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'Kerja Rutin', 'Kerja Rutin', 'medium', 'todo', 'Pribadi', '2026-08-12 17:00:00.000', NULL, 0, 0, 20, 0, '2026-04-02 11:22:48.549', '2026-04-02 11:24:13.144'),
('99999999-9999-9999-9999-999999999990', '99999999-9999-9999-9999-999999999999', 'Video Editing', 'Edit video untuk YouTube', 'medium', 'todo', 'Kreatif', '2026-04-11 15:00:00.000', NULL, 0, 0, 20, 1, '2026-04-04 14:00:00.000', '2026-04-04 14:00:00.000'),
('99999999-9999-9999-9999-999999999991', '99999999-9999-9999-9999-999999999999', 'Inventory Check', 'Check inventory gudang', 'high', 'todo', 'Kerja', '2026-04-07 09:00:00.000', NULL, 0, 0, 30, 2, '2026-04-04 15:00:00.000', '2026-04-04 15:00:00.000'),
('9c05e904-cf26-45cf-96f3-dfdfcdf313e9', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'Penting 1', 'Penting 1', 'urgent', 'done', 'Kerja', '2026-04-27 16:15:00.000', '2026-04-16 05:58:00.704', 0, 0, 50, 0, '2026-04-06 05:45:44.638', '2026-04-16 05:58:00.750'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaab', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Market Research', 'Research competitor analysis', 'high', 'done', 'Kerja', '2026-04-06 14:00:00.000', '2026-04-06 16:00:00.000', 0, 0, 35, 1, '2026-04-04 16:00:00.000', '2026-04-06 16:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaac', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Strategic Planning', 'Develop Q2 strategy', 'urgent', 'todo', 'Kerja', '2026-04-08 10:00:00.000', NULL, 0, 0, 50, 2, '2026-04-04 17:00:00.000', '2026-04-04 17:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaad', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Belajar Digital Marketing', 'Google Analytics certification', 'medium', 'todo', 'Belajar', '2026-04-22 19:00:00.000', NULL, 0, 0, 25, 3, '2026-04-04 18:00:00.000', '2026-04-04 18:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaae', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Dance Class', 'Dance class 1 jam', 'low', 'done', 'Kesehatan', '2026-04-06 19:00:00.000', '2026-04-06 20:00:00.000', 1, 0, 15, 4, '2026-04-05 18:00:00.000', '2026-04-06 20:00:00.000'),
('ac297de8-c9f7-4698-8145-e2f0bd94ef18', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'Pengumpulan Draft Proyek.', 'Pengumpulan file proyek 1', 'urgent', 'todo', 'Kerja', '2026-05-18 16:15:00.000', NULL, 0, 0, 50, 0, '2026-04-25 12:24:30.227', '2026-04-25 13:00:14.015'),
('cb17d992-c1e1-40b0-a634-a72a49144f7d', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'Kerja 2', 'Kerja 2', 'low', 'done', 'Kerja', '2026-04-27 21:30:00.000', '2026-04-16 05:58:11.517', 0, 0, 10, 0, '2026-04-05 19:18:25.623', '2026-04-16 05:58:11.519'),
('cfd1a91a-5697-42a8-ab38-95b72956a13e', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', 'Task 2 - Persistence Test', '', 'medium', 'todo', NULL, NULL, NULL, 0, 0, 20, 0, '2026-04-04 04:24:40.535', '2026-04-04 04:24:40.535'),
('e7561a8f-583f-4ac1-a4e1-05826534b053', 'bd2e5d04-3914-4ee2-838e-0d52c4ff34a1', 'Mengerjakan Laporan Keuangan', 'Membuat laporan bulanan untuk bulan Maret 2026.', 'medium', 'todo', NULL, NULL, NULL, 0, 0, 20, 0, '2026-04-04 04:23:04.083', '2026-04-04 04:23:04.083');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction`
--

CREATE TABLE `transaction` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `amount` double NOT NULL,
  `category` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `paymentMethod` varchar(191) NOT NULL DEFAULT 'cash',
  `transactionDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `coaType` varchar(191) NOT NULL DEFAULT 'EXPENSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction`
--

INSERT INTO `transaction` (`id`, `userId`, `type`, `amount`, `category`, `description`, `paymentMethod`, `transactionDate`, `createdAt`, `updatedAt`, `coaType`) VALUES
('11111111-1111-1111-1111-111111111117', '11111111-1111-1111-1111-111111111111', 'income', 15000000, 'Gaji', 'Gaji bulanan April', 'transfer', '2026-04-01 00:00:00.000', '2026-04-01 08:00:00.000', '2026-04-01 08:00:00.000', 'EXPENSE'),
('11111111-1111-1111-1111-111111111118', '11111111-1111-1111-1111-111111111111', 'expense', 2500000, 'Sewa', 'Sewa apartemen', 'transfer', '2026-04-02 00:00:00.000', '2026-04-02 09:00:00.000', '2026-04-02 09:00:00.000', 'EXPENSE'),
('11111111-1111-1111-1111-111111111119', '11111111-1111-1111-1111-111111111111', 'expense', 500000, 'Makanan', 'Grocery shopping', 'cash', '2026-04-03 00:00:00.000', '2026-04-03 10:00:00.000', '2026-04-03 10:00:00.000', 'EXPENSE'),
('11111111-1111-1111-1111-111111111120', '11111111-1111-1111-1111-111111111111', 'income', 2000000, 'Freelance', 'Side project web development', 'transfer', '2026-04-04 00:00:00.000', '2026-04-04 11:00:00.000', '2026-04-04 11:00:00.000', 'EXPENSE'),
('11111111-1111-1111-1111-111111111121', '11111111-1111-1111-1111-111111111111', 'expense', 150000, 'Transport', 'Gojek monthly pass', 'ewallet', '2026-04-05 00:00:00.000', '2026-04-05 12:00:00.000', '2026-04-05 12:00:00.000', 'EXPENSE'),
('1d5733ed-cde4-40a3-9d4a-4625f9cc150b', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 1000000, 'Bonus', NULL, 'cash', '2026-04-08 00:00:00.000', '2026-04-17 14:28:03.296', '2026-04-17 14:28:03.296', 'REVENUE'),
('22222222-2222-2222-2222-222222222227', '22222222-2222-2222-2222-222222222222', 'income', 8000000, 'Gaji', 'Gaji bulanan April', 'transfer', '2026-04-01 00:00:00.000', '2026-04-01 09:00:00.000', '2026-04-01 09:00:00.000', 'EXPENSE'),
('22222222-2222-2222-2222-222222222228', '22222222-2222-2222-2222-222222222222', 'expense', 1200000, 'Kos', 'Sewa kos bulanan', 'cash', '2026-04-02 00:00:00.000', '2026-04-02 10:00:00.000', '2026-04-02 10:00:00.000', 'EXPENSE'),
('22222222-2222-2222-2222-222222222229', '22222222-2222-2222-2222-222222222222', 'expense', 300000, 'Belanja', 'Baju dan makeup', 'ewallet', '2026-04-03 00:00:00.000', '2026-04-03 11:00:00.000', '2026-04-03 11:00:00.000', 'EXPENSE'),
('22222222-2222-2222-2222-222222222230', '22222222-2222-2222-2222-222222222222', 'income', 500000, 'Bonus', 'Bonus project', 'transfer', '2026-04-04 00:00:00.000', '2026-04-04 12:00:00.000', '2026-04-04 12:00:00.000', 'EXPENSE'),
('33333333-3333-3333-3333-333333333338', '33333333-3333-3333-3333-333333333333', 'income', 12000000, 'Gaji', 'Gaji bulanan April', 'transfer', '2026-04-01 00:00:00.000', '2026-04-01 08:30:00.000', '2026-04-01 08:30:00.000', 'EXPENSE'),
('33333333-3333-3333-3333-333333333339', '33333333-3333-3333-3333-333333333333', 'expense', 3000000, 'Rumah', 'Cicilan KPR', 'transfer', '2026-04-02 00:00:00.000', '2026-04-02 09:30:00.000', '2026-04-02 09:30:00.000', 'EXPENSE'),
('33333333-3333-3333-3333-333333333340', '33333333-3333-3333-3333-333333333333', 'expense', 800000, 'Listrik', 'Tagihan listrik', 'transfer', '2026-04-03 00:00:00.000', '2026-04-03 10:30:00.000', '2026-04-03 10:30:00.000', 'EXPENSE'),
('33333333-3333-3333-3333-333333333341', '33333333-3333-3333-3333-333333333333', 'income', 1500000, 'Investasi', 'Dividen saham', 'transfer', '2026-04-04 00:00:00.000', '2026-04-04 11:30:00.000', '2026-04-04 11:30:00.000', 'EXPENSE'),
('33333333-3333-3333-3333-333333333342', '33333333-3333-3333-3333-333333333333', 'expense', 400000, 'Asuransi', 'Premi asuransi', 'transfer', '2026-04-05 00:00:00.000', '2026-04-05 12:30:00.000', '2026-04-05 12:30:00.000', 'EXPENSE'),
('3a4bcd05-a78c-4f3a-a67d-909537a74d88', '9ff4e615-86e4-483d-abd0-3a9b58d3d000', 'expense', 50000, 'Makan Siang Enak', NULL, 'cash', '2026-05-06 00:00:00.000', '2026-05-06 09:18:27.844', '2026-05-06 09:18:27.844', 'REVENUE'),
('3ffca4f9-7632-490a-a792-8ea9eb19ab1f', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 10000000, 'Peraralatan Operasional IT', NULL, 'cash', '2026-04-25 00:00:00.000', '2026-04-25 12:14:21.995', '2026-04-25 12:14:21.995', 'EXPENSE'),
('43a359b7-bbd6-4a29-bed4-e9307159e3b7', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 100000, 'Gaji', 'gajian', 'cash', '2026-05-07 00:00:00.000', '2026-04-05 20:33:05.272', '2026-04-05 20:33:05.272', 'EXPENSE'),
('44444444-4444-4444-4444-444444444448', '44444444-4444-4444-4444-444444444444', 'income', 6000000, 'Gaji', 'Gaji bulanan April', 'transfer', '2026-04-01 00:00:00.000', '2026-04-01 10:00:00.000', '2026-04-01 10:00:00.000', 'EXPENSE'),
('44444444-4444-4444-4444-444444444449', '44444444-4444-4444-4444-444444444444', 'expense', 1000000, 'Kos', 'Sewa kos', 'cash', '2026-04-02 00:00:00.000', '2026-04-02 11:00:00.000', '2026-04-02 11:00:00.000', 'EXPENSE'),
('44444444-4444-4444-4444-444444444450', '44444444-4444-4444-4444-444444444444', 'expense', 200000, 'Hiburan', 'Netflix subscription', 'ewallet', '2026-04-03 00:00:00.000', '2026-04-03 12:00:00.000', '2026-04-03 12:00:00.000', 'EXPENSE'),
('4851ac97-23c1-48a2-9d70-f4ce6938444f', '9ff4e615-86e4-483d-abd0-3a9b58d3d000', 'expense', 50000, 'Makan Siang Enak', NULL, 'cash', '2026-05-06 00:00:00.000', '2026-05-06 09:13:59.670', '2026-05-06 09:13:59.670', 'REVENUE'),
('55555555-5555-5555-5555-555555555560', '55555555-5555-5555-5555-555555555555', 'income', 18000000, 'Gaji', 'Gaji bulanan April', 'transfer', '2026-04-01 00:00:00.000', '2026-04-01 07:00:00.000', '2026-04-01 07:00:00.000', 'EXPENSE'),
('55555555-5555-5555-5555-555555555561', '55555555-5555-5555-5555-555555555555', 'expense', 5000000, 'Investasi', 'Beli reksadana', 'transfer', '2026-04-02 00:00:00.000', '2026-04-02 08:00:00.000', '2026-04-02 08:00:00.000', 'EXPENSE'),
('55555555-5555-5555-5555-555555555562', '55555555-5555-5555-5555-555555555555', 'income', 3000000, 'Bonus', 'Bonus Q1', 'transfer', '2026-04-03 00:00:00.000', '2026-04-03 09:00:00.000', '2026-04-03 09:00:00.000', 'EXPENSE'),
('55555555-5555-5555-5555-555555555563', '55555555-5555-5555-5555-555555555555', 'expense', 1500000, 'Liburan', 'Booking hotel', 'credit_card', '2026-04-04 00:00:00.000', '2026-04-04 10:00:00.000', '2026-04-04 10:00:00.000', 'EXPENSE'),
('55555555-5555-5555-5555-555555555564', '55555555-5555-5555-5555-555555555555', 'expense', 600000, 'Mobil', 'Service mobil', 'cash', '2026-04-05 00:00:00.000', '2026-04-05 11:00:00.000', '2026-04-05 11:00:00.000', 'EXPENSE'),
('5cc5f1dc-6349-4889-8179-12016884591b', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 10000, 'bayar buku', '', 'cash', '2026-05-14 00:00:00.000', '2026-04-05 20:33:30.620', '2026-04-05 20:33:30.620', 'EXPENSE'),
('5faeeafa-dac1-4a68-8a52-78491d589776', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 6000000, 'Peraralatan Operasional IT', 'Beli Peraralatan Operasional IT', 'cash', '2026-05-01 00:00:00.000', '2026-04-06 15:54:45.081', '2026-04-06 15:54:45.081', 'EXPENSE'),
('60e2d6d6-114a-4cb2-bbbe-e9451dea7ede', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 100000000, 'Gaji Proyek', NULL, 'cash', '2026-04-01 00:00:00.000', '2026-04-25 12:42:20.617', '2026-04-25 12:42:20.617', 'REVENUE'),
('6561126a-f962-4689-9f23-aae49d343112', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'income', 1500000, 'Gaji', '', 'cash', '2026-04-02 00:00:00.000', '2026-04-02 11:52:22.840', '2026-04-02 11:52:22.840', 'EXPENSE'),
('7e7df4af-a882-4d00-8c13-69a7004e002d', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 7000000, 'Gaji', 'gajian', 'cash', '2026-04-12 00:00:00.000', '2026-04-12 14:13:11.532', '2026-04-12 14:13:11.532', 'EXPENSE'),
('8a64e1e4-e6ec-4d7e-9ce5-b2dabe91e0b1', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 1000000, 'Bayar Listrik', NULL, 'cash', '2026-04-25 00:00:00.000', '2026-04-25 12:12:11.291', '2026-04-25 12:12:11.291', 'EXPENSE'),
('92b186ad-f657-4f33-9cf0-c238da112cd7', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 100000, 'Gaji', 'gajian', 'cash', '2026-05-07 00:00:00.000', '2026-04-05 20:33:04.799', '2026-04-05 20:33:04.799', 'EXPENSE'),
('9cdfd479-11b7-49a7-9b66-44d61470a17e', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'expense', 1000000, 'makan', '', 'cash', '2026-04-02 00:00:00.000', '2026-04-02 11:52:57.840', '2026-04-02 11:52:57.840', 'EXPENSE'),
('cb00c7b2-10bf-464a-8e95-2ff0b0afaf0a', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 2000000, 'Gaji', 'Gaji', 'cash', '2026-04-03 00:00:00.000', '2026-04-03 03:13:39.460', '2026-04-03 03:13:39.460', 'EXPENSE'),
('cbad569e-d56d-49ec-b755-7e59c04b20f1', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 100000, 'Bayar', 'Bayar Tagihan Listrik', 'cash', '2026-04-03 00:00:00.000', '2026-04-03 03:10:12.446', '2026-04-03 03:10:12.446', 'EXPENSE'),
('d58c94e3-3d02-43f4-88df-608119f5aa33', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'income', 1000000, 'Gaji', 'Gajian', 'cash', '2026-04-04 00:00:00.000', '2026-04-04 08:17:34.499', '2026-04-04 08:17:34.499', 'EXPENSE'),
('dbe2eea7-4a15-4c73-a468-9a86282ab225', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 100000, 'Gaji', 'gajian', 'cash', '2026-04-03 00:00:00.000', '2026-04-03 03:10:57.255', '2026-04-03 03:10:57.255', 'EXPENSE'),
('dd8021b1-5b07-4866-9d8c-1cea71244219', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 1000000, 'Gaji', 'gajian', 'cash', '2026-04-11 00:00:00.000', '2026-04-11 12:34:27.768', '2026-04-11 12:34:27.768', 'EXPENSE'),
('ded5d798-c98c-4e77-8af8-2dc21a0f62a2', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 20000000, 'Anggaran pengadaan Perangkat Keras perkantoran', NULL, 'cash', '2026-04-15 00:00:00.000', '2026-04-27 13:55:52.753', '2026-04-27 13:55:52.753', 'REVENUE'),
('ef33c027-f78c-41d2-9851-876eae22828d', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'income', 7000000, 'Gaji', 'gajian', 'cash', '2026-04-12 00:00:00.000', '2026-04-12 14:13:42.067', '2026-04-12 14:13:42.067', 'EXPENSE'),
('f06c2941-5632-49d6-b9ca-327f1e36fa89', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 100000, 'Bayar Listrik', NULL, 'e-wallet', '2026-04-27 00:00:00.000', '2026-04-27 13:51:36.076', '2026-04-27 13:51:36.076', 'EXPENSE'),
('fb60ba87-15e3-4fc6-9b91-56e16a23d6f8', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'expense', 2000000, 'Peraralatan Operasional IT', NULL, 'transfer', '2026-04-27 00:00:00.000', '2026-04-27 13:52:37.645', '2026-04-27 13:52:37.645', 'ASSET');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `passwordHash` varchar(191) NOT NULL,
  `fullName` varchar(191) NOT NULL,
  `avatarUrl` varchar(191) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `totalXP` int(11) NOT NULL DEFAULT 0,
  `loginStreak` int(11) NOT NULL DEFAULT 0,
  `lastLoginAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `role` varchar(191) NOT NULL DEFAULT 'USER',
  `companyAddress` text DEFAULT NULL,
  `companyLogoUrl` varchar(191) DEFAULT NULL,
  `companyName` varchar(191) DEFAULT NULL,
  `resetPasswordExpires` datetime(3) DEFAULT NULL,
  `resetPasswordToken` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `email`, `username`, `passwordHash`, `fullName`, `avatarUrl`, `level`, `totalXP`, `loginStreak`, `lastLoginAt`, `createdAt`, `updatedAt`, `role`, `companyAddress`, `companyLogoUrl`, `companyName`, `resetPasswordExpires`, `resetPasswordToken`) VALUES
('03fdc079-15e4-48a0-97a2-b95faa984d84', 'efendisugiantoro14@gmail.com', 'EFENDI_14', '$2b$10$yzto5FNdNNi3/8XbM4OWBeQ0V7U2PgVGJxj2AerstSuu9hpA7Tp4G', 'Efendi Sugiantoro', '/uploads/avatars/avatar-03fdc079-15e4-48a0-97a2-b95faa984d84-6f4a1044-60a8-4e5a-90e8-d70b58075190.png', 1, 230, 1, '2026-06-13 05:48:57.903', '2026-04-03 03:00:45.363', '2026-06-13 05:48:57.905', 'ADMIN', NULL, NULL, NULL, NULL, NULL),
('11111111-1111-1111-1111-111111111111', 'andra.pramudita@email.com', 'Andra_P', '$2b$12$X.Vfz5Z8z8z8z8z8z8z8zO', 'Andra Pramudita', '/uploads/avatars/avatar-11111111-1111-1111-1111-111111111111.png', 3, 890, 15, '2026-04-06 08:30:00.000', '2026-03-15 10:00:00.000', '2026-04-06 08:30:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('22222222-2222-2222-2222-222222222222', 'siti.nurhaliza@email.com', 'Siti_N', '$2b$12$Y.Wfz5Z9z9z9z9z9z9z9zP', 'Siti Nurhaliza', '/uploads/avatars/avatar-22222222-2222-2222-2222-222222222222.png', 2, 450, 8, '2026-04-05 19:45:00.000', '2026-03-20 14:30:00.000', '2026-04-05 19:45:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('23fcb7d6-b4bc-4b4b-83a6-ca492ecc5a4e', 'admin123456@email.com', 'admin123456', '$2b$12$p5aSNCyeaB2qZjDIt5Khled6CWhpNAude.CCUPdEolJ2EYcLo6.Xe', 'Test Admin', NULL, 1, 0, 0, NULL, '2026-04-03 08:45:16.565', '2026-04-03 08:45:16.565', 'USER', NULL, NULL, NULL, NULL, NULL),
('33333333-3333-3333-3333-333333333333', 'budi.santoso@email.com', 'Budi_S', '$2b$12$Z.Vfz5Z0z0z0z0z0z0z0zQ', 'Budi Santoso', '/uploads/avatars/avatar-33333333-3333-3333-3333-333333333333.png', 4, 1200, 22, '2026-04-06 07:15:00.000', '2026-03-01 09:00:00.000', '2026-04-06 07:15:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('44444444-4444-4444-4444-444444444444', 'diana.kusuma@email.com', 'Diana_K', '$2b$12$A.Wfz5Z1z1z1z1z1z1z1zR', 'Diana Kusuma', '/uploads/avatars/avatar-44444444-4444-4444-4444-444444444444.png', 1, 180, 3, '2026-04-04 16:20:00.000', '2026-03-25 11:00:00.000', '2026-04-04 16:20:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('449fa87b-655a-4576-8a9c-6dbf3935c16d', 'efendisugiantoro183@gmail.com', 'Efendi183', '$2b$12$pQDlqbPFOGjTSGOFDkQRwuxYq1HrbdNmTRLM/mEeHJn0066b6aVcq', 'Efendi Sugiantoro', NULL, 1, 0, 0, NULL, '2026-04-27 13:46:42.922', '2026-04-27 13:46:42.922', 'USER', NULL, NULL, NULL, NULL, NULL),
('55555555-5555-5555-5555-555555555555', 'eko.prasetyo@email.com', 'Eko_P', '$2b$12$B.Wfz5Z2z2z2z2z2z2z2zS', 'Eko Prasetyo', '/uploads/avatars/avatar-55555555-5555-5555-5555-555555555555.png', 5, 2100, 30, '2026-04-06 06:00:00.000', '2026-02-15 13:00:00.000', '2026-04-06 06:00:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('66666666-6666-6666-6666-666666666666', 'rina.wulandari@email.com', 'Rina_W', '$2b$12$C.Wfz5Z3z3z3z3z3z3z3zT', 'Rina Wulandari', '/uploads/avatars/avatar-66666666-6666-6666-6666-666666666666.png', 2, 320, 12, '2026-04-05 20:30:00.000', '2026-03-18 15:45:00.000', '2026-04-05 20:30:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 'efendisugiantoro15@gmail.com', 'Efendi_JKT', '$2b$12$R.QU3MDHYrZMsv66cRAnbeFGMowDdcQPwwISxWYypyVM2EbdqmgRK', 'Efendi Sugiantoro', '/uploads/avatars/avatar-727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f-5c78cd42-9803-45c1-b3b7-748af63bc4c5.png', 1, 110, 1, '2026-06-11 13:21:37.691', '2026-04-02 11:06:20.968', '2026-06-13 05:42:49.738', 'ADMIN', NULL, NULL, NULL, NULL, NULL),
('72b5eb77-9e51-4f38-9195-bfc51d9b0bf4', 'test99@fintask.com', 'testuser99', '$2b$12$koCrUfmT1ekg17T5LfCxEOg8rvzl5aw1JBRcwT0bA76JTQSvySTyK', 'Test User', NULL, 1, 0, 0, NULL, '2026-04-02 10:53:41.056', '2026-04-02 10:53:41.056', 'USER', NULL, NULL, NULL, NULL, NULL),
('77777777-7777-7777-7777-777777777777', 'ahmad.fauzi@email.com', 'Ahmad_F', '$2b$12$D.Wfz5Z4z4z4z4z4z4z4zU', 'Ahmad Fauzi', '/uploads/avatars/avatar-77777777-7777-7777-7777-777777777777.png', 3, 750, 18, '2026-04-06 09:45:00.000', '2026-03-10 08:30:00.000', '2026-04-13 22:46:48.131', 'USER', NULL, NULL, NULL, NULL, NULL),
('79110d3b-1eb7-40fc-a8b0-20d804a5cf38', 'efendisugiantoro16@gmail.com', 'efendisugiantoro16@gmail.com', '$2b$12$zCKyIqSB8ZayOj62fd2R4u6pEsiH0xCC3UsAIcX4abGbJrLULvnuu', 'Efendi Sugiantoro', NULL, 1, 0, 0, NULL, '2026-04-17 14:09:59.534', '2026-04-17 14:09:59.534', 'USER', NULL, NULL, NULL, NULL, NULL),
('88888888-8888-8888-8888-888888888888', 'maya.sari@email.com', 'Maya_S', '$2b$12$E.Wfz5Z5z5z5z5z5z5z5zV', 'Maya Sari', '/uploads/avatars/avatar-88888888-8888-8888-8888-888888888888.png', 1, 95, 5, '2026-04-04 14:15:00.000', '2026-03-28 16:00:00.000', '2026-04-04 14:15:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('99999999-9999-9999-9999-999999999999', 'rudi.hartono@email.com', 'Rudi_H', '$2b$12$F.Wfz5Z6z6z6z6z6z6z6zW', 'Rudi Hartono', '/uploads/avatars/avatar-99999999-9999-9999-9999-999999999999.png', 2, 280, 7, '2026-04-05 18:00:00.000', '2026-03-22 12:30:00.000', '2026-04-05 18:00:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('9ff4e615-86e4-483d-abd0-3a9b58d3d000', 'test@fintask.com', 'fintask_tester', '$2b$10$mCi/Nv.mer983bEuUAiYCenwO3BSWrmaz.Xtpn9yFVmCH67MzQsg.', 'FinTask Tester', NULL, 3, 2460, 1, '2026-05-06 09:18:22.467', '2026-04-02 10:26:33.269', '2026-05-06 09:18:27.864', 'USER', NULL, NULL, NULL, NULL, NULL),
('a58280a4-8720-4aef-bbe4-bf982979dbf7', 'testuser100@email.com', 'testuser100', '$2b$12$I2CaSOJeCKtc4iOz.a0SS.SpXYyu5X.vOS5IbZEl7VSzpaSk6bYtq', 'Test User', NULL, 1, 50, 1, '2026-04-13 22:34:07.281', '2026-04-02 11:03:09.004', '2026-04-13 22:34:07.283', 'USER', NULL, NULL, NULL, NULL, NULL),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'lisa.permata@email.com', 'Lisa_P', '$2b$12$G.Wfz5Z7z7z7z7z7z7z7zX', 'Lisa Permata', '/uploads/avatars/avatar-aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.png', 4, 1500, 25, '2026-04-06 05:30:00.000', '2026-02-28 10:15:00.000', '2026-04-06 05:30:00.000', 'USER', NULL, NULL, NULL, NULL, NULL),
('bd2e5d04-3914-4ee2-838e-0d52c4ff34a1', 'testuser200@email.com', 'testuser200', '$2b$12$wnFj3ivblMC6Ve1l5DQrqOB2Em1lGkDEMNaWRhQphxBPsD6qcy332', 'Test User 200', NULL, 1, 0, 0, NULL, '2026-04-04 04:22:30.050', '2026-04-04 04:22:30.050', 'USER', NULL, NULL, NULL, NULL, NULL),
('e28a3c74-0501-4bff-aa0c-38beeb75d46f', 'admin@fintask.com', 'admin', '$2b$10$i0b.rpfIEHdpfwZ60XZJIuqjAUb6tsuZHM6JUbzKfXNCmkcHnQob6', 'Administrator', NULL, 99, 9999, 0, NULL, '2026-06-13 05:26:06.842', '2026-06-13 05:42:20.697', 'ADMIN', NULL, NULL, NULL, NULL, NULL),
('fb4f6545-7d53-409e-a583-76113aec8f7b', 'superadmin@fintask.com', 'superadmin', '$2b$10$aETdZXmoRrpBkFclosH6sezMEHanI4jNbVJK/ZbLJTF5P5yv8t1va', 'Super Administrator', '/uploads/avatars/avatar-fb4f6545-7d53-409e-a583-76113aec8f7b-80e83513-f8fe-4042-a917-afea0ec41ecc.png', 999, 99999, 1, '2026-06-13 05:57:14.148', '2026-06-13 05:26:07.120', '2026-06-13 05:57:14.150', 'SUPERADMIN', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `userbadge`
--

CREATE TABLE `userbadge` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `badgeId` varchar(191) NOT NULL,
  `unlockedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `userbadge`
--

INSERT INTO `userbadge` (`id`, `userId`, `badgeId`, `unlockedAt`) VALUES
('11111111-1111-1111-1111-111111111128', '11111111-1111-1111-1111-111111111111', '8d643d00-5981-4178-88b5-cd5835a1fccb', '2026-03-20 08:00:00.000'),
('11111111-1111-1111-1111-111111111129', '11111111-1111-1111-1111-111111111111', 'd0099733-6b1e-4e2c-a386-451b7ffdedbd', '2026-03-25 09:00:00.000'),
('11111111-1111-1111-1111-111111111130', '11111111-1111-1111-1111-111111111111', 'b9a08471-c4ad-4c09-aec3-ca0cb786a16f', '2026-04-01 10:00:00.000'),
('11111111-1111-1111-1111-111111111131', '11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', '2026-04-05 11:00:00.000'),
('22222222-2222-2222-2222-222222222235', '22222222-2222-2222-2222-222222222222', 'd0099733-6b1e-4e2c-a386-451b7ffdedbd', '2026-03-22 10:00:00.000'),
('22222222-2222-2222-2222-222222222236', '22222222-2222-2222-2222-222222222222', 'b5dfdc5c-0c98-4eb5-8e2c-290b379a433c', '2026-03-28 11:00:00.000'),
('22222222-2222-2222-2222-222222222237', '22222222-2222-2222-2222-222222222222', '77777777-7777-7777-7777-777777777777', '2026-04-03 12:00:00.000'),
('33333333-3333-3333-3333-333333333347', '33333333-3333-3333-3333-333333333333', '051ecb15-bfe7-4fb8-a8db-5b6309c2463d', '2026-03-15 08:30:00.000'),
('33333333-3333-3333-3333-333333333348', '33333333-3333-3333-3333-333333333333', '0216defc-a6c3-45e0-9d84-579cf2604d12', '2026-04-01 09:30:00.000'),
('33333333-3333-3333-3333-333333333349', '33333333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333333', '2026-04-04 10:30:00.000'),
('55555555-5555-5555-5555-555555555569', '55555555-5555-5555-5555-555555555555', '051ecb15-bfe7-4fb8-a8db-5b6309c2463d', '2026-03-10 07:00:00.000'),
('55555555-5555-5555-5555-555555555570', '55555555-5555-5555-5555-555555555555', '0216defc-a6c3-45e0-9d84-579cf2604d12', '2026-03-25 08:00:00.000'),
('55555555-5555-5555-5555-555555555571', '55555555-5555-5555-5555-555555555555', 'f5978541-f244-4add-8327-22c4c6e452d4', '2026-04-02 09:00:00.000'),
('55555555-5555-5555-5555-555555555572', '55555555-5555-5555-5555-555555555555', '55555555-5555-5555-5555-555555555555', '2026-04-05 10:00:00.000'),
('73123c57-1502-46fa-87f7-272fea468f9b', '03fdc079-15e4-48a0-97a2-b95faa984d84', 'd0099733-6b1e-4e2c-a386-451b7ffdedbd', '2026-04-06 05:43:16.277'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaj', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '051ecb15-bfe7-4fb8-a8db-5b6309c2463d', '2026-03-18 16:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaak', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '0216defc-a6c3-45e0-9d84-579cf2604d12', '2026-04-01 17:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaal', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', '2026-04-04 18:00:00.000'),
('bc36e6bf-8313-4433-88cf-4189872e7bc2', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', '8d643d00-5981-4178-88b5-cd5835a1fccb', '2026-04-04 03:28:38.332'),
('ff595428-e030-4354-861d-eb8411d6c597', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', '8d643d00-5981-4178-88b5-cd5835a1fccb', '2026-04-04 04:23:23.694');

-- --------------------------------------------------------

--
-- Struktur dari tabel `xphistory`
--

CREATE TABLE `xphistory` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `amount` int(11) NOT NULL,
  `source` varchar(191) NOT NULL,
  `sourceId` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `earnedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `xphistory`
--

INSERT INTO `xphistory` (`id`, `userId`, `amount`, `source`, `sourceId`, `description`, `earnedAt`) VALUES
('0aa90468-03fa-49b9-844b-d8b7c6c15755', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 50, 'badge_unlock', '8d643d00-5981-4178-88b5-cd5835a1fccb', 'Membuka lencana: On Fire', '2026-04-04 03:28:38.387'),
('11111111-1111-1111-1111-111111111132', '11111111-1111-1111-1111-111111111111', 35, 'task_complete', '11111111-1111-1111-1111-111111111112', 'Menyelesaikan task: Review Code Pull Request', '2026-04-06 08:25:00.000'),
('11111111-1111-1111-1111-111111111133', '11111111-1111-1111-1111-111111111111', 25, 'pomodoro', '11111111-1111-1111-1111-111111111125', 'Selesaikan sesi fokus Pomodoro selama 25 menit', '2026-04-06 08:25:00.000'),
('11111111-1111-1111-1111-111111111134', '11111111-1111-1111-1111-111111111111', 45, 'pomodoro', '11111111-1111-1111-1111-111111111126', 'Selesaikan sesi fokus Pomodoro selama 45 menit', '2026-04-06 19:15:00.000'),
('11111111-1111-1111-1111-111111111135', '11111111-1111-1111-1111-111111111111', 15, 'task_complete', '11111111-1111-1111-1111-111111111114', 'Menyelesaikan task: Workout di Gym', '2026-04-06 19:30:00.000'),
('11111111-1111-1111-1111-111111111136', '11111111-1111-1111-1111-111111111111', 50, 'badge_unlock', '11111111-1111-1111-1111-111111111111', 'Membuka lencana: Early Bird', '2026-04-05 11:00:00.000'),
('19e7154f-8525-494f-80ec-c634ea630b27', '03fdc079-15e4-48a0-97a2-b95faa984d84', 10, 'task_complete', '1699495e-51fd-42f6-adc9-24c6b9ffa855', 'Menyelesaikan task: Kerja 3', '2026-04-16 05:58:09.784'),
('22222222-2222-2222-2222-222222222238', '22222222-2222-2222-2222-222222222222', 30, 'task_complete', '22222222-2222-2222-2222-222222222223', 'Menyelesaikan task: Design UI Dashboard', '2026-04-05 14:20:00.000'),
('22222222-2222-2222-2222-222222222239', '22222222-2222-2222-2222-222222222222', 50, 'pomodoro', '22222222-2222-2222-2222-222222222233', 'Selesaikan sesi fokus Pomodoro selama 50 menit', '2026-04-05 13:50:00.000'),
('22222222-2222-2222-2222-222222222240', '22222222-2222-2222-2222-222222222222', 25, 'pomodoro', '22222222-2222-2222-2222-222222222234', 'Selesaikan sesi fokus Pomodoro selama 25 menit', '2026-04-05 19:25:00.000'),
('22222222-2222-2222-2222-222222222241', '22222222-2222-2222-2222-222222222222', 15, 'task_complete', '22222222-2222-2222-2222-222222222225', 'Menyelesaikan task: Yoga Session', '2026-04-06 07:00:00.000'),
('22222222-2222-2222-2222-222222222242', '22222222-2222-2222-2222-222222222222', 25, 'badge_unlock', 'b5dfdc5c-0c98-4eb5-8e2c-290b379a433c', 'Membuka lencana: Zen Initiate', '2026-03-28 11:00:00.000'),
('22222222-2222-2222-2222-222222222243', '22222222-2222-2222-2222-222222222222', 120, 'badge_unlock', '77777777-7777-7777-7777-777777777777', 'Membuka lencana: Learning Machine', '2026-04-03 12:00:00.000'),
('33333333-3333-3333-3333-333333333350', '33333333-3333-3333-3333-333333333333', 45, 'task_complete', '33333333-3333-3333-3333-333333333334', 'Menyelesaikan task: Database Optimization', '2026-04-05 16:45:00.000'),
('33333333-3333-3333-3333-333333333351', '33333333-3333-3333-3333-333333333333', 60, 'pomodoro', '33333333-3333-3333-3333-333333333345', 'Selesaikan sesi fokus Pomodoro selama 60 menit', '2026-04-05 15:00:00.000'),
('33333333-3333-3333-3333-333333333352', '33333333-3333-3333-3333-333333333333', 15, 'task_complete', '33333333-3333-3333-3333-333333333337', 'Menyelesaikan task: Running 5K', '2026-04-06 06:30:00.000'),
('33333333-3333-3333-3333-333333333353', '33333333-3333-3333-3333-333333333333', 100, 'badge_unlock', '0216defc-a6c3-45e0-9d84-579cf2604d12', 'Membuka lencana: Marathon', '2026-04-01 09:30:00.000'),
('33333333-3333-3333-3333-333333333354', '33333333-3333-3333-3333-333333333333', 100, 'badge_unlock', '33333333-3333-3333-3333-333333333333', 'Membuka lencana: Financial Guru', '2026-04-04 10:30:00.000'),
('3966de14-e340-4190-b547-539cf58fb391', '03fdc079-15e4-48a0-97a2-b95faa984d84', 35, 'task_complete', '441cfa86-28e6-45bf-a94e-a1dcdfe69898', 'Menyelesaikan task: Kerja 1', '2026-04-05 19:04:16.472'),
('3fbf2127-68df-4bd4-977b-b3622d6fdf1b', '03fdc079-15e4-48a0-97a2-b95faa984d84', 50, 'task_complete', 'ac297de8-c9f7-4698-8145-e2f0bd94ef18', 'Menyelesaikan task: Pengumpulan Draft Proyek.', '2026-04-25 13:00:13.174'),
('43ee8ed2-d763-4c45-91ba-f666b5592a25', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 20, 'task_complete', '90191986-8f7b-4cc1-b459-04338c306348', 'Menyelesaikan task: Kerja Rutin', '2026-04-02 11:23:05.201'),
('462ca7eb-d611-41dd-b3b4-c3a36f6b30c9', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 20, 'task_complete', '90191986-8f7b-4cc1-b459-04338c306348', 'Menyelesaikan task: Kerja Rutin', '2026-04-02 11:22:55.757'),
('55555555-5555-5555-5555-555555555573', '55555555-5555-5555-5555-555555555555', 50, 'task_complete', '55555555-5555-5555-5555-555555555556', 'Menyelesaikan task: System Architecture Review', '2026-04-05 18:30:00.000'),
('55555555-5555-5555-5555-555555555574', '55555555-5555-5555-5555-555555555555', 90, 'pomodoro', '55555555-5555-5555-5555-555555555567', 'Selesaikan sesi fokus Pomodoro selama 90 menit', '2026-04-05 17:30:00.000'),
('55555555-5555-5555-5555-555555555575', '55555555-5555-5555-5555-555555555555', 15, 'task_complete', '55555555-5555-5555-5555-555555555559', 'Menyelesaikan task: Cycling 10K', '2026-04-06 17:30:00.000'),
('55555555-5555-5555-5555-555555555576', '55555555-5555-5555-5555-555555555555', 100, 'badge_unlock', '051ecb15-bfe7-4fb8-a8db-5b6309c2463d', 'Membuka lencana: Task Master', '2026-03-10 07:00:00.000'),
('55555555-5555-5555-5555-555555555577', '55555555-5555-5555-5555-555555555555', 100, 'badge_unlock', '0216defc-a6c3-45e0-9d84-579cf2604d12', 'Membuka lencana: Marathon', '2026-03-25 08:00:00.000'),
('55555555-5555-5555-5555-555555555578', '55555555-5555-5555-5555-555555555555', 50, 'badge_unlock', 'f5978541-f244-4add-8327-22c4c6e452d4', 'Membuka lencana: Time Lord', '2026-04-02 09:00:00.000'),
('55555555-5555-5555-5555-555555555579', '55555555-5555-5555-5555-555555555555', 80, 'badge_unlock', '55555555-5555-5555-5555-555555555555', 'Membuka lencana: Speed Runner', '2026-04-05 10:00:00.000'),
('6751a4d9-1aaa-49ad-9927-897f2e7bc2da', 'a58280a4-8720-4aef-bbe4-bf982979dbf7', 50, 'badge_unlock', '8d643d00-5981-4178-88b5-cd5835a1fccb', 'Membuka lencana: On Fire', '2026-04-04 04:23:23.723'),
('78244f90-08f3-4a0a-a98b-d4bd21d308de', '9ff4e615-86e4-483d-abd0-3a9b58d3d000', 10, 'finance_transaction', '3a4bcd05-a78c-4f3a-a67d-909537a74d88', 'Mencatat transaksi: Makan Siang Enak', '2026-05-06 09:18:27.882'),
('a7c1279c-f7d8-4a35-a1d0-dd85279f8ebc', '03fdc079-15e4-48a0-97a2-b95faa984d84', 10, 'task_complete', 'cb17d992-c1e1-40b0-a634-a72a49144f7d', 'Menyelesaikan task: Kerja 2', '2026-04-06 05:43:16.216'),
('a84be710-e5ae-48b8-94de-2f46ab4e6a8e', '03fdc079-15e4-48a0-97a2-b95faa984d84', 25, 'pomodoro', 'a8332637-94c4-49b6-94d6-eff252a660c2', 'Selesaikan sesi fokus Pomodoro selama 25 menit', '2026-04-03 03:30:17.420'),
('a8adb99b-fe46-4bc7-92e7-fd5f7083e6e3', '03fdc079-15e4-48a0-97a2-b95faa984d84', 50, 'task_complete', '9c05e904-cf26-45cf-96f3-dfdfcdf313e9', 'Menyelesaikan task: Penting 1', '2026-04-16 05:58:00.713'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaam', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 35, 'task_complete', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaab', 'Menyelesaikan task: Market Research', '2026-04-06 16:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaan', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 120, 'pomodoro', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaah', 'Selesaikan sesi fokus Pomodoro selama 120 menit', '2026-04-06 11:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaao', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 15, 'task_complete', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaae', 'Menyelesaikan task: Dance Class', '2026-04-06 20:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaap', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 100, 'badge_unlock', '051ecb15-bfe7-4fb8-a8db-5b6309c2463d', 'Membuka lencana: Task Master', '2026-03-18 16:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaq', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 100, 'badge_unlock', '0216defc-a6c3-45e0-9d84-579cf2604d12', 'Membuka lencana: Marathon', '2026-04-01 17:00:00.000'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaar', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 100, 'badge_unlock', '44444444-4444-4444-4444-444444444444', 'Membuka lencana: Calendar King', '2026-04-04 18:00:00.000'),
('e99f7a77-f934-4096-8d81-232259ad4249', '727c9e5c-67ae-4dd4-89ce-2a275a1a3d9f', 20, 'task_complete', '90191986-8f7b-4cc1-b459-04338c306348', 'Menyelesaikan task: Kerja Rutin', '2026-04-02 11:22:53.567'),
('f055cbf1-2314-42b3-8268-b2089f815a8b', '03fdc079-15e4-48a0-97a2-b95faa984d84', 50, 'badge_unlock', 'd0099733-6b1e-4e2c-a386-451b7ffdedbd', 'Membuka lencana: Productive Starter', '2026-04-06 05:43:16.294');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `badge`
--
ALTER TABLE `badge`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Badge_name_key` (`name`),
  ADD UNIQUE KEY `Badge_code_key` (`code`);

--
-- Indeks untuk tabel `calendarevent`
--
ALTER TABLE `calendarevent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CalendarEvent_endDate_idx` (`endDate`),
  ADD KEY `CalendarEvent_startDate_idx` (`startDate`),
  ADD KEY `CalendarEvent_taskId_fkey` (`taskId`),
  ADD KEY `CalendarEvent_userId_idx` (`userId`);

--
-- Indeks untuk tabel `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Notification_userId_idx` (`userId`),
  ADD KEY `Notification_isRead_idx` (`isRead`);

--
-- Indeks untuk tabel `pomodorosession`
--
ALTER TABLE `pomodorosession`
  ADD PRIMARY KEY (`id`),
  ADD KEY `PomodoroSession_status_idx` (`status`),
  ADD KEY `PomodoroSession_taskId_fkey` (`taskId`),
  ADD KEY `PomodoroSession_userId_idx` (`userId`);

--
-- Indeks untuk tabel `qrsession`
--
ALTER TABLE `qrsession`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `QRSession_token_key` (`token`),
  ADD KEY `QRSession_status_idx` (`status`),
  ADD KEY `QRSession_token_idx` (`token`),
  ADD KEY `QRSession_userId_fkey` (`userId`);

--
-- Indeks untuk tabel `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Task_dueDate_idx` (`dueDate`),
  ADD KEY `Task_priority_idx` (`priority`),
  ADD KEY `Task_status_idx` (`status`),
  ADD KEY `Task_userId_idx` (`userId`);

--
-- Indeks untuk tabel `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Transaction_category_idx` (`category`),
  ADD KEY `Transaction_transactionDate_idx` (`transactionDate`),
  ADD KEY `Transaction_type_idx` (`type`),
  ADD KEY `Transaction_userId_idx` (`userId`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_email_key` (`email`),
  ADD UNIQUE KEY `User_username_key` (`username`),
  ADD UNIQUE KEY `User_resetPasswordToken_key` (`resetPasswordToken`);

--
-- Indeks untuk tabel `userbadge`
--
ALTER TABLE `userbadge`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UserBadge_userId_badgeId_key` (`userId`,`badgeId`),
  ADD KEY `UserBadge_badgeId_fkey` (`badgeId`),
  ADD KEY `UserBadge_userId_idx` (`userId`);

--
-- Indeks untuk tabel `xphistory`
--
ALTER TABLE `xphistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `XPHistory_source_idx` (`source`),
  ADD KEY `XPHistory_userId_idx` (`userId`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `calendarevent`
--
ALTER TABLE `calendarevent`
  ADD CONSTRAINT `CalendarEvent_taskId_fkey` FOREIGN KEY (`taskId`) REFERENCES `task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `CalendarEvent_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `Notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pomodorosession`
--
ALTER TABLE `pomodorosession`
  ADD CONSTRAINT `PomodoroSession_taskId_fkey` FOREIGN KEY (`taskId`) REFERENCES `task` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `PomodoroSession_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `qrsession`
--
ALTER TABLE `qrsession`
  ADD CONSTRAINT `QRSession_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `Task_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `Transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `userbadge`
--
ALTER TABLE `userbadge`
  ADD CONSTRAINT `UserBadge_badgeId_fkey` FOREIGN KEY (`badgeId`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `UserBadge_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `xphistory`
--
ALTER TABLE `xphistory`
  ADD CONSTRAINT `XPHistory_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
