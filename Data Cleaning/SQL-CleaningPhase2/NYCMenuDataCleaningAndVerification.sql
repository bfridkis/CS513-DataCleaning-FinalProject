-- CS 513 Datat Cleaning Project - Summer 2025
-- Benjamin Fridkis, Samarth Patel, Kesavar Kabilar - Team 15
-- SQL Data Build and Verification

-- Turn on logging - Not needed unless running interactively... if running as a script set path when calling .sql file (see 'cmd-command-for-running-and-outputting-NYCMenuDataCleaningAndVerification.sql-to-logfile.txt' as an example).
-- SET GLOBAL general_log_file = "C:\Users\Annjamin\Documents\Benj's Stuff\UIUC MCS\CS513-TheoryAndPracticeOfDataCleaning\Project\Data Cleaning\SQL-CleaningPhase2\MySQL-Phase2-Cleaning.log";

-- Database Build and Load --

-- Drop database NYCMenu if needed
CREATE DATABASE IF NOT EXISTS NYCMenu;

USE NYCMenu;

-- Drop tables if they exists
DROP TABLE IF EXISTS `MenuDirty`;
DROP TABLE IF EXISTS `MenuClean`;
DROP TABLE IF EXISTS `MenuPageDirty`;
DROP TABLE IF EXISTS `MenuPageClean`;
DROP TABLE IF EXISTS `MenuItemDirty`;
DROP TABLE IF EXISTS `MenuItemClean`;
DROP TABLE IF EXISTS `DishDirty`;
DROP TABLE IF EXISTS `DishClean`;

-- Create new tables

-- If loading 'dirty' data for Menu...
-- CREATE TABLE MenuDirty ( id INT PRIMARY KEY, name VARCHAR(255), sponsor VARCHAR(255), event VARCHAR(255), venue VARCHAR(255), place VARCHAR(255), physical_description VARCHAR(255), occasion VARCHAR(255), notes VARCHAR(255), call_number VARCHAR(255), keywords VARCHAR(255), `language` VARCHAR(255), `date` VARCHAR(255), location VARCHAR(255), location_type VARCHAR(255), currency VARCHAR(255), currency_symbol VARCHAR(255), status VARCHAR(255), page_count INT, dish_count INT) ;
-- If loading 'clean' data for Menu...
CREATE TABLE MenuClean ( 
	id INT PRIMARY KEY, 
	sponsor VARCHAR(255), 
	event VARCHAR(255), 
	venue VARCHAR(255), 
	place VARCHAR(255), 
	physical_description VARCHAR(255), 
	occasion VARCHAR(255), 
	notes VARCHAR(255), 
	call_number VARCHAR(255), 
	`date` VARCHAR(255), 
	location VARCHAR(255), 
	currency VARCHAR(255), 
	currency_symbol VARCHAR(255), 
	status VARCHAR(255), 
	page_count INT, 
	dish_count INT
);

-- If loading 'dirty' data for MenuPage...
-- CREATE TABLE MenuPageDirty ( id INT PRIMARY KEY, menu_id INT, page_number INT, image_id VARCHAR(255), full_height VARCHAR(255), full_width VARCHAR(255), uuid VARCHAR(255));
-- If loading 'clean' data for Menu...
CREATE TABLE MenuPageClean ( 
	id INT PRIMARY KEY, 
	menu_id INT, 
	page_number INT, 
	image_id VARCHAR(255), 
	full_height INT, 
	full_width INT, 
	placeholder INT
);

-- If loading 'dirty' data for MenuItem...
-- CREATE TABLE MenuItemDirty ( id INT PRIMARY KEY, menu_page_id INT, price DECIMAL(10,4), high_price DECIMAL(10,4), dish_id INT, created_at VARCHAR(255), updated_at VARCHAR(255), xpos VARCHAR(12), ypos VARCHAR(12));
-- If loading 'clean' data for MenuItem...
CREATE TABLE MenuItemClean ( 
	id INT PRIMARY KEY, 
	menu_page_id INT, 
	price DECIMAL(10,4), 
	dish_id INT, 
	created_at DATETIME, 
	updated_at DATETIME, 
	xpos VARCHAR(12), 
	ypos VARCHAR(12)
);

