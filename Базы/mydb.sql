-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 19 2023 г., 14:12
-- Версия сервера: 10.4.27-MariaDB
-- Версия PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mydb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `answers`
--

CREATE TABLE `answers` (
  `answerText` varchar(300) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`answerText`, `user_id`, `question_id`) VALUES
('Ответ убил', 83, 1),
('отвечаю рил', 103, 19),
('новый ответ', 103, 25),
('новый ответ', 103, 34);

-- --------------------------------------------------------

--
-- Структура таблицы `completedata`
--

CREATE TABLE `completedata` (
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mark` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `completeData` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `files`
--

CREATE TABLE `files` (
  `file` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `comment` varchar(300) DEFAULT NULL,
  `users_idusers` int(11) NOT NULL,
  `Task_idTask` int(11) NOT NULL,
  `id_file` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `files`
--

INSERT INTO `files` (`file`, `date`, `comment`, `users_idusers`, `Task_idTask`, `id_file`) VALUES
('1', '2023-01-18 18:43:32', '', 103, 1, 1),
('fawfa', '2023-01-11 20:30:57', 'fawfwaf', 110, 5, 2),
(NULL, NULL, NULL, 110, 5, 3),
(NULL, NULL, NULL, 110, 5, 4),
('2', '2023-01-18 18:43:33', '', 103, 1, 10),
('3', '2023-01-18 18:43:35', '', 103, 1, 12),
(NULL, NULL, NULL, 103, 1, 13),
(NULL, NULL, NULL, 103, 1, 14),
('ацфафц', '2023-01-18 18:43:19', '', 103, 1, 15),
(NULL, NULL, NULL, 103, 1, 16),
('ацфаф', '2023-01-18 18:43:27', '', 103, 1, 17),
(NULL, NULL, NULL, 103, 1, 18),
(NULL, NULL, NULL, 103, 1, 19),
(NULL, NULL, NULL, 103, 1, 20),
(NULL, NULL, NULL, 103, 1, 21),
(NULL, NULL, NULL, 103, 1, 22),
(NULL, NULL, NULL, 103, 1, 23),
(NULL, NULL, NULL, 103, 1, 24),
(NULL, NULL, NULL, 103, 1, 25),
(NULL, NULL, NULL, 103, 1, 26),
(NULL, NULL, NULL, 103, 1, 27),
(NULL, NULL, NULL, 103, 1, 28),
(NULL, NULL, NULL, 103, 1, 29),
(NULL, NULL, NULL, 103, 1, 30),
(NULL, NULL, NULL, 103, 1, 31),
(NULL, NULL, NULL, 103, 1, 32),
(NULL, NULL, NULL, 103, 1, 33),
(NULL, NULL, NULL, 103, 1, 34),
(NULL, NULL, NULL, 103, 1, 35),
(NULL, NULL, NULL, 103, 1, 36),
(NULL, NULL, NULL, 103, 1, 37),
(NULL, NULL, NULL, 103, 1, 38),
(NULL, NULL, NULL, 103, 1, 39),
(NULL, NULL, NULL, 103, 1, 40),
(NULL, NULL, NULL, 103, 1, 41),
('ййй', '2023-01-18 18:42:25', '', 103, 4, 42),
(NULL, NULL, NULL, 103, 1, 43),
(NULL, NULL, NULL, 103, 1, 44),
('ацфафцацф', '2023-01-18 18:42:01', '', 103, 2, 46),
('1431241', '2023-01-18 18:43:46', '', 103, 1, 47),
('124421', '2023-01-18 18:43:49', '', 103, 1, 48),
('крутой файл', '2023-01-18 20:09:06', '', 103, 9, 49),
('цфкцф', '2023-01-18 20:18:28', '', 103, 12, 50),
('файл новй', '2023-01-19 12:44:48', '', 103, 14, 52);

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions` (
  `questionText` varchar(255) DEFAULT NULL,
  `QuestionID` int(11) NOT NULL,
  `Task_idTask` int(11) NOT NULL,
  `users_idusers1` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`questionText`, `QuestionID`, `Task_idTask`, `users_idusers1`) VALUES
('Вопрос такой, как сделать то-то и сё-то', 1, 1, 36),
('Еще вопрос, глупый вопрос', 2, 4, 83),
('Вопрос', 13, 1, 102),
('Вопрос 2', 14, 2, 6),
('Вопрос 3', 15, 3, 89),
('Вопрос 4', 16, 4, 105),
('Вопрос 5', 17, 5, 45),
('Вопрос 6', 18, 6, 51),
('Вопрос 7', 19, 1, 35),
('Вопрос 8', 20, 5, 44),
('Вопрос 9', 21, 3, 52),
(NULL, 22, 5, 87),
('бла бла бла', 23, 10, 52),
(',kf ,kf', 24, 10, 52),
('Тестовый вопрос', 25, 1, 103),
('Тестовый вопрос', 26, 1, 103),
('еще один вопрос', 27, 10, 103),
('еще один вопрос', 28, 10, 103),
('еще один вопрос', 29, 10, 103),
('еще один вопрос', 30, 10, 103),
('еще один вопрос', 31, 10, 103),
('еще один вопрос', 32, 10, 103),
('еще один вопрос', 33, 10, 103),
('новый вопрос', 34, 14, 103),
('еще', 35, 14, 103);

-- --------------------------------------------------------

--
-- Структура таблицы `subject`
--

CREATE TABLE `subject` (
  `idSubject` int(11) NOT NULL,
  `ThemeName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `subject`
--

INSERT INTO `subject` (`idSubject`, `ThemeName`) VALUES
(1, 'Математика'),
(3, 'Программирование'),
(5, 'Теория вероятностей'),
(6, 'История'),
(7, 'Пальчиковедение'),
(8, 'а'),
(9, 'новый предмет'),
(10, 'новый предмет'),
(11, 'аё'),
(12, 'работа 1'),
(13, 'ацфа'),
(14, 'Предмет для крутых');

-- --------------------------------------------------------

--
-- Структура таблицы `task`
--

CREATE TABLE `task` (
  `idTask` int(11) NOT NULL,
  `TaskName` varchar(255) DEFAULT NULL,
  `Charactiristic` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`Charactiristic`)),
  `Subject_idSubject` int(11) NOT NULL,
  `TaskDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `task`
--

INSERT INTO `task` (`idTask`, `TaskName`, `Charactiristic`, `Subject_idSubject`, `TaskDate`) VALUES
(1, 'Лабораторная работа 1', NULL, 3, '2019-12-11'),
(2, 'Лабораторная работа 1', NULL, 3, '2020-12-18'),
(3, 'Лабораторная работа 1', NULL, 3, '2021-12-16'),
(4, 'Лабораторная работа 2', NULL, 3, '2020-12-24'),
(5, 'Лабораторная работа 2', NULL, 3, '2021-12-16'),
(6, 'Лабораторная работа 3', NULL, 3, '2022-12-15'),
(9, 'ацфа', NULL, 6, '2023-01-18'),
(10, 'кфцк', NULL, 1, '2023-01-18'),
(11, 'ацфацф', NULL, 10, '2023-01-18'),
(12, 'афццф', NULL, 8, '2023-01-18'),
(13, 'работа 1', NULL, 14, '2023-01-19'),
(14, 'работа 2', NULL, 6, '2023-01-19');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `idusers` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `raiting` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`idusers`, `username`, `password`, `raiting`) VALUES
(2, 'Николай Великов измененный', 'qwerty', 6),
(4, 'Тестовый пользователь 1', '111', 2),
(5, 'Тестовый пользователь 1', '111', 9),
(6, 'Александра Куку', 'testUser', 15),
(7, 'Алексей Белый', 'testUser', 2),
(8, 'Миша Паральный', 'testUser', 6),
(9, 'Роман Карамышкин', 'testUser', 7),
(10, 'Серега Мерседес', 'testUser', 15),
(11, 'Роман Нанали', 'testUser', 4),
(12, 'Серега Довольный', 'testUser', 10),
(13, 'Маша Прежний', 'testUser', 2),
(14, 'Алексей Прежний', 'testUser', 12),
(15, 'Катя Карамышкин', 'testUser', 3),
(16, 'Катя Калька', 'testUser', 1),
(17, 'Маша Мерседес', 'testUser', 13),
(18, 'Юля Лимонный', 'testUser', 11),
(19, 'Екатерина Уволенный', 'testUser', 1),
(20, 'Михаил Мерседес', 'testUser', 6),
(21, 'Серега Лимонный', 'testUser', 13),
(22, 'Екатерина Майская', 'testUser', 7),
(23, 'Серега Касперский', 'testUser', 8),
(24, 'Маша Мотыга', 'testUser', 9),
(25, 'Саша Камчатка', 'testUser', 3),
(26, 'Катя Роликс', 'testUser', 4),
(27, 'Василий Камчатка', 'testUser', 13),
(28, 'Полина Довольный', 'testUser', 2),
(29, 'Юля Широкий', 'testUser', 0),
(30, 'Каталья Калька', 'testUser', 15),
(31, 'Павел Куку', 'testUser', 10),
(32, 'Таня Карамышкин', 'testUser', 8),
(33, 'Рома Тонкий', 'testUser', 10),
(34, 'Серега Майская', 'testUser', 3),
(35, 'Вероника Тонкий', 'testUser', 12),
(36, 'Александр Довольный', 'testUser', 14),
(37, 'Юлия Алый', 'testUser', 15),
(38, 'Серега Майский', 'testUser', 1),
(39, 'Маша Балышев', 'testUser', 12),
(40, 'Павел Прежний', 'testUser', 13),
(41, 'Алия Душный', 'testUser', 7),
(42, 'Роман Кирка', 'testUser', 4),
(43, 'Серега Майская', 'testUser', 3),
(44, 'Александр Черная', 'testUser', 1),
(45, 'АЛАЛАЙ Тонкий', 'testUser', 1),
(46, 'Юля Алый', 'testUser', 13),
(47, 'Таня Правая', 'testUser', 12),
(48, 'Миша Кукушкин', 'testUser', 13),
(49, 'Паша Калька', 'testUser', 14),
(50, 'Николай Куку', 'testUser', 6),
(51, 'АЛАЛАЙ Широкий', 'testUser', 11),
(52, 'АЛАЛАЙ Кукушкин', 'testUser', 11),
(53, 'Николай Куку', 'testUser', 13),
(54, 'Алексей Касперский', 'testUser', 11),
(55, 'Роман Калька', 'testUser', 13),
(56, 'Таня Калинина', 'testUser', 6),
(57, 'Юлия Крутая', 'testUser', 3),
(58, 'Паша Балышев', 'testUser', 8),
(59, 'Женя Карамышкин', 'testUser', 7),
(60, 'Алия Майская', 'testUser', 0),
(61, 'Леша Балышев', 'testUser', 12),
(62, 'Каталья Куку', 'testUser', 5),
(63, 'Женя Душный', 'testUser', 6),
(64, 'Роман Мерседес', 'testUser', 0),
(65, 'Александра Калька', 'testUser', 8),
(66, 'Катя Нанали', 'testUser', 11),
(67, 'Инокентий Камчатка', 'testUser', 12),
(68, 'Маша Мотыга', 'testUser', 8),
(69, 'Павел Уволенный', 'testUser', 13),
(70, 'Юлия Левая', 'testUser', 7),
(71, 'Сергей Калька', 'testUser', 10),
(72, 'Таня Карамышкин', 'testUser', 10),
(73, 'Леша Черная', 'testUser', 13),
(74, 'Михаил Майский', 'testUser', 2),
(75, 'Юля Тонкий', 'testUser', 10),
(76, 'Екатерина Майская', 'testUser', 14),
(77, 'Николай Кирка', 'testUser', 11),
(78, 'Роман Карамышкин', 'testUser', 12),
(79, 'Леша Лимонный', 'testUser', 12),
(80, 'Никита Калинина', 'testUser', 5),
(81, 'Рома Камчатка', 'testUser', 12),
(82, 'Николай Куку', 'testUser', 2),
(83, 'АЛАЛАЙ Нанали', 'testUser', 3),
(84, 'Вася Куку', 'testUser', 6),
(85, 'Юлия Нанали', 'testUser', 15),
(86, 'Полина Гулькин', 'testUser', 12),
(87, 'Василий Лимонный', 'testUser', 0),
(88, 'Сергей Калинина', 'testUser', 0),
(89, 'Александр Белый', 'testUser', 7),
(90, 'Михаил Алый', 'testUser', 4),
(91, 'Рома Нанали', 'testUser', 9),
(92, 'Катя Левая', 'testUser', 14),
(93, 'Каталья Левая', 'testUser', 1),
(94, 'Юлия Роликс', 'testUser', 12),
(95, 'Михаил Довольный', 'testUser', 1),
(96, 'Саша Камчатка', 'testUser', 15),
(97, 'Саша Мотыга', 'testUser', 9),
(98, 'Сергей Мерседес', 'testUser', 15),
(99, 'Серега Алый', 'testUser', 5),
(100, 'Серега Гулькин', 'testUser', 1),
(101, 'Алексей Широкий', 'testUser', NULL),
(102, 'Евгений Новоселенный', 'testUser', NULL),
(103, 'к', 'к', NULL),
(104, 'Александра Майская', 'testUser', NULL),
(105, 'Евгения Майский', 'testUser', NULL),
(106, '', 'passwordPOST', 3),
(107, 'f', 'passwordPOST', 3),
(108, 'f', 'passwordPOST', 3),
(109, 'f', 'f', 3),
(110, 'NikitaTest', '123123', 3),
(111, 'NikitaTest', '123123', 3),
(112, 'nikitatest825', '15261623', 3),
(113, 'nikitatest825', '15261623', 3),
(114, 'nikitatest825', '15261623', 3),
(115, 'nikitatest825', '15261623', 3),
(116, 'nikitatest825', '15261623', 3),
(117, 'nikitatest825', '15261623', 3),
(118, 'nikitatest825', '77886', 3),
(119, 'nikitatest825', '778865', 3),
(120, 'test1', 'test1', 3),
(121, 'test2', '1251512', 3),
(122, '222222', '12412', 3),
(123, 'testata', '24515125', 3),
(124, 'Юля', '666', 3),
(125, 'афцафц', 'афцацф', 3),
(126, 'новый пользователь', 'щ1о20а19р2а', 3),
(127, 'gwawga', '21512t1', 3),
(128, 'fwafwa', '1521521', 3),
(129, 'fwafwafwafaw', 'fawfaw', 3),
(130, '1', '1', 3),
(131, 'ТЕстовый', '12345', 3),
(132, 'test', '123123', 3),
(133, 'новый', '123', 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`user_id`,`question_id`),
  ADD KEY `fk_answers_users1_idx` (`user_id`),
  ADD KEY `fk_answers_questions1_idx` (`question_id`);

--
-- Индексы таблицы `completedata`
--
ALTER TABLE `completedata`
  ADD PRIMARY KEY (`task_id`,`user_id`),
  ADD KEY `fk_completeData_users1_idx` (`user_id`);

--
-- Индексы таблицы `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id_file`),
  ADD KEY `fk_files_users1_idx` (`users_idusers`),
  ADD KEY `fk_files_Task1_idx` (`Task_idTask`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`QuestionID`),
  ADD KEY `fk_questions_Task1_idx` (`Task_idTask`),
  ADD KEY `fk_questions_users1_idx` (`users_idusers1`);

