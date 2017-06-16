--/* FILERUN: 2017.03.18 */

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `df_file_handlers` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) DEFAULT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ext` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handler` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_file_handlers` (`type`, `ext`, `handler`) VALUES
('txt', NULL, 'code_editor'),
('img', NULL, 'image_viewer'),
('wvideo', NULL, 'video_player'),
('mp3', NULL, 'audio_player'),
('office', NULL, 'office_web_viewer'),
('ooffice', NULL, 'office_web_viewer'),
('arch', NULL, 'arch'),
(NULL,'odt', 'webodf'),
(NULL,'ods', 'webodf'),
(NULL,'odp', 'webodf'),
(NULL, 'pdf', 'open_in_browser'),
(NULL, 'url', 'handle_url'),
(NULL, 'html', 'open_in_browser'),
(NULL, 'kml', 'kml_viewer'),
(NULL, 'kmz', 'kml_viewer'),
(NULL, 'md', 'markdown_viewer'),
(NULL, 'epub', 'epub_reader');

CREATE TABLE IF NOT EXISTS `df_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '2002-02-02 00:00:00',
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `uid` mediumint(9) NOT NULL DEFAULT '0',
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_folders_notifications` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `pathid` int(9) NOT NULL,
  `shareid` int(8) DEFAULT NULL,
  `notify_write` int(1) NOT NULL DEFAULT '0',
  `notify_read` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`pathid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_metadata_dt` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ext` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `file_types` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `system` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



INSERT INTO `df_modules_metadata_dt` (`id`, `owner`, `name`, `description`, `ext`, `file_types`, `system`) VALUES
(1, 0, 'Documents', 'System type', 'pdf,txt', 'office,ooffice', 1),
(2, 0, 'Photos', 'System type', 'psb,psd,tiff,tif,bmp', 'img,raw', 1),
(3, 0, 'Audio', 'System type', '', 'mp3,audio', 1),
(4, 0, 'Video', 'System type', '', 'wvideo,video', 1);