-- If loading 'dirty' data for Dish...
-- CREATE TABLE DishDirty ( id INT PRIMARY KEY, name VARCHAR(2048), description VARCHAR(255), menus_appeared INT, times_appeared INT, first_appeared INT, last_appeared INT, lowest_price DECIMAL(10,4), highest_price DECIMAL(10,4), placeholder INT);
-- If loading 'clean' data for MenuItem...
CREATE TABLE DishClean ( 
	id INT PRIMARY KEY, 
	name VARCHAR(2048), 
	menus_appeared INT, 
	times_appeared INT, 
	first_appeared INT, 
	last_appeared INT, 
	lowest_price DECIMAL(10,4), 
	highest_price DECIMAL(10,4), 
	placeholder INT
);

-- Load data from Menu.csv (Dirty)
/* LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Menu.csv"
INTO TABLE MenuDirty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; */

-- Load data from Menu_clean.csv (Clean)
LOAD DATA INFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/OpenRefine-CleaningPhase1/Menu_clean-Phase1-OpenRefine_PartiallyCleaned.csv"
INTO TABLE MenuClean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load data from MenuPage.csv (Dirty)
/* LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MenuPage.csv"
INTO TABLE MenuPageDirty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, menu_id, @vpage_number, image_id, @vfull_height, @vfull_width, uuid)
SET
page_number = NULLIF(@vpage_number, ''),
full_height = NULLIF(@vfull_height, ''),
full_width = NULLIF(@vfull_width, '')
; */


-- Load data from MenuPage_clean.csv (Clean)
-- Couldn't get this to work for full_width column as INT in the last column position, hence why column 'placeholder' was added then dropped after import...
LOAD DATA INFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/OpenRefine-CleaningPhase1/MenuPage_clean-Phase1-OpenRefine_PartiallyCleaned.csv"
INTO TABLE MenuPageClean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, menu_id, @vpage_number, image_id, @vfull_height, @vfull_width, placeholder)
SET
page_number = NULLIF(@vpage_number, ''),
full_height = NULLIF(@vfull_height, ''),
full_width = NULLIF(@vfull_width, '')
;
ALTER TABLE MenuPageClean DROP COLUMN placeholder;

-- Load data from MenuItem.csv (Dirty)
/* LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MenuItem.csv"
INTO TABLE MenuItemDirty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, menu_page_id, @vprice, @vhigh_price, @vdish_id, created_at, updated_at, xpos, ypos)
SET
price = NULLIF(@vprice, ''),
high_price = NULLIF(@vhigh_price, ''),
dish_id = NULLIF(@vdish_id, '')
; */

-- Load data from MenuItem_clean.csv (Clean)
LOAD DATA INFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/OpenRefine-CleaningPhase1/MenuItem_clean-Phase1-OpenRefine_PartiallyCleaned.csv"
INTO TABLE MenuItemClean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load data from Dish.csv (Dirty)
-- Couldn't get this to work for highest_price column as DECIMAL in the last column position, hence why column 'placeholder' was added then dropped after import...
/* LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Dish.csv"
INTO TABLE DishDirty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, description, @vmenus_appeared, times_appeared, first_appeared, last_appeared, @vlowest_price, @vhighest_price, placeholder)
SET
lowest_price = NULLIF(@vmenus_appeared, ''),
lowest_price = NULLIF(@vlowest_price, ''),
highest_price = NULLIF(@vhighest_price, '')
;
ALTER TABLE DishDirty DROP COLUMN placeholder; */

-- Load data from Dish_clean.csv (Clean)
-- Couldn't get this to work for highest_price column as DECIMAL in the last column position, hence why column 'placeholder' was added then dropped after import...
LOAD DATA INFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/OpenRefine-CleaningPhase1/Dish_clean-Phase1-OpenRefine_PartiallyCleaned.csv"
INTO TABLE DishClean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, menus_appeared, times_appeared, first_appeared, last_appeared, @vlowest_price, @vhighest_price, placeholder)
SET
lowest_price = NULLIF(@vlowest_price, ''),
highest_price = NULLIF(@vhighest_price, '')
;
ALTER TABLE DishClean DROP COLUMN placeholder;

-- Data Integrity Violation Checks --

-- Record count of MenuPage instances that do not have a valid Menu_Id
SELECT COUNT(*) FROM MenuPageClean WHERE menu_id NOT IN (SELECT id FROM MenuClean);

-- Remove all MenuPage instances without a valid menu_id
DELETE FROM MenuPageClean WHERE id IN (SELECT id FROM (SELECT id FROM MenuPageClean WHERE menu_id NOT IN (SELECT id FROM MenuClean)) AS derived);