--
-- Индексы таблицы `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`idSubject`);

--
-- Индексы таблицы `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`idTask`),
  ADD KEY `fk_subject_Subject1_idx` (`Subject_idSubject`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`idusers`),
  ADD UNIQUE KEY `idusers_UNIQUE` (`idusers`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `files`
--
ALTER TABLE `files`
  MODIFY `id_file` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
  MODIFY `QuestionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `subject`
--
ALTER TABLE `subject`
  MODIFY `idSubject` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `task`
--
ALTER TABLE `task`
  MODIFY `idTask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `idusers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `fk_answers_questions1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`QuestionID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_answers_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `completedata`
--
ALTER TABLE `completedata`
  ADD CONSTRAINT `fk_completeData_subject1` FOREIGN KEY (`task_id`) REFERENCES `task` (`idTask`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_completeData_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `fk_files_Task1` FOREIGN KEY (`Task_idTask`) REFERENCES `task` (`idTask`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_files_users1` FOREIGN KEY (`users_idusers`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_questions_Task1` FOREIGN KEY (`Task_idTask`) REFERENCES `task` (`idTask`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_questions_users1` FOREIGN KEY (`users_idusers1`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `fk_subject_Subject1` FOREIGN KEY (`Subject_idSubject`) REFERENCES `subject` (`idSubject`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
