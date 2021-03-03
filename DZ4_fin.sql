#1.Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)

-- Generation time: Sun, 03 Jan 2021 10:17:56 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_21
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('1','voluptatem','1'),
('2','exercitationem','2'),
('3','assumenda','3'),
('4','quidem','4'),
('5','non','5'),
('6','explicabo','6'),
('7','inventore','7'),
('8','qui','8'),
('9','rerum','9'),
('10','blanditiis','10'); 


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `friend_requests` VALUES ('1','1','requested','1982-12-02 17:45:50','1991-03-08 23:39:41'),
('2','2','unfriended','2015-01-07 01:38:35','1975-11-20 14:57:44'),
('3','3','approved','2013-10-06 15:53:42','2018-06-10 09:04:55'),
('4','4','unfriended','1994-01-28 00:31:26','1983-12-15 20:19:25'),
('5','5','requested','1994-04-25 01:06:30','1991-09-21 05:52:23'),
('6','6','approved','2003-07-08 18:14:19','1981-08-12 08:18:46'),
('7','7','unfriended','2013-05-21 13:19:51','2020-10-19 20:38:08'),
('8','8','unfriended','1989-05-01 18:25:46','2018-10-30 03:30:14'),
('9','9','approved','1996-10-08 07:45:10','2011-09-27 23:21:09'),
('10','10','declined','2020-11-25 08:31:35','1979-04-30 10:25:35'); 


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `likes` VALUES ('1','1','1','1994-02-24 04:57:26'),
('2','2','2','1999-05-08 17:46:36'),
('3','3','3','1975-08-07 14:46:23'),
('4','4','4','1970-07-07 06:12:48'),
('5','5','5','1970-11-03 13:57:17'),
('6','6','6','1975-12-06 13:07:01'),
('7','7','7','2010-05-03 19:05:01'),
('8','8','8','1977-06-27 10:18:06'),
('9','9','9','2020-06-08 09:07:50'),
('10','10','10','1971-08-19 01:39:04'); 


DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media` VALUES ('1','1','1','Facere in eos qui ex unde omnis officia. Quisquam voluptatem voluptas eum blanditiis veritatis fuga ullam.','quae','688',NULL,'1971-04-03 13:03:14','1985-06-22 05:00:57'),
('2','2','2','Nesciunt non aut asperiores molestiae placeat quod quidem. Fuga laboriosam beatae omnis. Expedita sed qui odio aspernatur qui est.','eligendi','9934944',NULL,'1991-06-27 12:59:19','2011-09-13 03:40:27'),
('3','3','3','Velit quis amet qui quis autem ut nemo. Porro minus iusto tenetur fuga vel ut. Et fugiat ut non aperiam at sunt.','illum','10981',NULL,'1985-04-07 20:27:07','1991-02-20 16:19:22'),
('4','4','4','Doloribus magni laboriosam quibusdam saepe consequatur provident. Nulla omnis id optio nisi veritatis mollitia. Ea consequatur architecto commodi quaerat et et. Harum qui ducimus at explicabo dolore consequatur.','eveniet','0',NULL,'1986-07-18 04:05:10','2008-06-03 05:17:01'),
('5','1','5','Nemo beatae voluptate et ab autem eligendi. Numquam quidem sapiente doloribus quod laboriosam quisquam doloribus enim. Dolorem in provident voluptatem quas unde possimus eligendi.','nam','981',NULL,'1999-07-25 06:08:29','1997-10-07 22:57:24'),
('6','2','6','Maxime ut qui reprehenderit quo quia magnam. Earum sed quo ut consectetur quisquam excepturi veritatis. Quis tenetur molestiae deleniti et cumque.','reiciendis','60764',NULL,'1970-07-06 15:53:03','1971-01-26 15:19:44'),
('7','3','7','Ad odit qui commodi consequatur qui. Molestiae alias vel in et atque. Neque ab totam omnis consequatur et.','dicta','1695',NULL,'1992-03-26 20:35:06','2015-02-04 19:46:45'),
('8','4','8','Animi ullam et praesentium dignissimos esse. Vero velit velit omnis quo et sapiente possimus impedit. Omnis reprehenderit consequatur dignissimos nihil magnam et quisquam necessitatibus.','natus','470',NULL,'2011-03-12 22:47:10','2006-05-11 22:16:48'),
('9','1','9','Voluptas iure quis rerum labore. At quae sed ducimus eaque nemo repellendus cum qui. Voluptatem ut enim blanditiis illo rerum in. Fugiat placeat dignissimos accusamus error tenetur aut molestiae. Accusantium expedita quia in amet ut similique autem.','id','632810456',NULL,'1985-12-18 17:41:16','2006-04-02 14:40:03'),
('10','2','10','Necessitatibus nobis voluptas perferendis sed. Qui amet inventore impedit nostrum deserunt. Nihil non et quaerat amet nihil quae.','a','20746',NULL,'1997-06-04 05:12:53','2008-08-16 05:28:07'); 


DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media_types` VALUES ('1','quia','1981-06-18 18:14:39','2005-11-27 04:04:37'),
('2','ipsum','2006-02-09 20:39:12','1997-01-04 16:18:07'),
('3','error','1977-05-18 17:17:54','2019-03-15 10:11:25'),
('4','quia','2019-12-12 00:04:58','2013-10-13 14:56:30'); 


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `messages` VALUES ('1','1','1','Magni et similique incidunt in temporibus natus. Provident quaerat officiis similique et perspiciatis. In asperiores sit temporibus assumenda. Unde omnis vel expedita explicabo eum aut.','2003-05-08 18:23:45'),
('2','2','2','Dolorem rerum ut aliquam numquam laboriosam voluptatibus. Quis nihil harum et nihil distinctio totam consectetur perspiciatis. Nobis officia est consequuntur distinctio nihil. Modi earum excepturi commodi quaerat excepturi et id.','1979-07-12 10:52:10'),
('3','3','3','Asperiores nostrum nisi consequuntur voluptatem. Ut autem et numquam ut itaque. Necessitatibus rem reprehenderit nihil velit aut dolores. Magnam voluptatem et hic delectus reiciendis.','2010-08-02 04:45:30'),
('4','4','4','Sit voluptas ut et nulla. Quas in delectus ex fugit rerum. Voluptatem quia et sit ipsum. Vel consequatur temporibus eos ex.','2002-03-07 17:36:10'),
('5','5','5','Non placeat est tempore deserunt eveniet ut sunt. Quisquam ipsum omnis dignissimos qui doloremque. Dignissimos in ex ducimus iste porro corrupti sequi. Aliquid consequuntur enim voluptatem.','2010-11-03 11:14:08'),
('6','6','6','Ullam quasi vel maiores exercitationem. Nemo omnis non sequi quos qui et ipsum. Cum cum adipisci quo exercitationem repellat. Inventore omnis id reprehenderit eius praesentium iusto quaerat.','1975-03-10 13:21:00'),
('7','7','7','Alias quae consequatur eum tempore suscipit magni aut. Occaecati quidem qui ullam officiis quasi magnam minus. Illum est rerum aut distinctio. Et sit quibusdam voluptatem reiciendis.','2001-05-20 23:15:11'),
('8','8','8','Quis rem quia dolor et quod. Excepturi natus quis commodi inventore nobis. Sunt vel hic deserunt dolorem. Animi vitae modi quam repellendus debitis eveniet.','2007-11-14 09:18:14'),
('9','9','9','In accusantium exercitationem labore magnam ad. Occaecati non non sequi assumenda. Ea commodi autem nihil commodi explicabo. Beatae omnis error laudantium voluptatem ad mollitia impedit nemo.','2009-12-03 23:43:41'),
('10','10','10','Modi quia qui accusantium voluptatem dolor neque commodi. Eius commodi nam quia fuga qui. Accusamus nobis omnis architecto sapiente. Neque sunt dicta consequatur culpa.','1999-03-17 00:54:28'); 


DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photo_albums` VALUES ('1','delectus','1'),
('2','sed','2'),
('3','et','3'),
('4','aut','4'),
('5','quaerat','5'),
('6','laborum','6'),
('7','eius','7'),
('8','facilis','8'),
('9','non','9'),
('10','rerum','10'); 


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `photos` VALUES ('1','1','1'),
('2','2','2'),
('3','3','3'),
('4','4','4'),
('5','5','5'),
('6','6','6'),
('7','7','7'),
('8','8','8'),
('9','9','9'),
('10','10','10'); 


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `profiles` VALUES ('1',NULL,'2015-12-12','1','1996-11-14 05:54:27',NULL),
('2',NULL,'2005-03-13','2','1976-04-10 22:09:13',NULL),
('3',NULL,'1982-04-04','3','2002-02-26 19:24:55',NULL),
('4',NULL,'1972-11-17','4','2015-02-07 12:42:21',NULL),
('5',NULL,'1997-04-10','5','2014-07-31 15:08:30',NULL),
('6',NULL,'1997-09-14','6','1979-11-08 13:02:50',NULL),
('7',NULL,'1976-05-19','7','2017-03-20 14:56:11',NULL),
('8',NULL,'1994-02-05','8','2005-09-09 09:44:01',NULL),
('9',NULL,'1999-07-20','9','1972-03-03 23:07:05',NULL),
('10',NULL,'1989-10-16','10','1980-02-26 14:28:25',NULL); 


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Ð¤Ð°Ð¼Ð¸Ð»Ñ',
  `email` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ÑÐ·ÐµÑÑ';

INSERT INTO `users` VALUES ('1','Prudence','Carter','steuber.juwan@example.net','b7390ce79b74bb6b7acde3bcc91a930fa3b4b4ec','89274487067'),
('2','Keegan','Frami','uhammes@example.org','c73ddfd85caad681c4b0273c548719edaf4639cb','89382931073'),
('3','Rafael','McCullough','kuvalis.milford@example.org','75e225b66ce990c2f10b4ebc311e3856c80d359c','89763724282'),
('4','Art','Jenkins','medhurst.serena@example.com','eb1171f57d6d3c146311d355b243c3fc8376533d','89419441046'),
('5','Elsa','Altenwerth','zcormier@example.org','3879f4cd24f15fa01598d8b5fe2b2402b8f21805','89329263073'),
('6','Javonte','Beahan','kadin.steuber@example.net','49675847429e219a3708777d440fedc42e16938f','89600958550'),
('7','Natasha','Bailey','amarquardt@example.org','d9f2159ce49381feed249ab2918a601b7572dcc4','89753901032'),
('8','Micaela','Fisher','esteban37@example.org','5897a34cd559a1a25d03bf932812035385a0ffc2','89568516415'),
('9','Reyna','Reynolds','petra.bernhard@example.net','5deefe3846d0c4a3f33e392180dfa84121b49d3a','89030694512'),
('10','Lyda','Okuneva','jessica86@example.com','477c0b255d784d2553f9202845c488f6f02317fa','89253125150'); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_communities` VALUES ('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


#2.Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
USE vk;
select DISTINCT firstname
from users
ORDER by firstname
;
#3 Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
alter table profiles add column is_active tinyint default 1;
update profiles set is_active = 0
where extract(year from now()) - extract(year from birthday) < 18 ;
#4 Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
insert into messages VALUES ('11','1','1','Magni et similique incidunt in temporibus natus. Provident quaerat officiis similique et perspiciatis. In asperiores sit temporibus assumenda. Unde omnis vel expedita explicabo eum aut.',now()+interval 1 year);
delete from messages where created_at > now();