-- Check that all MenuPage instances now have a valid Menu_id reference (clean) -- Should be 0
SELECT COUNT(*) FROM MenuPageClean WHERE menu_id NOT IN (SELECT id FROM MenuClean);

-- Record count of MenuItem instances that do not have a valid Menu_Page_Id
SELECT COUNT(*) FROM MenuItemClean WHERE menu_page_id NOT IN (SELECT id FROM MenuPageClean);

-- Remove all MenuItem instances without a valid menu_id
DELETE FROM MenuItemClean WHERE id IN (SELECT id FROM (SELECT id FROM MenuItemClean WHERE menu_page_id NOT IN (SELECT id FROM MenuPageClean)) AS derived);

-- Check that all MenuItem instances now have a valid  Menu_id reference (clean) -- Should be 0
SELECT COUNT(*) FROM MenuItemClean WHERE menu_page_id NOT IN (SELECT id FROM MenuPageClean);

-- Record count of MenuItem instances that do not have a valid Dish_Id
SELECT COUNT(*) FROM MenuItemClean WHERE dish_id NOT IN (SELECT id FROM DishClean);

-- Remove all MenuItem instances without a valid dish_id
DELETE FROM MenuItemClean WHERE id IN (SELECT id FROM (SELECT id FROM MenuItemClean WHERE dish_id NOT IN (SELECT id FROM DishClean)) AS derived);

-- Check that all MenuItem instances now have a valid dish_id reference (clean) -- Should be 0
SELECT COUNT(*) FROM MenuItemClean WHERE dish_id NOT IN (SELECT id FROM DishClean);

-- Identify count of Dishes with no corresponding MenuItem (Reference only... these do not need to be deleted as a future MenuItem could be added to correspond to a dish)
-- SELECT COUNT(*) FROM DishClean WHERE id NOT IN (SELECT DISTINCT dish_id FROM MenuItemClean);

-- Identify incorrect lowest_price fields in Dish via referencing the MenuItem table
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.lowest_price, MIN(mi.price) FROM dishclean AS dishclean 
	JOIN menuitemclean AS mi ON dishclean.id = mi.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.lowest_price <> MIN(mi.price)
) AS Inaccurate_Lowest_Price;

-- Update incorrect lowest_price fields in Dish via referencing the MenuItem table
UPDATE DishClean
JOIN (
	SELECT dishclean.id AS id, dishclean.lowest_price, MIN(mi.price) AS true_lowest_price FROM dishclean AS dishclean 
	JOIN menuitemclean AS mi ON dishclean.id = mi.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.lowest_price <> MIN(mi.price)
) AS Inaccurate_Lowest_Price ON DishClean.id = Inaccurate_Lowest_Price.id
SET 
DishClean.lowest_price = Inaccurate_Lowest_Price.true_lowest_price;

-- Verify there are now no incorrect lowest_price values in Dish -- Count should be 0
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.lowest_price, MIN(menuitemclean.price) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.lowest_price <> MIN(menuitemclean.price)
) AS Inaccurate_Lowest_Price;

-- Identify incorrect highest_price fields in Dish via referencing the MenuItem table
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.highest_price, MAX(menuitemclean.price) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.highest_price <> MAX(menuitemclean.price)
) AS Inaccurate_Highest_Price;

-- Update incorrect highest_price fields in Dish via referencing the MenuItem table
UPDATE DishClean
JOIN (
	SELECT dishclean.id AS id, dishclean.highest_price, MAX(menuitemclean.price) AS true_highest_price FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.highest_price <> MAX(menuitemclean.price)
) AS Inaccurate_Highest_Price ON DishClean.id = Inaccurate_Highest_Price.id
SET 
DishClean.highest_price = Inaccurate_Highest_Price.true_highest_price;

-- Verify there are now no incorrect highest_price values in Dish -- Count should be 0
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.highest_price, MAX(menuitemclean.price) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.highest_price <> MAX(menuitemclean.price)
) AS Inaccurate_Highest_Price;

-- Identify incorrect menus_appeared fields in Dish via referencing the MenuItem and MenuPage tables
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.menus_appeared, COUNT(DISTINCT menupageclean.menu_id) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	JOIN menupageclean ON menuitemclean.menu_page_id = menupageclean.id
	GROUP BY dishclean.id 
	HAVING dishclean.menus_appeared <> COUNT(DISTINCT menupageclean.menu_id)
) AS Inaccurate_Menus_Appeared;

