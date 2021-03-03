
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Ð¤Ð°Ð¼Ð¸Ð»ÑŒ', -- COMMENT Ð½Ð° ÑÐ»ÑƒÑ‡Ð°Ð¹, ÐµÑÐ»Ð¸ Ð¸Ð¼Ñ Ð½ÐµÐ¾Ñ‡ÐµÐ²Ð¸Ð´Ð½Ð¾Ðµ
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), -- 123456 => vzx;clvgkajrpo9udfxvsldkrn24l5456345t
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'ÑŽÐ·ÐµÑ€Ñ‹';

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
	
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- Ð¿Ð¾ÐºÐ° Ñ€Ð°Ð½Ð¾, Ñ‚.Ðº. Ñ‚Ð°Ð±Ð»Ð¸Ñ†Ñ‹ media ÐµÑ‰Ðµ Ð½ÐµÑ‚
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (Ð·Ð½Ð°Ñ‡ÐµÐ½Ð¸Ðµ Ð¿Ð¾ ÑƒÐ¼Ð¾Ð»Ñ‡Ð°Ð½Ð¸ÑŽ)
    ON DELETE RESTRICT; -- (Ð·Ð½Ð°Ñ‡ÐµÐ½Ð¸Ðµ Ð¿Ð¾ ÑƒÐ¼Ð¾Ð»Ñ‡Ð°Ð½Ð¸ÑŽ)


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- Ð¼Ð¾Ð¶Ð½Ð¾ Ð±ÑƒÐ´ÐµÑ‚ Ð´Ð°Ð¶Ðµ Ð½Ðµ ÑƒÐ¿Ð¾Ð¼Ð¸Ð½Ð°Ñ‚ÑŒ ÑÑ‚Ð¾ Ð¿Ð¾Ð»Ðµ Ð¿Ñ€Ð¸ Ð²ÑÑ‚Ð°Ð²ÐºÐµ

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL, -- Ð¸Ð·Ð¼ÐµÐ½Ð¸Ð»Ð¸ Ð½Ð° ÑÐ¾ÑÑ‚Ð°Ð²Ð½Ð¾Ð¹ ÐºÐ»ÑŽÑ‡ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT(1) UNSIGNED, -- Ð² ÑÑ‚Ð¾Ð¼ ÑÐ»ÑƒÑ‡Ð°Ðµ Ð² ÐºÐ¾Ð´Ðµ Ñ…Ñ€Ð°Ð½Ð¸Ð»Ð¸ Ð±Ñ‹ Ñ†Ð¸Ñ„Ð¸Ñ€Ð½Ñ‹Ð¹ enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- Ð¼Ð¾Ð¶Ð½Ð¾ Ð±ÑƒÐ´ÐµÑ‚ Ð´Ð°Ð¶Ðµ Ð½Ðµ ÑƒÐ¿Ð¾Ð¼Ð¸Ð½Ð°Ñ‚ÑŒ ÑÑ‚Ð¾ Ð¿Ð¾Ð»Ðµ Ð¿Ñ€Ð¸ Ð¾Ð±Ð½Ð¾Ð²Ð»ÐµÐ½Ð¸Ð¸
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)-- ,
    -- CHECK (initiator_user_id <> target_user_id)
);
-- Ñ‡Ñ‚Ð¾Ð±Ñ‹ Ð¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ñ‚ÐµÐ»ÑŒ ÑÐ°Ð¼ ÑÐµÐ±Ðµ Ð½Ðµ Ð¾Ñ‚Ð¿Ñ€Ð°Ð²Ð¸Ð» Ð·Ð°Ð¿Ñ€Ð¾Ñ Ð² Ð´Ñ€ÑƒÐ·ÑŒÑ
ALTER TABLE friend_requests 
ADD CHECK(initiator_user_id <> target_user_id);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx(name), -- Ð¸Ð½Ð´ÐµÐºÑÑƒ Ð¼Ð¾Ð¶Ð½Ð¾ Ð´Ð°Ð²Ð°Ñ‚ÑŒ ÑÐ²Ð¾Ðµ Ð¸Ð¼Ñ (communities_name_idx)
	foreign key (admin_user_id) references users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- Ñ‡Ñ‚Ð¾Ð±Ñ‹ Ð½Ðµ Ð±Ñ‹Ð»Ð¾ 2 Ð·Ð°Ð¿Ð¸ÑÐµÐ¹ Ð¾ Ð¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ñ‚ÐµÐ»Ðµ Ð¸ ÑÐ¾Ð¾Ð±Ñ‰ÐµÑÑ‚Ð²Ðµ
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255), -- Ð·Ð°Ð¿Ð¸ÑÐµÐ¹ Ð¼Ð°Ð»Ð¾, Ð¿Ð¾ÑÑ‚Ð¾Ð¼Ñƒ Ð² Ð¸Ð½Ð´ÐµÐºÑÐµ Ð½ÐµÑ‚ Ð½ÐµÐ¾Ð±Ñ…Ð¾Ð´Ð¸Ð¼Ð¾ÑÑ‚Ð¸
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    -- file blob,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) â€“ Ð¼Ð¾Ð¶Ð½Ð¾ Ð±Ñ‹Ð»Ð¾ Ð¸ Ñ‚Ð°Ðº Ð²Ð¼ÐµÑÑ‚Ð¾ id Ð² ÐºÐ°Ñ‡ÐµÑÑ‚Ð²Ðµ PK
  	-- ÑÐ»Ð¸ÑˆÐºÐ¾Ð¼ ÑƒÐ²Ð»ÐµÐºÐ°Ñ‚ÑŒÑÑ Ð¸Ð½Ð´ÐµÐºÑÐ°Ð¼Ð¸ Ñ‚Ð¾Ð¶Ðµ Ð¾Ð¿Ð°ÑÐ½Ð¾, Ñ€Ð°Ñ†Ð¸Ð¾Ð½Ð°Ð»ÑŒÐ½ÐµÐµ Ð¸Ñ… Ð´Ð¾Ð±Ð°Ð²Ð»ÑÑ‚ÑŒ Ð¿Ð¾ Ð¼ÐµÑ€Ðµ Ð½ÐµÐ¾Ð±Ñ…Ð¾Ð´Ð¸Ð¼Ð¾ÑÑ‚Ð¸ (Ð½Ð°Ð¿Ñ€., Ð¿Ñ€Ð¾Ð²Ð¸ÑÐ°ÑŽÑ‚ Ð¿Ð¾ Ð²Ñ€ÐµÐ¼ÐµÐ½Ð¸ ÐºÐ°ÐºÐ¸Ðµ-Ñ‚Ð¾ Ð·Ð°Ð¿Ñ€Ð¾ÑÑ‹)  

