-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Апр 22 2017 г., 22:35
-- Версия сервера: 10.1.22-MariaDB
-- Версия PHP: 7.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `economy`
--

-- --------------------------------------------------------

--
-- Структура таблицы `spark_account`
--

CREATE TABLE `spark_account` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `infiniteMoney` tinyint(1) DEFAULT '0',
  `uuid` varchar(36) DEFAULT NULL,
  `ignoreACL` tinyint(1) DEFAULT '0',
  `bank` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spark_acl`
--

CREATE TABLE `spark_acl` (
  `account_id` int(11) NOT NULL,
  `playerName` varchar(16) NOT NULL,
  `owner` tinyint(1) DEFAULT NULL,
  `balance` tinyint(1) DEFAULT '0',
  `deposit` tinyint(1) DEFAULT '0',
  `acl` tinyint(1) DEFAULT '0',
  `withdraw` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spark_balance`
--

CREATE TABLE `spark_balance` (
  `balance` double DEFAULT NULL,
  `worldName` varchar(255) NOT NULL,
  `username_id` int(11) NOT NULL,
  `currency_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spark_config`
--

CREATE TABLE `spark_config` (
  `name` varchar(30) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `spark_config`
--

INSERT INTO `spark_config` (`name`, `value`) VALUES
('bankprice', '50'),
('holdings', '50'),
('longmode', 'SMALL');

-- --------------------------------------------------------

--
-- Структура таблицы `spark_currency`
--

CREATE TABLE `spark_currency` (
  `name` varchar(50) NOT NULL,
  `plural` varchar(50) DEFAULT NULL,
  `minor` varchar(50) DEFAULT NULL,
  `minorplural` text,
  `sign` varchar(5) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `bankCurrency` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `spark_currency`
--

INSERT INTO `spark_currency` (`name`, `plural`, `minor`, `minorplural`, `sign`, `status`, `bankCurrency`) VALUES
('монет', 'монет', 'монет', 'монет', '$', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `spark_exchange`
--

CREATE TABLE `spark_exchange` (
  `from_currency` varchar(50) NOT NULL,
  `to_currency` varchar(50) NOT NULL,
  `amount` double DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spark_log`
--

CREATE TABLE `spark_log` (
  `id` int(11) NOT NULL,
  `username_id` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `cause` varchar(50) DEFAULT NULL,
  `causeReason` varchar(50) DEFAULT NULL,
  `worldName` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` double DEFAULT NULL,
  `currency_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `spark_worldgroup`
--

CREATE TABLE `spark_worldgroup` (
  `groupName` varchar(255) NOT NULL,
  `worldList` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `spark_account`
--
ALTER TABLE `spark_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `spark_account_name_index` (`name`);

--
-- Индексы таблицы `spark_acl`
--
ALTER TABLE `spark_acl`
  ADD PRIMARY KEY (`account_id`,`playerName`);

--
-- Индексы таблицы `spark_balance`
--
ALTER TABLE `spark_balance`
  ADD PRIMARY KEY (`worldName`,`username_id`,`currency_id`),
  ADD KEY `spark_fk_balance_account` (`username_id`),
  ADD KEY `spark_fk_balance_currency` (`currency_id`);

--
-- Индексы таблицы `spark_config`
--
ALTER TABLE `spark_config`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `spark_currency`
--
ALTER TABLE `spark_currency`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `spark_exchange`
--
ALTER TABLE `spark_exchange`
  ADD PRIMARY KEY (`from_currency`,`to_currency`),
  ADD KEY `spark_fk_exchange_currencyto` (`to_currency`);

--
-- Индексы таблицы `spark_log`
--
ALTER TABLE `spark_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `spark_fk_log_account` (`username_id`),
  ADD KEY `spark_fk_log_currency` (`currency_id`);

--
-- Индексы таблицы `spark_worldgroup`
--
ALTER TABLE `spark_worldgroup`
  ADD PRIMARY KEY (`groupName`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `spark_account`
--
ALTER TABLE `spark_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `spark_log`
--
ALTER TABLE `spark_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `spark_acl`
--
ALTER TABLE `spark_acl`
  ADD CONSTRAINT `spark_fk_acl_account` FOREIGN KEY (`account_id`) REFERENCES `spark_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `spark_balance`
--
ALTER TABLE `spark_balance`
  ADD CONSTRAINT `spark_fk_balance_account` FOREIGN KEY (`username_id`) REFERENCES `spark_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spark_fk_balance_currency` FOREIGN KEY (`currency_id`) REFERENCES `spark_currency` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `spark_exchange`
--
ALTER TABLE `spark_exchange`
  ADD CONSTRAINT `spark_fk_exchange_currencyfrom` FOREIGN KEY (`from_currency`) REFERENCES `spark_currency` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spark_fk_exchange_currencyto` FOREIGN KEY (`to_currency`) REFERENCES `spark_currency` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `spark_log`
--
ALTER TABLE `spark_log`
  ADD CONSTRAINT `spark_fk_log_account` FOREIGN KEY (`username_id`) REFERENCES `spark_account` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `spark_fk_log_currency` FOREIGN KEY (`currency_id`) REFERENCES `spark_currency` (`name`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