-- Update incorrect menus_appeared fields in Dish via referencing the MenuItem and MenuPage tables
UPDATE DishClean
JOIN (
	SELECT dishclean.id AS id, dishclean.menus_appeared, COUNT(DISTINCT menupageclean.menu_id) AS true_menus_appeared FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	JOIN menupageclean ON menuitemclean.menu_page_id = menupageclean.id
	GROUP BY dishclean.id 
	HAVING dishclean.menus_appeared <> COUNT(DISTINCT menupageclean.menu_id)
) AS Inaccurate_Menus_Appeared ON DishClean.id = Inaccurate_Menus_Appeared.id
SET 
DishClean.menus_appeared = Inaccurate_Menus_Appeared.true_menus_appeared;

-- Verify there are now no incorrect menus_appeared values in Dish -- Count should be 0
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.menus_appeared, COUNT(DISTINCT menupageclean.menu_id) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	JOIN menupageclean ON menuitemclean.menu_page_id = menupageclean.id
	GROUP BY dishclean.id 
	HAVING dishclean.menus_appeared <> COUNT(DISTINCT menupageclean.menu_id)
) AS Inaccurate_Menus_Appeared;

-- Identify incorrect times_appeared fields in Dish via referencing the MenuItem
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.times_appeared, COUNT(menuitemclean.id) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.times_appeared <> COUNT(menuitemclean.id)
) AS Inaccurate_Times_Appeared;

-- Update incorrect times_appeared fields in Dish via referencing the MenuItem and MenuPage tables
UPDATE DishClean
JOIN (
	SELECT dishclean.id AS id, dishclean.times_appeared, COUNT(menuitemclean.id) as true_times_appeared FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.times_appeared <> COUNT(menuitemclean.id)
) AS Inaccurate_Times_Appeared ON DishClean.id = Inaccurate_Times_Appeared.id
SET 
DishClean.times_appeared = Inaccurate_Times_Appeared.true_times_appeared;

-- Verify there are now no incorrect times_appeared values in Dish -- Count should be 0
SELECT COUNT(*) FROM 
(
	SELECT dishclean.id, dishclean.name, dishclean.times_appeared, COUNT(menuitemclean.id) FROM dishclean AS dishclean 
	JOIN menuitemclean ON dishclean.id = menuitemclean.dish_id 
	GROUP BY dishclean.id 
	HAVING dishclean.times_appeared <> COUNT(menuitemclean.id)
) AS Inaccurate_Times_Appeared;

-- Select final cleaned Menu table into a file
SELECT 'id','sponsor','event','venue','place','physical_description','occasion','notes','call_number','date','location','currency','currency_symbol','status','page_count','dish_count'
UNION ALL
SELECT *
FROM MenuClean
INTO OUTFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/SQL-CleaningPhase2/Output/Menu_clean-Phase2-SQL_FullyCleaned.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Select final cleaned MenuPage table into a file
SELECT 'id','menu_id','page_number','image_id','full_height','full_width'
UNION ALL
SELECT *
FROM MenuPageClean
INTO OUTFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/SQL-CleaningPhase2/Output/MenuPage_clean-Phase2-SQL_FullyCleaned.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Select final cleaned MenuPage table into a file
SELECT 'id','menu_page_id','price','dish_id','created_at','updated_at','xpos','ypos'
UNION ALL
SELECT *
FROM MenuItemClean
INTO OUTFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/SQL-CleaningPhase2/Output/MenuItem_clean-Phase2-SQL_FullyCleaned.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Select final cleaned Dish table into a file
SELECT 'id','name','menus_appeared','times_appeared','first_appeared','last_appeared','lowest_price','highest_price'
UNION ALL
SELECT *
FROM DishClean
INTO OUTFILE "C:/Users/Annjamin/Documents/Benj's Stuff/UIUC MCS/CS513-TheoryAndPracticeOfDataCleaning/Project/Data Cleaning/SQL-CleaningPhase2/Output/Dish_clean-Phase2-SQL_FullyCleaned.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- REFERENCES
-- https://stackoverflow.com/questions/2675323/mysql-load-null-values-from-csv-data
-- https://www.google.com/search?q=is+there+a+way+to+record+all+MySQL+terminal+based+output+to+a+file&rlz=1C1CHBF_enUS1071US1071&oq=is+there+a+way+to+record+all+MySQL+terminal+based+output+to+a+file&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigAdIBCTEwMzU4ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8