CREATE TABLE IF NOT EXISTS `df_modules_metadata_fields` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `fsid` mediumint(9) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  `hide_fieldset_name_in_column` smallint(1) NOT NULL DEFAULT '0',
  `show_column_by_default` smallint(1) NOT NULL DEFAULT '0',
  `system` smallint(1) NOT NULL DEFAULT '0',
  `source` VARCHAR(255) NULL,
  `sort` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX (`name`),
  INDEX (`system`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_modules_metadata_fields` 
(`fsid`, `name`, `description`, `type`, `options`, `hide_fieldset_name_in_column`, `show_column_by_default`, `system`, `source`, `sort`)
 VALUES
 
(0, 'comment', 'Comments (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'filelog', 'File Logs (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'label', 'Labels (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'star', 'Stars (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'filename', 'Search (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'zoho_collab', 'Zoho Collaborative Editing (System)', '', '', 0, 0, 1, NULL, NULL),
(0, 'Tags', '', 'multiple', '', 0, 0, 1, 'MWG->Keywords', NULL),

(3, 'Width', '', 'small', '', 1, 0, 0, 'MWG->width', 1),
(3, 'Height', '', 'small', '', 1, 0, 0, 'MWG->height', 2),
(3, 'Date taken', '', 'date', '', 1, 0, 0, 'MWG->DateCreated', 3),
(3, 'Author', '', 'multiple', '', 1, 0, 0, 'MWG->Creator', 4),
(3, 'Description', '', 'large', '', 1, 0, 0, 'MWG->Description', 5),
(3, 'Copyright', '', '', '', 1, 0, 0, 'MWG->Copyright', 6),
(3, 'GPS latitude', '', 'small', '', 1, 0, 0, 'MWG->GPSlatitude', 7),
(3, 'GPS longitude', '', 'small', '', 1, 0, 0, 'MWG->GPSlongitude', 8),

(4, 'Movie title', '', '', '', 1, 0, 0, 'info->quicktime->moov->subatoms->3->subatoms->0->subatoms->1->subatoms->0->data', 1),
(4, 'Width', '', 'small', '', 1, 0, 0, 'info->video->resolution_x', 2),
(4, 'Height', '', 'small', '', 1, 0, 0, 'info->video->resolution_y', 3),
(4, 'Codec', '', '', '', 1, 0, 0, 'info->video->dataformat', 4),

(5, 'Artist', '', '', '', 1, 0, 0, 'info->comments->artist', 1),
(5, 'Title', '', '', '', 1, 0, 0, 'info->comments->title', 2),
(5, 'Album', '', '', '', 1, 0, 0, 'info->comments->album', 3),
(5, 'Duration', '', 'small', '', 1, 0, 0, 'info->playtime_string', 4),
(5, 'Codec', '', '', '', 1, 0, 0, 'info->audio->codec', 5),

(6, 'Author', '', '', '', 1, 0, 0, NULL, 1),
(6, 'Description', '', '', '', 1, 0, 0,  NULL, 2),
(0, 'Rating', '', 'stars', '', 1, 0, 1, 'Rating', NULL);



CREATE TABLE IF NOT EXISTS `df_modules_metadata_fieldsets` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `generic` SMALLINT(1) NOT NULL DEFAULT '0',
  `system` SMALLINT(1) NOT NULL DEFAULT '0',
  `visible` SMALLINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO `df_modules_metadata_fieldsets` (`id`, `owner`, `name`, `description`, `generic`, `system`, `visible`) VALUES
(1, 0, 'Comments (System)', 'Required for the file commenting system', 1, 1, 0),
(2, 0, 'Label (System)', 'Required for the label system', 1, 1, 0),
(3, 0, 'Image properties', '', 0, 1, 1),
(4, 0, 'Video properties', '', 0, 1, 1),
(5, 0, 'Audio properties', '', 0, 1, 1),
(6, 0, 'Various information', '', 1, 0, 1);

CREATE TABLE IF NOT EXISTS `df_relationships` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `related_to_id` mediumint(9) NOT NULL DEFAULT '0',
  `object_id` mediumint(9) NOT NULL DEFAULT '0',
  `relation_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `id` (`id`),
  KEY `object_id` (`object_id`,`relation_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_relationships` (`id`, `related_to_id`, `object_id`, `relation_type`) VALUES
(NULL, 2, 3, 'meta-fs2dt'),
(NULL, 4, 4, 'meta-fs2dt'),
(NULL, 3, 5, 'meta-fs2dt'),
(NULL, 4, 5, 'meta-fs2dt'),
(NULL, 1, 6, 'meta-fs2dt');

CREATE TABLE IF NOT EXISTS `df_modules_metadata_files` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `pid` INT( 9 ) NOT NULL,
  `type_id` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX (`pid`),
  INDEX (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_metadata_values` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `date_modified` DATETIME NULL DEFAULT NULL,
  `uid` mediumint(9) NOT NULL,
  `share_id` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  `file_id` mediumint(9) NOT NULL,
  `field_id` mediumint(9) NOT NULL,
  `val` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_added` (`date_added`),
  KEY `uid` (`uid`,`file_id`,`field_id`),
  KEY `file_id` (`file_id`,`field_id`),
  KEY `uid_2` (`uid`,`field_id`),
  INDEX `val` (`val`(100)),
  INDEX(`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_notifications` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) DEFAULT NULL,
  `object_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `object_id` mediumint(9) NOT NULL DEFAULT '0',
  `action` text COLLATE utf8_unicode_ci NOT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS `df_modules_search_index_queue` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `path` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_shares` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `created` datetime NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `comment` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `with_gid` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  `with_uid` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  `anonymous` smallint(1) NOT NULL DEFAULT '0',
  `perms_upload` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `perms_download` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `perms_comment` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `perms_read_comments` smallint(1) NOT NULL DEFAULT '0',
  `perms_alter` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `perms_share` SMALLINT( 1 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_trash` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `relative_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_deleted` datetime NOT NULL,
  `filesize` bigint(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_user_groups` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `owner` mediumint(9) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_user_roles` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `admin_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `admin_users` smallint(1) NOT NULL DEFAULT '0',
  `admin_roles` smallint(1) NOT NULL DEFAULT '0',
  `admin_notifications` smallint(1) NOT NULL DEFAULT '0',
  `admin_logs` smallint(1) NOT NULL DEFAULT '0',
  `admin_metadata` smallint(1) NOT NULL DEFAULT '0',
  `admin_over` text COLLATE utf8_unicode_ci NOT NULL,
  `admin_max_users` smallint(7) NOT NULL DEFAULT '0',
  `admin_homefolder_template` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `homefolder` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `create_folder` smallint(1) NOT NULL DEFAULT '1',
  `space_quota_max` int(20) DEFAULT NULL,
  `space_quota_current` int(20) NOT NULL DEFAULT '0',
  `readonly` smallint(1) DEFAULT NULL,
  `upload` smallint(1) DEFAULT NULL,
  `upload_max_size` BIGINT( 20 ) NULL DEFAULT NULL,
  `download` smallint(1) DEFAULT NULL,
  `download_folders` smallint(1) DEFAULT NULL,
  `read_comments` smallint(1) DEFAULT NULL,
  `write_comments` smallint(1) DEFAULT NULL,
  `email` smallint(1) NOT NULL DEFAULT '0',
  `weblink` smallint(1) NOT NULL DEFAULT '0',
  `share` smallint(1) NOT NULL DEFAULT '0',
  `metadata` smallint(1) NOT NULL DEFAULT '0',
  `file_history` smallint(1) NOT NULL DEFAULT '0',
  `users_may_see` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '-ALL-',
  `change_pass` smallint(1) NOT NULL DEFAULT '1',
  `edit_profile` SMALLINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_modules_weblinks` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `id_rnd` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `uid` mediumint(9) NOT NULL,
  `pathid` mediumint(9) NOT NULL,
  `share_id` MEDIUMINT( 9 ) NULL DEFAULT NULL,
  `short_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  `date_modified` DATETIME NULL,
  `expiry` datetime DEFAULT NULL,
  `download_limit` mediumint(6) DEFAULT NULL,
  `allow_uploads` int(1) NOT NULL DEFAULT '0',
  `allow_downloads` INT( 1 ) NOT NULL DEFAULT  '1',
  `force_save` tinyint(1) DEFAULT '0',
  `system` smallint(1) NOT NULL DEFAULT '0',
  `notify` mediumint(1) NOT NULL DEFAULT '0',
  `download_terms` text COLLATE utf8_unicode_ci,
  `show_comments` TINYINT(1) NOT NULL DEFAULT '0',
  `show_comments_names` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_rnd` (`id_rnd`),
  KEY `uid` (`uid`,`pathid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_notifications_logs` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `has_errors` smallint(1) NOT NULL DEFAULT '0',
  `data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_paths` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `filename` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `depth` SMALLINT( 3 ) NOT NULL DEFAULT  '0',
  `date_added` datetime NOT NULL,
  `uniq` CHAR( 32 ) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`uniq`),
  INDEX (`filename`, `depth`),
  INDEX `path` (`path`(255))
  ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `df_settings` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `var` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `val` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `var` (`var`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_settings` (`var`, `val`) VALUES
('currentVersion', '2017.03.18'),
('app_title', 'FileRun'),
('smtp_enable', '0'),
('smtp_host', ''),
('smtp_port', ''),
('smtp_username', ''),
('smtp_password', ''),
('smtp_auth', '0'),
('smtp_security', 'ssl'),
('last_email_notification', ''),
('instant_email_notifications', '1'),
('default_notification_address', 'configure-me@example.com'),
('user_registration_enable', '0'),
('user_registration_generate_passwords', '1'),
('user_registration_email_verification', '0'),
('user_registration_approval', '0'),
('user_registration_reqfields_email', '1'),
('user_registration_reqfields_company', '0'),
('user_registration_reqfields_website', '0'),
('user_registration_reqfields_description', '0'),
('user_registration_default_groups', 'a:0:{}'),
('user_registration_default_role', ''),
('user_registration_change_pass', '1'),
('captcha', '0'),
('allow_change_pass', '1'),
('max_login_attempts', '5'),
('allow_persistent_login', '1'),
('logout_redirect', ''),
('password_recovery_enable', '1'),
('password_recovery_force_change', '1'),
('search_enable', '0'),
('search_tika_path', '/path/to/tika-app-1.12.jar'),
('thumbnails_enable', '1'),
('thumbnails_imagemagick', '1'),
('thumbnails_imagemagick_path', 'gm'),
('thumbnails_size', '140'),
('thumbnails_imagemagick_ext', 'psd,psb,eps,tst,plt,ai,pdf,jpg,jpeg,gif,png,jpe,erf,dng,cr2,crw,3fr,fff,ppm,raw,kdc,dcr,nef,mef,mos,nrw,orf,raf,mrw,mdc,rw2,pef,x3f,srw,arw,iiq'),
('thumbnails_ffmpeg', '1'),
('thumbnails_ffmpeg_path', 'ffmpeg'),
('thumbnails_ffmpeg_ext', 'mpg,mpeg,mp4,mov,avi,divx,mkv,wmv,rm,flv,asx,asf,swf,3gp,3g2,m4v,m2ts,mts,m2v'),
('versioning_max', '2'),
('quota_warning_level', '90'),
('ui_default_language', 'english'),
('ui_display_language_menu', '1'),
('ui_double_click', 'preview'),
('ui_login_logo', ''),
('ui_login_text', ''),
('ui_login_title', ''),
('ui_title_logo', '1'),
('ui_logo_url', NULL),
('ui_default_view', 'thumbnails'),
('gravatar_enabled', 1),
('upload_blocked_types', ''),
('allow_folder_notifications', '0'),
('disable_file_history', '0'),
('pushercom_app_id', ''),
('pushercom_app_key', ''),
('pushercom_app_secret', ''),
('pushercom_enable', '0'),
('file_history_entry_lifetime', '7'),
('user_activity_logs_entry_lifetime', '7'),
('maintenance', '0'),
('maintenance_message_public', 'Our FileRun website is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),
('maintenance_message_users', 'This application is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),
('send_from_custom_email', '0'),
('passwords_min_length',  '4'),
('passwords_letters_and_digits',  '0'),
('passwords_requires_uppercase',  '0'),
('passwords_requires_special',  '0'),
('passwords_prevent_seq',  '0'),
('passwords_prevent_common',  '0'),
('passwords_life_time',  '365'),
('logout_inactivity', '30'),
('auth_plugin', ''),
('auth_allow_local', '1'),
('oauth2', '0'),
('notifications_template', '<div style="font-family:tahoma,arial,verdana,sans-serif;font-size:13px;">\n		Hi {$info.userInfo.name},<br>\n		<br>\n\n		{foreach from=$info.actions item=action}\n			{$action.message}\n		{/foreach}\n\n		<br>\n		Best regards,<br>\n		<br>\n		<a href="{$config.url.root}">{$config.url.root}</a>\n</div>'),
('notifications_subject_template', '{$settings.app_title|safeHTML} notifications ({$info.actions[0].info.userInfo.name}: {$info.actions[0].info.actionDescription})'),
('ui_media_folders_music_enable', '1'),
('ui_media_folders_photos_enable', '1');

CREATE TABLE IF NOT EXISTS `df_users` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `two_step_enabled` INT( 1 ) NOT NULL DEFAULT  '0',
  `two_step_secret` VARCHAR( 100 ) NULL,
  `last_otp` VARCHAR( 35 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `last_pass_change` DATETIME NULL DEFAULT NULL,
  `cookie` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `owner` mediumint(9) DEFAULT NULL,
  `registration_date` DATETIME NULL DEFAULT NULL,
  `activated` smallint(1) NOT NULL DEFAULT '0',
  `expiration_date` datetime DEFAULT NULL,
  `require_password_change` int(1) NOT NULL DEFAULT '0',
  `failed_login_attempts` smallint(1) NOT NULL DEFAULT '0',
  `last_access_date` timestamp NULL DEFAULT NULL,
  `last_notif_delivery_date` timestamp NULL DEFAULT NULL,
  `last_login_date` DATETIME NULL DEFAULT NULL,
  `last_logout_date` DATETIME NULL DEFAULT NULL,
  `email` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `receive_notifications` SMALLINT( 1 ) NOT NULL DEFAULT '0',
  `new_email` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name2` VARCHAR( 100 ) COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `company` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `website` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `description` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO `df_users` SET 
`id` = 1,
`username` = 'superuser',
`password` = '$2y$10$VJ7O3Fbg6jtwLNAUSD0BF.89ZldVr2Ghgwd2/bqfH8B33yztzhJCu',
`registration_date` = NOW(),
`activated` = 1,
`require_password_change` = 1,
`name` = 'Superuser';


CREATE TABLE IF NOT EXISTS `df_users_permissions` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `role` mediumint(9) DEFAULT NULL,
  `admin_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_users` smallint(1) NOT NULL DEFAULT '0',
  `admin_roles` smallint(1) NOT NULL DEFAULT '0',
  `admin_notifications` smallint(1) NOT NULL DEFAULT '0',
  `admin_logs` smallint(1) NOT NULL DEFAULT '0',
  `admin_metadata` smallint(1) NOT NULL DEFAULT '0',
  `admin_over` TEXT CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `admin_max_users` smallint(7) NOT NULL DEFAULT '0',
  `admin_homefolder_template` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `homefolder` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `space_quota_max` int(20) DEFAULT NULL,
  `space_quota_current` int(20) NOT NULL DEFAULT '0',
  `readonly` smallint(1) DEFAULT NULL,
  `upload` smallint(1) DEFAULT NULL,
  `upload_max_size` BIGINT( 20 ) NULL DEFAULT NULL,
  `download` smallint(1) DEFAULT NULL,
  `download_folders` smallint(1) DEFAULT NULL,
  `read_comments` smallint(1) DEFAULT NULL,
  `write_comments` smallint(1) DEFAULT NULL,
  `email` smallint(1) NOT NULL DEFAULT '0',
  `weblink` smallint(1) NOT NULL DEFAULT '0',
  `share` smallint(1) NOT NULL DEFAULT '0',
  `metadata` smallint(1) NOT NULL DEFAULT '0',
  `file_history` smallint(1) NOT NULL DEFAULT '0',
  `users_may_see` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '-ALL-',
  `change_pass` smallint(1) NOT NULL DEFAULT '1',
  `edit_profile` SMALLINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_users_permissions` (`uid`, `admin_users`, `admin_roles`, `admin_notifications`, `admin_logs`, `admin_metadata`, `admin_over`, `admin_max_users`, `admin_homefolder_template`, `homefolder`, `space_quota_max`, `space_quota_current`,  `readonly`, `upload`, `download`, `download_folders`, `read_comments`, `write_comments`, `email`, `weblink`, `share`, `metadata`, `file_history`) VALUES
(1, 0, 0, 0, 0, 0, '', 0, '', '/user-files/superuser', NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);


CREATE TABLE IF NOT EXISTS `df_users_sessions` (
`id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE (`token`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



CREATE TABLE IF NOT EXISTS `df_oauth_access_tokens` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `sid` mediumint(8) NOT NULL,
		  `expiry` int(11) NOT NULL,
		  `device_uuid` VARCHAR(255) NULL DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `access_token` (`access_token`),
		  KEY `sid` (`sid`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_access_token_scopes` (
		  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `access_token_id` mediumint(8) NOT NULL,
		  `scope` mediumint(8) NOT NULL,
		  PRIMARY KEY (`id`),
		  KEY `access_token_id` (`access_token_id`),
		  KEY `scope` (`scope`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_auth_codes` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `auth_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `sid` mediumint(8) NOT NULL,
		  `redirect_uri` text COLLATE utf8_unicode_ci NOT NULL,
		  `expiry` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `sid` (`sid`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_auth_code_scopes` (
			`id` mediumint(9) NOT NULL AUTO_INCREMENT,
		  `auth_code_id` mediumint(9) NOT NULL,
		  `scope` mediumint(8) NOT NULL,
		  PRIMARY KEY (`id`),
		  KEY `auth_code_id` (`auth_code_id`),
		  KEY `scope` (`scope`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_clients` (
			`id` mediumint(9) NOT NULL AUTO_INCREMENT,
		  `enabled` smallint(1) NOT NULL DEFAULT '0',
		  `cid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `logo_url` TEXT NULL DEFAULT NULL,
		  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `publisher` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
		  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
		  `website` TEXT CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
		  `publisher_website` TEXT NULL DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `cid` (`cid`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_oauth_clients` (`id`, `enabled`, `cid`, `secret`, `logo_url`, `name`, `publisher`, `description`, `website`, `publisher_website`) VALUES (1, 1, 'FileRun0000000000000000000Mobile', '0000000000000000NoSecret0000000000000000', 'https://www.filerun.com/images/logo-mobile-app.png', 'FileRun Mobile', 'Afian AB', 'Authentication for the mobile apps', 'http://www.filerun.com', 'http://www.afian.se');

CREATE TABLE IF NOT EXISTS `df_oauth_client_redirect_uris` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `cid` mediumint(8) NOT NULL,
		  `uri` text COLLATE utf8_unicode_ci NOT NULL,
		  PRIMARY KEY (`id`),
		  KEY `cid` (`cid`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_oauth_client_redirect_uris` (`id`, `cid`, `uri`) VALUES (1, 1, 'filerun://');

CREATE TABLE IF NOT EXISTS `df_oauth_refresh_tokens` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `refresh_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `access_token_id` mediumint(9) NOT NULL,
		  `expiry` int(11) NOT NULL,
		  `device_uuid` VARCHAR(255) NULL DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `refresh_token` (`refresh_token`),
		  KEY `access_token_id` (`access_token_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_scopes` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `scope` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `df_oauth_scopes` (`scope`, `description`) VALUES
			('profile', ''),
			('download', ''),
			('upload', ''),
			('modify', ''),
			('delete', ''),
			('list', ''),
			('email', ''),
			('weblink', ''),
			('upload.sandbox', ''),
			('weblink.sandbox', ''),
			('delete.sandbox', ''),
			('admin', ''),
			('list.sandbox', ''),
			('download.sandbox', ''),
			('share', ''),
			('share.sandbox', ''),
			('metadata', '');

CREATE TABLE IF NOT EXISTS `df_oauth_sessions` (
			`id` mediumint(8) NOT NULL AUTO_INCREMENT,
		  `owner_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `owner_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `cid` mediumint(8) NOT NULL,
		  `redirect_uri` text COLLATE utf8_unicode_ci,
		  `date_created` DATETIME NULL DEFAULT NULL,
		  `client_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
		  `owner_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `cid` (`cid`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `df_oauth_session_scopes` (
			`id` mediumint(9) NOT NULL AUTO_INCREMENT,
		  `sid` mediumint(9) NOT NULL,
		  `scope` mediumint(9) NOT NULL,
		  PRIMARY KEY (`id`),
		  KEY `sid` (`sid`),
		  KEY `scope` (`scope`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `df_oauth_access_tokens`
		  ADD CONSTRAINT `df_oauth_access_tokens_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_access_token_scopes`
		  ADD CONSTRAINT `df_oauth_access_token_scopes_ibfk_1` FOREIGN KEY (`access_token_id`) REFERENCES `df_oauth_access_tokens` (`id`) ON DELETE CASCADE,
		  ADD CONSTRAINT `df_oauth_access_token_scopes_ibfk_2` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_auth_codes`
		  ADD CONSTRAINT `df_oauth_auth_codes_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_auth_code_scopes`
		  ADD CONSTRAINT `df_oauth_auth_code_scopes_ibfk_1` FOREIGN KEY (`auth_code_id`) REFERENCES `df_oauth_auth_codes` (`id`) ON DELETE CASCADE,
		  ADD CONSTRAINT `df_oauth_auth_code_scopes_ibfk_2` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_client_redirect_uris`
		  ADD CONSTRAINT `df_oauth_client_redirect_uris_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `df_oauth_clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_refresh_tokens`
		  ADD CONSTRAINT `df_oauth_refresh_tokens_ibfk_1` FOREIGN KEY (`access_token_id`) REFERENCES `df_oauth_access_tokens` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_sessions`
		  ADD CONSTRAINT `df_oauth_sessions_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `df_oauth_clients` (`id`) ON DELETE CASCADE;

ALTER TABLE `df_oauth_session_scopes`
		  ADD CONSTRAINT `df_oauth_session_scopes_ibfk_1` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE,
		  ADD CONSTRAINT `df_oauth_session_scopes_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE;
