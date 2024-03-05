BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "account_emailconfirmation" (
	"id"	integer NOT NULL,
	"created"	datetime NOT NULL,
	"sent"	datetime,
	"key"	varchar(64) NOT NULL UNIQUE,
	"email_address_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("email_address_id") REFERENCES "account_emailaddress"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "account_emailaddress" (
	"id"	integer NOT NULL,
	"verified"	bool NOT NULL,
	"primary"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	"email"	varchar(254) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "profiles_userprofile" (
	"id"	integer NOT NULL,
	"default_phone_number"	varchar(20),
	"default_street_address1"	varchar(80),
	"default_street_address2"	varchar(80),
	"default_town_or_city"	varchar(40),
	"default_county"	varchar(80),
	"default_postcode"	varchar(20),
	"default_country"	varchar(2),
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_category" (
	"id"	integer NOT NULL,
	"name"	varchar(254) NOT NULL,
	"friendly_name"	varchar(254),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "checkout_orderlineitem" (
	"id"	integer NOT NULL,
	"quantity"	integer NOT NULL,
	"lineitem_total"	decimal NOT NULL,
	"order_id"	bigint NOT NULL,
	"product_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("order_id") REFERENCES "checkout_order"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "products_product"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "checkout_order" (
	"id"	integer NOT NULL,
	"order_number"	varchar(32) NOT NULL,
	"full_name"	varchar(50) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"phone_number"	varchar(20) NOT NULL,
	"postcode"	varchar(20),
	"town_or_city"	varchar(40) NOT NULL,
	"street_address1"	varchar(80) NOT NULL,
	"street_address2"	varchar(80),
	"county"	varchar(80),
	"date"	datetime NOT NULL,
	"delivery_cost"	decimal NOT NULL,
	"order_total"	decimal NOT NULL,
	"grand_total"	decimal NOT NULL,
	"original_bag"	text NOT NULL,
	"stripe_pid"	varchar(254) NOT NULL,
	"country"	varchar(2) NOT NULL,
	"user_profile_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_profile_id") REFERENCES "profiles_userprofile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_product" (
	"id"	integer NOT NULL,
	"name"	varchar(254) NOT NULL,
	"description"	text NOT NULL,
	"price"	decimal NOT NULL,
	"image_url"	varchar(1024),
	"category_id"	bigint,
	"image"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("category_id") REFERENCES "products_category"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "django_site" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"domain"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialapp_sites" (
	"id"	integer NOT NULL,
	"socialapp_id"	integer NOT NULL,
	"site_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("site_id") REFERENCES "django_site"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("socialapp_id") REFERENCES "socialaccount_socialapp"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialapp" (
	"id"	integer NOT NULL,
	"provider"	varchar(30) NOT NULL,
	"name"	varchar(40) NOT NULL,
	"client_id"	varchar(191) NOT NULL,
	"secret"	varchar(191) NOT NULL,
	"key"	varchar(191) NOT NULL,
	"provider_id"	varchar(200) NOT NULL,
	"settings"	text NOT NULL CHECK((JSON_VALID("settings") OR "settings" IS NULL)),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialtoken" (
	"id"	integer NOT NULL,
	"token"	text NOT NULL,
	"token_secret"	text NOT NULL,
	"expires_at"	datetime,
	"account_id"	integer NOT NULL,
	"app_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("account_id") REFERENCES "socialaccount_socialaccount"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("app_id") REFERENCES "socialaccount_socialapp"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialaccount" (
	"id"	integer NOT NULL,
	"provider"	varchar(200) NOT NULL,
	"uid"	varchar(191) NOT NULL,
	"last_login"	datetime NOT NULL,
	"date_joined"	datetime NOT NULL,
	"user_id"	integer NOT NULL,
	"extra_data"	text NOT NULL CHECK((JSON_VALID("extra_data") OR "extra_data" IS NULL)),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "blog_post" (
	"id"	integer NOT NULL,
	"title"	varchar(200) NOT NULL UNIQUE,
	"slug"	varchar(200) UNIQUE,
	"updated_on"	datetime NOT NULL,
	"content"	text NOT NULL,
	"featured_image"	varchar(255) NOT NULL,
	"excerpt"	text NOT NULL,
	"created_on"	datetime NOT NULL,
	"status"	integer NOT NULL,
	"approved"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "blog_post_likes" (
	"id"	integer NOT NULL,
	"post_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("post_id") REFERENCES "blog_post"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "blog_comment" (
	"id"	integer NOT NULL,
	"name"	varchar(80) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"body"	text NOT NULL,
	"created_on"	datetime NOT NULL,
	"approved"	bool NOT NULL,
	"post_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("post_id") REFERENCES "blog_post"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "blog_userprofile" (
	"id"	integer NOT NULL,
	"first_name"	varchar(255) NOT NULL,
	"last_name"	varchar(255) NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_summernote_attachment" (
	"id"	integer NOT NULL,
	"name"	varchar(255),
	"file"	varchar(100) NOT NULL,
	"uploaded"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-02-15 08:41:45.472051');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-02-15 08:41:45.684126');
INSERT INTO "django_migrations" VALUES (3,'account','0001_initial','2024-02-15 08:41:45.915239');
INSERT INTO "django_migrations" VALUES (4,'account','0002_email_max_length','2024-02-15 08:41:45.995652');
INSERT INTO "django_migrations" VALUES (5,'account','0003_alter_emailaddress_create_unique_verified_email','2024-02-15 08:41:46.084792');
INSERT INTO "django_migrations" VALUES (6,'account','0004_alter_emailaddress_drop_unique_email','2024-02-15 08:41:46.180731');
INSERT INTO "django_migrations" VALUES (7,'account','0005_emailaddress_idx_upper_email','2024-02-15 08:41:46.268678');
INSERT INTO "django_migrations" VALUES (8,'admin','0001_initial','2024-02-15 08:41:46.443568');
INSERT INTO "django_migrations" VALUES (9,'admin','0002_logentry_remove_auto_add','2024-02-15 08:41:46.541506');
INSERT INTO "django_migrations" VALUES (10,'admin','0003_logentry_add_action_flag_choices','2024-02-15 08:41:46.638612');
INSERT INTO "django_migrations" VALUES (11,'contenttypes','0002_remove_content_type_name','2024-02-15 08:41:46.789618');
INSERT INTO "django_migrations" VALUES (12,'auth','0002_alter_permission_name_max_length','2024-02-15 08:41:46.915549');
INSERT INTO "django_migrations" VALUES (13,'auth','0003_alter_user_email_max_length','2024-02-15 08:41:47.007478');
INSERT INTO "django_migrations" VALUES (14,'auth','0004_alter_user_username_opts','2024-02-15 08:41:47.103663');
INSERT INTO "django_migrations" VALUES (15,'auth','0005_alter_user_last_login_null','2024-02-15 08:41:47.214884');
INSERT INTO "django_migrations" VALUES (16,'auth','0006_require_contenttypes_0002','2024-02-15 08:41:47.292186');
INSERT INTO "django_migrations" VALUES (17,'auth','0007_alter_validators_add_error_messages','2024-02-15 08:41:47.370240');
INSERT INTO "django_migrations" VALUES (18,'auth','0008_alter_user_username_max_length','2024-02-15 08:41:47.471162');
INSERT INTO "django_migrations" VALUES (19,'auth','0009_alter_user_last_name_max_length','2024-02-15 08:41:47.591098');
INSERT INTO "django_migrations" VALUES (20,'auth','0010_alter_group_name_max_length','2024-02-15 08:41:47.759603');
INSERT INTO "django_migrations" VALUES (21,'auth','0011_update_proxy_permissions','2024-02-15 08:41:47.840111');
INSERT INTO "django_migrations" VALUES (22,'auth','0012_alter_user_first_name_max_length','2024-02-15 08:41:47.930927');
INSERT INTO "django_migrations" VALUES (23,'profiles','0001_initial','2024-02-15 08:41:48.033268');
INSERT INTO "django_migrations" VALUES (24,'products','0001_initial','2024-02-15 08:41:48.216920');
INSERT INTO "django_migrations" VALUES (25,'products','0002_auto_20231107_2145','2024-02-15 08:41:48.289879');
INSERT INTO "django_migrations" VALUES (26,'checkout','0001_initial','2024-02-15 08:41:48.435783');
INSERT INTO "django_migrations" VALUES (27,'checkout','0002_auto_20231123_2038','2024-02-15 08:41:48.514301');
INSERT INTO "django_migrations" VALUES (28,'checkout','0003_alter_order_country','2024-02-15 08:41:48.657617');
INSERT INTO "django_migrations" VALUES (29,'checkout','0004_order_user_profile','2024-02-15 08:41:48.886543');
INSERT INTO "django_migrations" VALUES (30,'products','0003_remove_product_rating','2024-02-15 08:41:48.982389');
INSERT INTO "django_migrations" VALUES (31,'products','0004_alter_product_image','2024-02-15 08:41:49.085521');
INSERT INTO "django_migrations" VALUES (32,'products','0005_alter_product_image','2024-02-15 08:41:49.196103');
INSERT INTO "django_migrations" VALUES (33,'sessions','0001_initial','2024-02-15 08:41:49.382407');
INSERT INTO "django_migrations" VALUES (34,'sites','0001_initial','2024-02-15 08:41:49.474731');
INSERT INTO "django_migrations" VALUES (35,'sites','0002_alter_domain_unique','2024-02-15 08:41:49.577825');
INSERT INTO "django_migrations" VALUES (36,'socialaccount','0001_initial','2024-02-15 08:41:49.910624');
INSERT INTO "django_migrations" VALUES (37,'socialaccount','0002_token_max_lengths','2024-02-15 08:41:50.098970');
INSERT INTO "django_migrations" VALUES (38,'socialaccount','0003_extra_data_default_dict','2024-02-15 08:41:50.252536');
INSERT INTO "django_migrations" VALUES (39,'socialaccount','0004_app_provider_id_settings','2024-02-15 08:41:50.415178');
INSERT INTO "django_migrations" VALUES (40,'socialaccount','0005_socialtoken_nullable_app','2024-02-15 08:41:50.677707');
INSERT INTO "django_migrations" VALUES (41,'socialaccount','0006_alter_socialaccount_extra_data','2024-02-15 08:41:50.818619');
INSERT INTO "django_migrations" VALUES (42,'blog','0001_initial','2024-03-03 17:30:45.381853');
INSERT INTO "django_migrations" VALUES (43,'django_summernote','0001_initial','2024-03-03 17:34:03.045982');
INSERT INTO "django_migrations" VALUES (44,'django_summernote','0002_update-help_text','2024-03-03 17:34:03.161441');
INSERT INTO "django_migrations" VALUES (45,'django_summernote','0003_alter_attachment_id','2024-03-03 17:34:03.267987');
INSERT INTO "account_emailaddress" VALUES (1,1,1,1,'mtnikmaram@gmail.com');
INSERT INTO "django_admin_log" VALUES (1,'1','persianshop.example.com',2,'[{"changed": {"fields": ["Domain name", "Display name"]}}]',7,1,'2023-11-04 15:43:01.409000');
INSERT INTO "django_admin_log" VALUES (2,'1','mtnikmaram@gmail.com',1,'[{"added": {}}]',8,1,'2023-11-04 15:49:00.385000');
INSERT INTO "django_admin_log" VALUES (3,'1','iphone',1,'[{"added": {}}]',13,1,'2023-11-07 17:33:45.461000');
INSERT INTO "django_admin_log" VALUES (4,'1','iphone 15',1,'[{"added": {}}]',14,1,'2023-11-07 17:34:37.984000');
INSERT INTO "django_admin_log" VALUES (5,'1','iphone',2,'[]',13,1,'2023-11-11 19:45:07.531000');
INSERT INTO "django_admin_log" VALUES (6,'1','iphone',2,'[]',13,1,'2023-11-11 19:48:38.820000');
INSERT INTO "django_admin_log" VALUES (7,'1','Iphone',2,'[{"changed": {"fields": ["Name"]}}]',13,1,'2023-11-11 19:49:12.543000');
INSERT INTO "django_admin_log" VALUES (8,'2','iphone 15promax',1,'[{"added": {}}]',14,1,'2023-11-12 07:50:03.588000');
INSERT INTO "django_admin_log" VALUES (9,'2','Samsung',1,'[{"added": {}}]',13,1,'2023-11-12 07:51:37.559000');
INSERT INTO "django_admin_log" VALUES (10,'3','Samsung s23ultra',1,'[{"added": {}}]',14,1,'2023-11-12 07:52:10.051000');
INSERT INTO "django_admin_log" VALUES (11,'3','MI',1,'[{"added": {}}]',13,1,'2023-11-30 09:47:53.249000');
INSERT INTO "django_admin_log" VALUES (12,'4','Glass',1,'[{"added": {}}]',13,1,'2023-11-30 09:48:15.267000');
INSERT INTO "django_admin_log" VALUES (13,'5','Cover',1,'[{"added": {}}]',13,1,'2023-11-30 09:48:26.233000');
INSERT INTO "django_admin_log" VALUES (14,'6','Charger',1,'[{"added": {}}]',13,1,'2023-11-30 09:48:41.026000');
INSERT INTO "django_admin_log" VALUES (15,'7','Holder',1,'[{"added": {}}]',13,1,'2023-11-30 09:48:58.772000');
INSERT INTO "django_admin_log" VALUES (16,'8','Cable',1,'[{"added": {}}]',13,1,'2023-11-30 09:49:16.092000');
INSERT INTO "django_admin_log" VALUES (17,'9','Other',1,'[{"added": {}}]',13,1,'2023-11-30 09:49:32.252000');
INSERT INTO "django_admin_log" VALUES (18,'10','Headphone',1,'[{"added": {}}]',13,1,'2023-11-30 09:54:10.205000');
INSERT INTO "django_admin_log" VALUES (19,'4','iPhone 13',1,'[{"added": {}}]',14,1,'2023-11-30 10:04:16.153000');
INSERT INTO "django_admin_log" VALUES (20,'4','iPhone 13',2,'[{"changed": {"fields": ["Description", "Price"]}}]',14,1,'2023-11-30 10:17:06.080000');
INSERT INTO "django_admin_log" VALUES (21,'4','iPhone 13',2,'[{"changed": {"fields": ["Description"]}}]',14,1,'2023-11-30 10:23:30.141000');
INSERT INTO "django_admin_log" VALUES (22,'4','iPhone 13',2,'[]',14,1,'2023-11-30 11:48:29.503000');
INSERT INTO "django_admin_log" VALUES (23,'2','iphone 15promax',2,'[{"changed": {"fields": ["Price"]}}]',14,1,'2023-11-30 11:50:39.735000');
INSERT INTO "django_admin_log" VALUES (24,'1','iphone 15',2,'[{"changed": {"fields": ["Price"]}}]',14,1,'2023-11-30 11:51:43.986000');
INSERT INTO "django_admin_log" VALUES (25,'1','iphone 15',2,'[{"changed": {"fields": ["Description"]}}]',14,1,'2023-11-30 11:52:34.664000');
INSERT INTO "django_admin_log" VALUES (26,'3','Samsung s23ultra',2,'[{"changed": {"fields": ["Description", "Price"]}}]',14,1,'2023-11-30 12:00:05.045000');
INSERT INTO "django_admin_log" VALUES (27,'5','Z flip5',1,'[{"added": {}}]',14,1,'2023-11-30 12:02:28.657000');
INSERT INTO "django_admin_log" VALUES (28,'3','Samsung s23ultra',2,'[{"changed": {"fields": ["Rating"]}}]',14,1,'2023-11-30 12:02:40.119000');
INSERT INTO "django_admin_log" VALUES (29,'4','iPhone 13',2,'[{"changed": {"fields": ["Rating"]}}]',14,1,'2023-11-30 12:02:49.132000');
INSERT INTO "django_admin_log" VALUES (30,'1','iphone 15',2,'[{"changed": {"fields": ["Rating"]}}]',14,1,'2023-11-30 12:02:55.199000');
INSERT INTO "django_admin_log" VALUES (31,'2','iphone 15promax',2,'[{"changed": {"fields": ["Rating"]}}]',14,1,'2023-11-30 12:03:00.660000');
INSERT INTO "django_admin_log" VALUES (32,'6','Samsung a14',1,'[{"added": {}}]',14,1,'2023-12-01 13:25:18.734000');
INSERT INTO "django_admin_log" VALUES (33,'7','Samsung glass',1,'[{"added": {}}]',14,1,'2023-12-01 13:26:59.022000');
INSERT INTO "django_admin_log" VALUES (34,'8','MI glass / Note',1,'[{"added": {}}]',14,1,'2023-12-01 13:29:05.843000');
INSERT INTO "django_admin_log" VALUES (35,'9','Samsung glass / A',1,'[{"added": {}}]',14,1,'2023-12-01 13:31:40.408000');
INSERT INTO "django_admin_log" VALUES (36,'10','Iphone 13',1,'[{"added": {}}]',14,1,'2023-12-01 13:34:29.224000');
INSERT INTO "django_admin_log" VALUES (37,'11','Samsung Z Fold 4',1,'[{"added": {}}]',14,1,'2023-12-01 13:36:30.920000');
INSERT INTO "django_admin_log" VALUES (38,'12','Redmi Note 12 4G',1,'[{"added": {}}]',14,1,'2023-12-01 13:38:29.805000');
INSERT INTO "django_admin_log" VALUES (39,'13','Redmi Note 12 4G',1,'[{"added": {}}]',14,1,'2023-12-01 13:40:22.096000');
INSERT INTO "django_admin_log" VALUES (40,'14','iphone',1,'[{"added": {}}]',14,1,'2023-12-01 13:42:33.301000');
INSERT INTO "django_admin_log" VALUES (41,'15','kuloman usb cable',1,'[{"added": {}}]',14,1,'2023-12-01 13:44:09.174000');
INSERT INTO "django_admin_log" VALUES (42,'16','OTG USB-C',1,'[{"added": {}}]',14,1,'2023-12-01 13:45:59.475000');
INSERT INTO "django_admin_log" VALUES (43,'17','HD-Conversion',1,'[{"added": {}}]',14,1,'2023-12-01 13:47:35.730000');
INSERT INTO "django_admin_log" VALUES (44,'18','Samsung',1,'[{"added": {}}]',14,1,'2023-12-01 13:49:35.375000');
INSERT INTO "django_admin_log" VALUES (45,'19','iphone',1,'[{"added": {}}]',14,1,'2023-12-01 13:50:46.863000');
INSERT INTO "django_admin_log" VALUES (46,'20','car charger',1,'[{"added": {}}]',14,1,'2023-12-01 13:52:18.300000');
INSERT INTO "django_admin_log" VALUES (47,'21','iphone',1,'[{"added": {}}]',14,1,'2023-12-01 13:53:58.144000');
INSERT INTO "django_admin_log" VALUES (48,'22','holder',1,'[{"added": {}}]',14,1,'2023-12-01 13:55:15.746000');
INSERT INTO "django_admin_log" VALUES (49,'23','holder',1,'[{"added": {}}]',14,1,'2023-12-01 13:58:11.262000');
INSERT INTO "django_admin_log" VALUES (50,'24','holder',1,'[{"added": {}}]',14,1,'2023-12-01 13:58:38.380000');
INSERT INTO "django_admin_log" VALUES (51,'25','holder',1,'[{"added": {}}]',14,1,'2023-12-01 13:59:03.582000');
INSERT INTO "django_admin_log" VALUES (52,'26','holder',1,'[{"added": {}}]',14,1,'2023-12-01 13:59:28.078000');
INSERT INTO "django_admin_log" VALUES (53,'27','Haylou',1,'[{"added": {}}]',14,1,'2023-12-01 14:02:21.284000');
INSERT INTO "django_admin_log" VALUES (54,'28','qcy',1,'[{"added": {}}]',14,1,'2023-12-01 14:03:21.171000');
INSERT INTO "django_admin_log" VALUES (55,'29','Samsung',1,'[{"added": {}}]',14,1,'2023-12-01 14:04:35.314000');
INSERT INTO "django_admin_log" VALUES (56,'30','Xiaomi 13T Pro',1,'[{"added": {}}]',14,1,'2023-12-01 14:07:53.791000');
INSERT INTO "django_admin_log" VALUES (57,'5','Z flip5',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:32:56.454000');
INSERT INTO "django_admin_log" VALUES (58,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:37:33.194000');
INSERT INTO "django_admin_log" VALUES (59,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:37:41.463000');
INSERT INTO "django_admin_log" VALUES (60,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:37:50.004000');
INSERT INTO "django_admin_log" VALUES (61,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:40:52.759000');
INSERT INTO "django_admin_log" VALUES (62,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-02 19:41:02.746000');
INSERT INTO "django_admin_log" VALUES (63,'1','iphone 15',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-09 18:53:23.222000');
INSERT INTO "django_admin_log" VALUES (64,'1','iphone 15',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-12-09 18:53:55.447000');
INSERT INTO "django_admin_log" VALUES (65,'1','ED51CDE33512497E83CA98A7212EFE75',3,'',15,1,'2023-12-09 20:37:11.128000');
INSERT INTO "django_admin_log" VALUES (66,'1','iphone 15',1,'[{"added": {}}]',19,1,'2024-03-03 18:16:56.728124');
INSERT INTO "django_admin_log" VALUES (67,'17','HD-Conversion',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:30:44.260769');
INSERT INTO "django_admin_log" VALUES (68,'17','HD-Conversion',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:30:58.979383');
INSERT INTO "django_admin_log" VALUES (69,'27','Haylou',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:41:37.481211');
INSERT INTO "django_admin_log" VALUES (70,'10','Iphone 13',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:43:39.632841');
INSERT INTO "django_admin_log" VALUES (71,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:44:13.855581');
INSERT INTO "django_admin_log" VALUES (72,'16','OTG USB-C',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:44:34.585857');
INSERT INTO "django_admin_log" VALUES (73,'13','Redmi Note 12 4G',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:45:37.432826');
INSERT INTO "django_admin_log" VALUES (74,'12','Redmi Note 12 4G',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:45:56.742696');
INSERT INTO "django_admin_log" VALUES (75,'29','Samsung',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:46:17.344126');
INSERT INTO "django_admin_log" VALUES (76,'18','Samsung',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:46:35.686673');
INSERT INTO "django_admin_log" VALUES (77,'11','Samsung Z Fold 4',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:46:55.978784');
INSERT INTO "django_admin_log" VALUES (78,'6','Samsung a14',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:47:13.021695');
INSERT INTO "django_admin_log" VALUES (79,'7','Samsung glass',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:47:33.395156');
INSERT INTO "django_admin_log" VALUES (80,'9','Samsung glass / A',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:47:48.589149');
INSERT INTO "django_admin_log" VALUES (81,'3','Samsung s23ultra',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:48:05.265339');
INSERT INTO "django_admin_log" VALUES (82,'30','Xiaomi 13T Pro',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:48:23.095288');
INSERT INTO "django_admin_log" VALUES (83,'5','Z flip5 Ed',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:48:46.521799');
INSERT INTO "django_admin_log" VALUES (84,'33','aaaaaaaa',3,'',14,1,'2024-03-03 18:48:56.808410');
INSERT INTO "django_admin_log" VALUES (85,'20','car charger',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:49:29.242920');
INSERT INTO "django_admin_log" VALUES (86,'26','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:49:47.884548');
INSERT INTO "django_admin_log" VALUES (87,'25','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:50:19.707793');
INSERT INTO "django_admin_log" VALUES (88,'24','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:50:41.472545');
INSERT INTO "django_admin_log" VALUES (89,'23','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:50:58.165231');
INSERT INTO "django_admin_log" VALUES (90,'22','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:51:21.082812');
INSERT INTO "django_admin_log" VALUES (91,'4','iPhone 13',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:51:38.895781');
INSERT INTO "django_admin_log" VALUES (92,'21','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:52:11.331198');
INSERT INTO "django_admin_log" VALUES (93,'19','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:52:25.133574');
INSERT INTO "django_admin_log" VALUES (94,'14','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:52:48.335099');
INSERT INTO "django_admin_log" VALUES (95,'2','iphone 15promax',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:53:05.192682');
INSERT INTO "django_admin_log" VALUES (96,'15','kuloman usb cable',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:53:23.559065');
INSERT INTO "django_admin_log" VALUES (97,'28','qcy',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-03 18:53:40.533200');
INSERT INTO "django_admin_log" VALUES (98,'1','iphone 15',2,'[{"changed": {"fields": ["Content"]}}]',19,1,'2024-03-03 18:54:43.165625');
INSERT INTO "django_admin_log" VALUES (99,'2','Rivu',3,'',4,1,'2024-03-03 18:54:57.493347');
INSERT INTO "django_admin_log" VALUES (100,'3','Souro',3,'',4,1,'2024-03-03 18:54:57.629507');
INSERT INTO "django_admin_log" VALUES (101,'4','samira',3,'',4,1,'2024-03-03 18:54:57.710684');
INSERT INTO "django_admin_log" VALUES (102,'5','samiraroza',3,'',4,1,'2024-03-03 18:54:57.839162');
INSERT INTO "django_admin_log" VALUES (103,'1','Comment salam by persian',2,'[{"changed": {"fields": ["Approved"]}}]',18,1,'2024-03-03 18:59:08.210643');
INSERT INTO "django_admin_log" VALUES (104,'17','HD-Conversion',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 10:58:10.545100');
INSERT INTO "django_admin_log" VALUES (105,'2','Rivu',3,'',4,1,'2024-03-04 10:59:38.460945');
INSERT INTO "django_admin_log" VALUES (106,'3','Souro',3,'',4,1,'2024-03-04 10:59:38.557266');
INSERT INTO "django_admin_log" VALUES (107,'4','samira',3,'',4,1,'2024-03-04 10:59:38.644578');
INSERT INTO "django_admin_log" VALUES (108,'5','samiraroza',3,'',4,1,'2024-03-04 10:59:38.757239');
INSERT INTO "django_admin_log" VALUES (109,'27','Haylou',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:10:20.254772');
INSERT INTO "django_admin_log" VALUES (110,'10','Iphone 13',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:10:53.212876');
INSERT INTO "django_admin_log" VALUES (111,'8','MI glass / Note',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:11:16.018271');
INSERT INTO "django_admin_log" VALUES (112,'13','Redmi Note 12 4G',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:11:51.637145');
INSERT INTO "django_admin_log" VALUES (113,'16','OTG USB-C',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:12:09.362933');
INSERT INTO "django_admin_log" VALUES (114,'12','Redmi Note 12 4G',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:12:28.382420');
INSERT INTO "django_admin_log" VALUES (115,'29','Samsung',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:12:47.054220');
INSERT INTO "django_admin_log" VALUES (116,'18','Samsung',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:13:02.989534');
INSERT INTO "django_admin_log" VALUES (117,'11','Samsung Z Fold 4',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:13:19.880021');
INSERT INTO "django_admin_log" VALUES (118,'6','Samsung a14',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:13:39.116641');
INSERT INTO "django_admin_log" VALUES (119,'7','Samsung glass',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:14:01.160344');
INSERT INTO "django_admin_log" VALUES (120,'9','Samsung glass / A',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:14:26.506720');
INSERT INTO "django_admin_log" VALUES (121,'3','Samsung s23ultra',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:14:48.038315');
INSERT INTO "django_admin_log" VALUES (122,'30','Xiaomi 13T Pro',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:15:23.823991');
INSERT INTO "django_admin_log" VALUES (123,'5','Z flip5 Ed',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:15:42.882450');
INSERT INTO "django_admin_log" VALUES (124,'20','car charger',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:16:05.119955');
INSERT INTO "django_admin_log" VALUES (125,'26','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:16:21.308628');
INSERT INTO "django_admin_log" VALUES (126,'25','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:16:39.098731');
INSERT INTO "django_admin_log" VALUES (127,'24','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:16:54.169693');
INSERT INTO "django_admin_log" VALUES (128,'23','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:17:17.615607');
INSERT INTO "django_admin_log" VALUES (129,'22','holder',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:17:34.115531');
INSERT INTO "django_admin_log" VALUES (130,'4','iPhone 13',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:17:50.369578');
INSERT INTO "django_admin_log" VALUES (131,'21','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:18:08.775373');
INSERT INTO "django_admin_log" VALUES (132,'19','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:18:26.032822');
INSERT INTO "django_admin_log" VALUES (133,'14','iphone',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:18:42.839147');
INSERT INTO "django_admin_log" VALUES (134,'1','iphone 15',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:19:49.008433');
INSERT INTO "django_admin_log" VALUES (135,'2','iphone 15promax',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:20:03.980270');
INSERT INTO "django_admin_log" VALUES (136,'15','kuloman usb cable',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:20:17.398902');
INSERT INTO "django_admin_log" VALUES (137,'28','qcy',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2024-03-04 11:20:32.888224');
INSERT INTO "django_admin_log" VALUES (138,'33','aaaaaaaa',3,'',14,1,'2024-03-04 11:20:42.139934');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'sites','site');
INSERT INTO "django_content_type" VALUES (8,'account','emailaddress');
INSERT INTO "django_content_type" VALUES (9,'account','emailconfirmation');
INSERT INTO "django_content_type" VALUES (10,'socialaccount','socialaccount');
INSERT INTO "django_content_type" VALUES (11,'socialaccount','socialapp');
INSERT INTO "django_content_type" VALUES (12,'socialaccount','socialtoken');
INSERT INTO "django_content_type" VALUES (13,'products','category');
INSERT INTO "django_content_type" VALUES (14,'products','product');
INSERT INTO "django_content_type" VALUES (15,'checkout','order');
INSERT INTO "django_content_type" VALUES (16,'checkout','orderlineitem');
INSERT INTO "django_content_type" VALUES (17,'profiles','userprofile');
INSERT INTO "django_content_type" VALUES (18,'blog','comment');
INSERT INTO "django_content_type" VALUES (19,'blog','post');
INSERT INTO "django_content_type" VALUES (20,'blog','userprofile');
INSERT INTO "django_content_type" VALUES (21,'django_summernote','attachment');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_site','Can add site');
INSERT INTO "auth_permission" VALUES (26,7,'change_site','Can change site');
INSERT INTO "auth_permission" VALUES (27,7,'delete_site','Can delete site');
INSERT INTO "auth_permission" VALUES (28,7,'view_site','Can view site');
INSERT INTO "auth_permission" VALUES (29,8,'add_emailaddress','Can add email address');
INSERT INTO "auth_permission" VALUES (30,8,'change_emailaddress','Can change email address');
INSERT INTO "auth_permission" VALUES (31,8,'delete_emailaddress','Can delete email address');
INSERT INTO "auth_permission" VALUES (32,8,'view_emailaddress','Can view email address');
INSERT INTO "auth_permission" VALUES (33,9,'add_emailconfirmation','Can add email confirmation');
INSERT INTO "auth_permission" VALUES (34,9,'change_emailconfirmation','Can change email confirmation');
INSERT INTO "auth_permission" VALUES (35,9,'delete_emailconfirmation','Can delete email confirmation');
INSERT INTO "auth_permission" VALUES (36,9,'view_emailconfirmation','Can view email confirmation');
INSERT INTO "auth_permission" VALUES (37,10,'add_socialaccount','Can add social account');
INSERT INTO "auth_permission" VALUES (38,10,'change_socialaccount','Can change social account');
INSERT INTO "auth_permission" VALUES (39,10,'delete_socialaccount','Can delete social account');
INSERT INTO "auth_permission" VALUES (40,10,'view_socialaccount','Can view social account');
INSERT INTO "auth_permission" VALUES (41,11,'add_socialapp','Can add social application');
INSERT INTO "auth_permission" VALUES (42,11,'change_socialapp','Can change social application');
INSERT INTO "auth_permission" VALUES (43,11,'delete_socialapp','Can delete social application');
INSERT INTO "auth_permission" VALUES (44,11,'view_socialapp','Can view social application');
INSERT INTO "auth_permission" VALUES (45,12,'add_socialtoken','Can add social application token');
INSERT INTO "auth_permission" VALUES (46,12,'change_socialtoken','Can change social application token');
INSERT INTO "auth_permission" VALUES (47,12,'delete_socialtoken','Can delete social application token');
INSERT INTO "auth_permission" VALUES (48,12,'view_socialtoken','Can view social application token');
INSERT INTO "auth_permission" VALUES (49,13,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (50,13,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (51,13,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (52,13,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (53,14,'add_product','Can add product');
INSERT INTO "auth_permission" VALUES (54,14,'change_product','Can change product');
INSERT INTO "auth_permission" VALUES (55,14,'delete_product','Can delete product');
INSERT INTO "auth_permission" VALUES (56,14,'view_product','Can view product');
INSERT INTO "auth_permission" VALUES (57,15,'add_order','Can add order');
INSERT INTO "auth_permission" VALUES (58,15,'change_order','Can change order');
INSERT INTO "auth_permission" VALUES (59,15,'delete_order','Can delete order');
INSERT INTO "auth_permission" VALUES (60,15,'view_order','Can view order');
INSERT INTO "auth_permission" VALUES (61,16,'add_orderlineitem','Can add order line item');
INSERT INTO "auth_permission" VALUES (62,16,'change_orderlineitem','Can change order line item');
INSERT INTO "auth_permission" VALUES (63,16,'delete_orderlineitem','Can delete order line item');
INSERT INTO "auth_permission" VALUES (64,16,'view_orderlineitem','Can view order line item');
INSERT INTO "auth_permission" VALUES (65,17,'add_userprofile','Can add user profile');
INSERT INTO "auth_permission" VALUES (66,17,'change_userprofile','Can change user profile');
INSERT INTO "auth_permission" VALUES (67,17,'delete_userprofile','Can delete user profile');
INSERT INTO "auth_permission" VALUES (68,17,'view_userprofile','Can view user profile');
INSERT INTO "auth_permission" VALUES (69,18,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (70,18,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (71,18,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (72,18,'view_comment','Can view comment');
INSERT INTO "auth_permission" VALUES (73,19,'add_post','Can add post');
INSERT INTO "auth_permission" VALUES (74,19,'change_post','Can change post');
INSERT INTO "auth_permission" VALUES (75,19,'delete_post','Can delete post');
INSERT INTO "auth_permission" VALUES (76,19,'view_post','Can view post');
INSERT INTO "auth_permission" VALUES (77,20,'add_userprofile','Can add user profile');
INSERT INTO "auth_permission" VALUES (78,20,'change_userprofile','Can change user profile');
INSERT INTO "auth_permission" VALUES (79,20,'delete_userprofile','Can delete user profile');
INSERT INTO "auth_permission" VALUES (80,20,'view_userprofile','Can view user profile');
INSERT INTO "auth_permission" VALUES (81,21,'add_attachment','Can add attachment');
INSERT INTO "auth_permission" VALUES (82,21,'change_attachment','Can change attachment');
INSERT INTO "auth_permission" VALUES (83,21,'delete_attachment','Can delete attachment');
INSERT INTO "auth_permission" VALUES (84,21,'view_attachment','Can view attachment');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$720000$e1ijWJc1pabL6QhNjlxC2s$Mq3nJ45p2Ffl9MiWsp1EgRYjvbGe3LPDaZf2ZOxuf/I=','2024-03-04 10:53:56.264738',1,'persian','','mtnikmaram@gmail.com',1,1,'2023-11-02 16:50:53.054000','');
INSERT INTO "profiles_userprofile" VALUES (1,'09123687407',NULL,NULL,NULL,NULL,NULL,'IR',1);
INSERT INTO "products_category" VALUES (1,'Iphone','iphone');
INSERT INTO "products_category" VALUES (2,'Samsung','samsung');
INSERT INTO "products_category" VALUES (3,'MI','mi');
INSERT INTO "products_category" VALUES (4,'Glass','glass');
INSERT INTO "products_category" VALUES (5,'Cover','cover');
INSERT INTO "products_category" VALUES (6,'Charger','charger');
INSERT INTO "products_category" VALUES (7,'Holder','holder');
INSERT INTO "products_category" VALUES (8,'Cable','cable');
INSERT INTO "products_category" VALUES (9,'Other','other');
INSERT INTO "products_category" VALUES (10,'Headphone','headphone');
INSERT INTO "checkout_orderlineitem" VALUES (2,1,1199.99,2,2);
INSERT INTO "checkout_orderlineitem" VALUES (3,1,799,3,3);
INSERT INTO "checkout_orderlineitem" VALUES (4,1,799,4,3);
INSERT INTO "checkout_order" VALUES (2,'DDB747519BF941AD8C45FFEF8BE19553','mohammad','mtnikmaram@gmail.com','12334',NULL,'12345','12345',NULL,NULL,'2023-12-10 16:37:54.559000',0,1199.99,1199.99,'{"2": 1}','pi_3OLpzICJyAgrpdVr1uxF0U3Y','US',NULL);
INSERT INTO "checkout_order" VALUES (3,'1F5BAE02CE514F45A50D86F6D78C0DDE','test','cixode1509@ikuromi.com','123546789','123456','test','test','test','test','2024-01-22 08:47:09.765000',0,799,799,'{"3": 1}','pi_3ObJ9NCJyAgrpdVr1fUxUxmT','AU',NULL);
INSERT INTO "checkout_order" VALUES (4,'D11DEEC8B97543BB99E81BA5EEAE385F','aaa','kemeviw875@oprevolt.com','1234567890','R1J1NN','aaaaaaaaaaa','aaaaaaaa','aaaaaaaaa','aaaaaaaaa','2024-02-14 08:24:44.294000',0,799,799,'{"3": 1}','pi_3OjdlECJyAgrpdVr1N6xAsaP','AT',NULL);
INSERT INTO "products_product" VALUES (1,'iphone 15','Released 2023, September 22
171g, 7.8mm thickness
iOS 17, up to iOS 17.1.1
128GB/256GB/512GB storage, no card slot
1179x2556 pixels
48MP
2160p
6GB RAM
Apple A16 Bionic
3349mAh
Li-Ion',769.99,NULL,1,'media/iphone15_cekg17');
INSERT INTO "products_product" VALUES (2,'iphone 15promax','iPhone 15 promax',1199.99,NULL,1,'media/15promax_2brVoeb_qzarer');
INSERT INTO "products_product" VALUES (3,'Samsung s23ultra','Released 2023, February 17
234g, 8.9mm thickness
Android 13, up to Android 14, One UI 6
256GB/512GB/1TB storage, no card slot
1440x3088 pixels
200MP
4320p
8/12GB RAM
Snapdragon 8 Gen 2
5000mAh
Li-Ion',799,NULL,2,'media/s23ultra_2wgukS8_h6j6xe');
INSERT INTO "products_product" VALUES (4,'iPhone 13','Brand	Apple
Model Name	13
Wireless Carrier	3
Cellular Technology	5G
Memory Storage Capacity	128 GB
Connectivity Technology	Wi-Fi
Color	Midnight
Screen Size	6.1 Inches
Wireless network technology	GSM
SIM card slot count	Dual SIM',474.99,NULL,1,'media/iphone-13_aHy4YiX_grj3eo');
INSERT INTO "products_product" VALUES (5,'Z flip5 Ed','Released 2023, August 11
187g, 6.9mm thickness
Android 13, up to Android 14, One UI 6
256GB/512GB storage, no card slot
11%
1,288,204 HITS
218
BECOME A FAN
6.7"
1080x2640 pixels
12MP
2160p
8GB RAM
Snapdragon 8 Gen 2
3700mAh
Li-Po',949.99,NULL,2,'media/zfilip5_fdzb4BD_pxyPKom_ekq4c2');
INSERT INTO "products_product" VALUES (6,'Samsung a14','for Samsung galaxy a14',4.99,NULL,4,'media/glass-samsung_g9VhUEm_uoxmaj');
INSERT INTO "products_product" VALUES (7,'Samsung glass','Galaxy A02 / M13 / A23',4.99,NULL,4,'media/glass-samsung-1_lyuaE16_g0kqnj');
INSERT INTO "products_product" VALUES (8,'MI glass / Note','Redmi Note 10 Pro / Note 10 Pro Max / Note 11 Pro',4.99,NULL,4,'media/glass-mi_oT1aOGZ_q22xsf');
INSERT INTO "products_product" VALUES (9,'Samsung glass / A','A51 5G \ A52 5G \ A53 5G \ M31s \ S20 FE \ S21 FE \ A52s \ A53s Pack Of 3',4.99,NULL,4,'media/glass-samsung-2_ednaQTT_wigkoa');
INSERT INTO "products_product" VALUES (10,'Iphone 13','iPhone 13 new skin',25.99,NULL,5,'media/cover-iphone_Ujf0jYL_lpzaxp');
INSERT INTO "products_product" VALUES (11,'Samsung Z Fold 4','Galaxy Z Fold 4',45.99,NULL,5,'media/cover-samsung_Yfw3Lls_xwfe6x');
INSERT INTO "products_product" VALUES (12,'Redmi Note 12 4G','Redmi Note 12 4G',54.99,NULL,5,'media/cover-mi_GlYoTob_gqul0j');
INSERT INTO "products_product" VALUES (13,'Redmi Note 12 4G','Released 2023, March 30
183.5g, 7.9mm thickness
Android 13, MIUI 14
64GB/128GB/256GB storage, microSDXC
1080x2400 pixels
50MP
1080p
4-8GB RAM
Snapdragon 685
5000mAh',137.99,NULL,3,'media/Redmi_Note_12_4G_anpf7o');
INSERT INTO "products_product" VALUES (14,'iphone','usb to lightning for iPhone',44.99,NULL,8,'media/cable-iphone_y927Bho_ifuxfm');
INSERT INTO "products_product" VALUES (15,'kuloman usb cable','microUSB',25.99,NULL,8,'media/cable-usb_jyiJtVc_qto3on');
INSERT INTO "products_product" VALUES (16,'OTG USB-C','Remax OTG USB-C',9.99,NULL,8,'media/otg_PdYZVO6_xn7uwf');
INSERT INTO "products_product" VALUES (17,'HD-Conversion','VGA to HDMI',14.99,NULL,8,'media/vga_YN2MI8L_bidg0u');
INSERT INTO "products_product" VALUES (18,'Samsung','25 w type-C',19.99,NULL,6,'media/samsung_charger_wiucdg');
INSERT INTO "products_product" VALUES (19,'iphone','20 w iphone charger',25,NULL,6,'media/iphone-charger_wcSKT1y_qcysl8');
INSERT INTO "products_product" VALUES (20,'car charger','usb 3 for all cellphones',17.99,NULL,6,'media/charger-car_QU40DXx_ci1qlw');
INSERT INTO "products_product" VALUES (21,'iphone','MagSafe',45,NULL,6,'media/iphone-macsafe_ncHs8NZ_ojwvgc');
INSERT INTO "products_product" VALUES (22,'holder','black',48,NULL,7,'media/holder_N5JLtKu_oacrsi');
INSERT INTO "products_product" VALUES (23,'holder','car holder',28,NULL,7,'media/holder-1_06EXnGc_j4uoxi');
INSERT INTO "products_product" VALUES (24,'holder','car holder',34.99,NULL,7,'media/holder-2_9YJZmJU_h2bho7');
INSERT INTO "products_product" VALUES (25,'holder','holder',21.99,NULL,7,'media/holder-3_lx6lgAZ_y9u5an');
INSERT INTO "products_product" VALUES (26,'holder','car holder',32.99,NULL,7,'media/holder-4_e18wicW_mru1ur');
INSERT INTO "products_product" VALUES (27,'Haylou','Bluetooth',90.99,NULL,10,'media/haylou_yp5grrh_bilnkb');
INSERT INTO "products_product" VALUES (28,'qcy','Bluetooth',58.99,NULL,10,'media/qcy_XuLpL3j_pqumyv');
INSERT INTO "products_product" VALUES (29,'Samsung','Galaxy Buds2 Pro',150,NULL,10,'media/buds_xWpRHeY_ebgmac');
INSERT INTO "products_product" VALUES (30,'Xiaomi 13T Pro','Released 2023, September 26
200g or 206g, 8.5mm thickness
Android 13, MIUI 14
256GB/512GB/1TB storage, no card slot

1220x2712 pixels
50MP
4320p
12/16GB RAM
Dimensity 9200+
5000mAh
Li-Po',595,NULL,3,'media/13T_Pro_tg52wb');
INSERT INTO "django_session" VALUES ('49esgqztvycp40wuag88r27u3dkz7awl','e30:1raY2I:EKOCluWzb-ikW3wSLq-OnIzFEzk-BnREs9yFVhysHwU','2024-02-29 09:28:06.625856');
INSERT INTO "django_session" VALUES ('tmdvkywubfabjpar4i1n0v9dhdrfyjuo','.eJxVjEEOwiAQRe_C2hCEwlCX7nsGMsCMVA0kpV0Z765NutDtf-_9lwi4rSVsnZYwZ3ERWpx-t4jpQXUH-Y711mRqdV3mKHdFHrTLqWV6Xg_376BgL9_aJoWGrDtHT-AH7Uwm1uBhNJwQlBsNGMWRswVNkJJidOBIIbOPfhDvD93gOBw:1raZKw:-U40GY08BH80XyjCD8hID7JKl1FxHagrIDqvFEtqkvQ','2024-02-29 10:51:26.506691');
INSERT INTO "django_session" VALUES ('hxexibgzoe1dwx8ej3f94ffhllhjitq3','.eJxVjDsOwyAQBe-ydYTCAgZcps8ZrIXdGCcRlvypLN89seTG7ZuZt0GiHtptv0FH61K6dZapGxha0HDZEuWP1APwm2o_qjzWZRqSOhR10lk9R5bv43QvB4Xm8q-boB3SSwxjjoISENFg8BJdxpi0t5wlSmDPPlphF4XJmSYZexexGvYfy0o6uQ:1rAxek:NTTrGrQRItm6AJJGtW2-QEswRt_F6Q70U5fvL_oJzGY','2023-12-20 19:34:02.137000');
INSERT INTO "django_session" VALUES ('o4xwymt6675p9aw7mnzle2uykvb5epd4','.eJxVjMEOwiAQRP-FsyFdSmHx6N1vIJRlpWogKe3J-O9K0oPOcd6beQkf9i37vaXVLyTOAsTpt5tDfKTSAd1DuVUZa9nWZZZdkQdt8lopPS-H-3eQQ8t9jYndhMiKOVgDSjlE-00iiBpHYEeTVQR6DM6BpsTDbMzAzARoSbw_3HI31w:1r94BN:b9r-GZSbZ6DHI9DA67BOv5lxkjJ_sNxPG9AUNTRQp0M','2023-12-15 14:07:53.997000');
INSERT INTO "django_session" VALUES ('v9b9e6726d7lm3hz5x1rkfh9def7hg2y','e30:1r6y5k:-kTBeuLrhi2YOltM53tso8FcqwYo-VHd5_Arx_LSxBg','2023-12-09 19:13:24.981000');
INSERT INTO "django_session" VALUES ('yoczsov49ftgwe6dd2rkkc1a914slkf7','.eJxVjDsOwjAQRO_iGllek_iTkp4zWE52lxiQjeJEAiHuDkEpYMqZN-8pQlzmMSyVppBQdALE7rfr43ChvA54jvlU5FDyPKVerojc1iqPBel62Ng_wRjruL4dsW-dY80crQGtvXP2E0IYGrcH9thajdDso_fQILHqjVHMjODsV1qp1lRyoPstTQ_RgVbeKPV6AwCnQEY:1r8eCg:04IXkJaGaZn9l8kw1CRNFZhcvAG4MvZZzp7qz0hWnyk','2023-12-14 10:23:30.254000');
INSERT INTO "django_session" VALUES ('3ih9ovsd8k736725tjn8qmy3gntanlh9','.eJxVjkEOwiAURO_C2hD7gQIu3XsGAvyprRpISuvGeHdt0oVu572ZzEuEuC5jWBvmMLE4iU4cfrMU8x1lA3yL5VplrmWZpyQ3Re60yUtlPM67-zcwxjZ-273rDMUBiil7EBwRKXIW3mTyqbOaMzwcW7Zeg40HR6P6pPQR0NurFp8IUxmqOC3zivcHxyY-EQ:1rC46V:B9mcB4JRggUKxdjDnT3XBcY4zVlQuYaq76AmtlgpKvk','2023-12-23 20:39:15.698000');
INSERT INTO "django_session" VALUES ('7ojhoz0x7rjbwqpa1ko742uyt2js6dct','.eJxVjkEOwiAURO_C2pD2AwW6dO8ZCPC_FjVgoE00xrtrTRe6nfdmMk_m_DJPbmlUXUI2sp7tfrPg44XyCvDs86nwWPJcU-Crwjfa-KEgXfeb-zcw-TZ92oPpFfgjCYRoCcgAgACjyaoINvRaYiRLBjVqKwmVJfRKDEHIjkh-XzVqLZXs6H5L9cHG7vUGhrY_Kg:1rDYBE:Z1EuhCoRltqWgGSJU4F-nE4b9Su12cON6CRWNmtHKLc','2023-12-27 22:58:16.897000');
INSERT INTO "django_session" VALUES ('86tu10a7m2hia9qpxhzsl87wq3zua9qy','.eJxljMEOwiAQBf-Fs2koLVJ69O43kIVdLFrBQGs0xn_XmsbEeJ2Z9x4MnEtznMyVcvCB0NAZwsj6OI_j5mvnQpn1TLINMzBPwweYgP_MgjtRXAQeIR5S5VKccrDVklSrLdU-IY27tf05GKAM7zXnHaIHkI3SW9lYWfOOixadtMo3vnOohUVe89rWvgXdKFToyQqhlfPKLaeFSgkpGrpdQr6znj9fhHdRAA:1raYR2:Vm8hSI9ANPyTUl64mVFvwApK8VOrVcmpdDeTiL5x2ew','2024-02-29 09:53:40.078000');
INSERT INTO "django_session" VALUES ('dddd2hrqa609x8zjqqgmll8puvp1iz66','.eJxVjk0OwiAYRO_CuiEt_QG6dO8ZCPBNLWrAQGs0xrtrjQvdznszmQczdl1msxZkE4iNrGHVb-asPyFugI42HhL3KS45OL4p_EsL3yfCefd1_wZmW-Z3e1BNL-yEloTXEFBCiFYoCd17oV0jO_LQUCRJ6g7Ua5Dt28G1XQ10n1cFpYQUDW6XkO9srCtW7BUmxCmxcckrni_rDUVO:1raAZQ:uEJSIRua9HB_-2lRevkmUolyj6YolLovfefWbRmoWdM','2024-02-28 08:24:44.987000');
INSERT INTO "django_session" VALUES ('deamekuiwxjymkhmflp32oz2qthoh423','e30:1raYQP:6G3oJ5w9sa5tNzjp0T2d5jy9cynlY0JqeYHidNf0N9w','2024-02-29 09:53:01.436000');
INSERT INTO "django_session" VALUES ('dnryns8p8oyk7babx62ra2wwjyerjafg','eyJiYWciOnt9fQ:1rSZ5I:YkbVq35vvFRrU6LGNvzyvVjxTnVOkIZ6namQsm3n-mg','2024-02-07 08:58:12.801000');
INSERT INTO "django_session" VALUES ('jn4tbwae21mbcs3ad4zeh7n2wxlf3bto','.eJxVjDEOwjAMAP-SGUVxY1rCyN43RI7tkgJKpKadEH9HlTrAene6t4m0rTluTZc4i7kaMKdfloifWnYhDyr3armWdZmT3RN72GbHKvq6He3fIFPL-9Yp-jOoF1CcCGhATs4JM10gTBCQ-oETBO6BO1RmhIHRcz9JEuzM5wvtbDhw:1qeeUA:OmOn-6gU0sgIUhEoFm5b5N2WJOk3cqn3c_cqN6Uoeto','2023-09-22 16:37:34.408000');
INSERT INTO "django_session" VALUES ('mlx2ilz9qz7ux3z36a03gmoaeqmpy1y8','e30:1rBYdC:Jd3KmLc4uQWiStfChjPBLMrEhYSUQiBoxWtVy9EtnOw','2023-12-22 11:02:54.020000');
INSERT INTO "django_session" VALUES ('r4k91c0itas3h4rnft18ocv5srtpjx3u','.eJxVjkEOwiAURO_C2pD2AwW6dO8ZCPC_FjVgoE00xrtrTRe6nfdmMk_m_DJPbmlUXUI2sp7tfrPg44XyCvDs86nwWPJcU-Crwjfa-KEgXfeb-zcw-TZ92oPpFfgjCYRoCcgAgACjyaoINvRaYiRLBjVqKwmVJfRKDEHIjkh-XzVqLZXs6H5L9cHG7vUGhrY_Kg:1rRpxr:ip7Kbu4M-Sh7Pf05AGTo2a0Nqv9hQ2P3lYjruLxSAWk','2024-02-05 08:47:31.476000');
INSERT INTO "django_session" VALUES ('tfyth96zrhai1ugv8szfvalw3oz210qo','.eJwtjEEKAjEQBL8y9DmGxeOeBJ-xWcIg4zLqJJLJwUX8uxE81KWq6Teyi7vWkuX11LZjngKyDcebOGYsS0LONx-Lv00INAU6DhLOtVy1GfdxQXIw1ge5lE69krNp41j0btzYTtuvxku1mLCu-HwBsw0rZA:1raY8x:D-XYGmohC87TpoCRtdy9Q7VWqP0XgUUeUib3bwLsVso','2024-02-29 09:34:59.488000');
INSERT INTO "django_session" VALUES ('u21onhxlftr4mvv0mfjnt25q2sgu0y0e','.eJxVjkEOgyAURO_CuiH6AQGX3fcMBPi_SttAI5q0Md69NXHjdt6byazMVao1lezo807Tl_XNhTm_zKNbKk0uIetZy05Z8PFJeQf48HkoPJY8TynwXeEHrfxWkF7Xwz0NjL6O_3ZnWgX-TgIhWgIyACDAaLIqgg2tlhjJkkGN2kpCZQm9El0QsiGS-6vgB9av2_YDSgJB9g:1rC4cJ:4-jd7Qh7a8MUYpiVOGVyI_kKlmFj4uF2l1aaWISYxUA','2023-12-23 21:12:07.498000');
INSERT INTO "django_session" VALUES ('vjq37gykbr7g2p8oejdlsvpv5c25hvo5','.eJxVjkEOwiAURO_C2pD2AwW6dO8ZCPC_FjVgoE00xrtrTRe6nfdmMk_m_DJPbmlUXUI2sp7tfrPg44XyCvDs86nwWPJcU-Crwjfa-KEgXfeb-zcw-TZ92oPpFfgjCYRoCcgAgACjyaoINvRaYiRLBjVqKwmVJfRKDEHIjkh-XzVqLZXs6H5L9cHG7vUGhrY_Kg:1rCckU:0QhBeRY3LsdpZlRkLk7Rx3fulT7LpAsrVaOGIkyVGTY','2023-12-25 09:38:50.005000');
INSERT INTO "django_session" VALUES ('w7dkt879oc1sqtc6bzsa98lxojbbu67z','.eJxVjkEOgyAURO_C2hD9goDL7nsGAvxfpW2gEU3aGO_e2rhot_PeTGZl1i3zaJdCk43Ietaw6jfzLtwo7QCvLg2Zh5zmKXq-K_yghZ8z0v10uH8Doyvjp93pRoK7UIsQDAFpAGhBKzIygPGNEhjIkEaFyghCaQidbDvfippIfF8VKiXmZOn5iNOL9XXFvBtYv27bG8nxQfY:1rT4GS:dCquCmS-vNNdux5mNQlyoiYKsFC1mT8J_Y2_GKaHkRE','2024-02-08 18:15:48.823000');
INSERT INTO "django_session" VALUES ('yrixw6gasqnka6ki4vhf02wc4i403ihc','.eJxVjjsOgzAQRO-yNbLitY0_ZfqcwbK9SyCJQMKQBnH3BIkiaee9Gc0GMa1LH9fKcxwIAkhofrOcypPHA9AjjfdJlGlc5iGLQxEnreI2Eb-up_s30Kfaf9utkwZTx4qweEZ2iKjQWfamoM_Sairs2ZEl6zWT8UzJqDYrfWHWx6ua3hyHsZsgLPPKDeR0h7CBQghy3z-FtkHx:1rRpzE:L0HqRyyik5HA61PSHC5ZLkYxAfdpTxx0B4d9--bbgoA','2024-02-05 08:48:56.007000');
INSERT INTO "django_session" VALUES ('162g1ve5lfadzbdedfa5e5any0g5n1nj','.eJxVjEsOwiAUAO_C2hA-Fh4u3fcMhPcAqRpISrsy3l1JutDtzGRezId9K37vafVLZBcm2emXYaBHqkPEe6i3xqnVbV2Qj4QftvO5xfS8Hu3foIRexlZSNGS0BoECJ7I2aiQI-uxyTkYqawAByYn8VcIRKJWETEpBnkAb9v4A3-03fA:1rgqOP:5zgutgqrWHkAYUKr0JuPHj2hVNyMfvhsQzhYobK-wfQ','2024-03-17 18:16:57.227384');
INSERT INTO "django_session" VALUES ('o50oe9q8vvtyhkiai57rnu15ghybdtni','.eJxVjEsOwiAUAO_C2hA-Fh4u3fcMhPcAqRpISrsy3l1JutDtzGRezId9K37vafVLZBcm2emXYaBHqkPEe6i3xqnVbV2Qj4QftvO5xfS8Hu3foIRexlZSNGS0BoECJ7I2aiQI-uxyTkYqawAByYn8VcIRKJWETEpBnkAb9v4A3-03fA:1rgr3E:HwARIezv_mWvLtNMmj7FPt_HdYQ74sBDgxsUWB_8z04','2024-03-17 18:59:08.588241');
INSERT INTO "django_session" VALUES ('ik7c9c82njd3e9e7u42xzvlqoxqf0bj7','.eJxVjMsOwiAURP-FtSE8Clxcuu83kMtLqgaS0q6M_y5NutDdZM6ZeROH-1bc3tPqlkiuhJPLb-cxPFM9QHxgvTcaWt3WxdNDoSftdG4xvW6n-3dQsJexnowQFqUGD1IyMELlYLjCKYAGmRVkZGxE7WGIOtsIjEUpuMUhcUk-X6UPNjQ:1rh6N8:5qe5j6bjLPqXEz690MO5lGWFibVYXk-UcdBLg1CJe0E','2024-03-18 11:20:42.710001');
INSERT INTO "django_site" VALUES (1,'Persian shop','persianshop.example.com');
INSERT INTO "blog_post" VALUES (1,'iphone 15','iphone-15','2024-03-03 18:54:43.137815','<p><span style="font-size: 36px;">this is the new iphone</span><span style="font-size: 36px;">﻿</span></p>','image/upload/v1709489817/j5vh0l2tlkxxoc9u3eyi.jpg','','2024-03-03 18:16:56.719062',1,1,1);
INSERT INTO "blog_post_likes" VALUES (1,1,1);
INSERT INTO "blog_comment" VALUES (1,'persian','mtnikmaram@gmail.com','salam','2024-03-03 18:58:54.267741',1,1);
INSERT INTO "blog_comment" VALUES (2,'persian','mtnikmaram@gmail.com','salam','2024-03-03 18:59:13.532504',0,1);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "account_emailconfirmation_email_address_id_5b7f8c58" ON "account_emailconfirmation" (
	"email_address_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "account_emailaddress_user_id_email_987c8728_uniq" ON "account_emailaddress" (
	"user_id",
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "unique_verified_email" ON "account_emailaddress" (
	"email"
) WHERE "verified";
CREATE INDEX IF NOT EXISTS "account_emailaddress_user_id_2c513194" ON "account_emailaddress" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "account_emailaddress_upper" ON "account_emailaddress" (
	(UPPER("email"))
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "checkout_orderlineitem_order_id_b4cfbe6b" ON "checkout_orderlineitem" (
	"order_id"
);
CREATE INDEX IF NOT EXISTS "checkout_orderlineitem_product_id_739c699d" ON "checkout_orderlineitem" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "checkout_order_user_profile_id_949184a7" ON "checkout_order" (
	"user_profile_id"
);
CREATE INDEX IF NOT EXISTS "products_product_category_id_9b594869" ON "products_product" (
	"category_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq" ON "socialaccount_socialapp_sites" (
	"socialapp_id",
	"site_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_socialapp_id_97fb6e7d" ON "socialaccount_socialapp_sites" (
	"socialapp_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_site_id_2579dee5" ON "socialaccount_socialapp_sites" (
	"site_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq" ON "socialaccount_socialtoken" (
	"app_id",
	"account_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_account_id_951f210e" ON "socialaccount_socialtoken" (
	"account_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_636a42d7" ON "socialaccount_socialtoken" (
	"app_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialaccount_provider_uid_fc810c6e_uniq" ON "socialaccount_socialaccount" (
	"provider",
	"uid"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialaccount_user_id_8146e70c" ON "socialaccount_socialaccount" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "blog_post_author_id_dd7a8485" ON "blog_post" (
	"author_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_post_likes_post_id_user_id_54f740f5_uniq" ON "blog_post_likes" (
	"post_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "blog_post_likes_post_id_d038881a" ON "blog_post_likes" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "blog_post_likes_user_id_bfe15394" ON "blog_post_likes" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "blog_comment_post_id_580e96ef" ON "blog_comment" (
	"post_id"
);
COMMIT;