/* Ð½Ð°Ð¼ÐµÑ€ÐµÐ½Ð½Ð¾ Ð·Ð°Ð±Ñ‹Ð»Ð¸, Ñ‡Ñ‚Ð¾Ð±Ñ‹ Ð¿Ð¾Ð·Ð´Ð½ÐµÐµ ÑƒÐ²Ð¸Ð´ÐµÑ‚ÑŒ Ð¸Ñ… Ð¾Ñ‚ÑÑƒÑ‚ÑÑ‚Ð²Ð¸Ðµ Ð² ER-Ð´Ð¸Ð°Ð³Ñ€Ð°Ð¼Ð¼Ðµ
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL,
	`album_id` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

ALTER TABLE vk.likes 
ADD CONSTRAINT likes_fk 
FOREIGN KEY (media_id) REFERENCES vk.media(id);

ALTER TABLE vk.likes 
ADD CONSTRAINT likes_fk_1 
FOREIGN KEY (user_id) REFERENCES vk.users(id);

ALTER TABLE vk.profiles 
ADD CONSTRAINT profiles_fk_1 
FOREIGN KEY (photo_id) REFERENCES media(id);

# íîâûå òàáëèöû 
drop  table if exists `music`;
create table `music`(
	id serial,
	id_artist BIGINT UNSIGNED NOT null,
	name_song varchar(255),
	name_artist varchar(255),
	index idx_song_art(name_song,name_artist),
	index idx_art_song(name_artist,name_song)

	);
alter table `music` add constraint fk_id_art_user
foreign key (id_artist) references users(id)
;

drop  table if exists `games`;
create table `games`(
	id serial,
	name_games varchar(255),
	index (name_games)

	);
drop table if exists `users_games`;
create table `users_games`(
	user_id bigint unsigned not null,
	game_id serial,
	
	foreign key (user_id) references users(id),
	foreign key (game_id) references games(id)
	

);

