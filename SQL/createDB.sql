-- // 
-- 		YOU NEED THIS TO USE IN PSQL: \i Documents/teamProject/createDB.sql (path to the file)
-- \\


-- start from scratch
drop database if exists net_worth_db;


--- create database
create database net_worth_db;

-- make sure we are in database 
\c net_worth_db;

-- drop tables
drop table if exists itemsEntered;
drop table if exists netWorthInfo;
drop table if exists userInfo;

-- itemsEntered: DT used to store assets and liabilities when they are entered from the networth add page on app
-- itemID = primary key that is unique to each entry
-- userID = foreign key used to connect to user
-- name = asset/liability name i.e. "car"
-- category = selected category that asset/liability belongs to (user picks from drop down of options)
-- type = 1 or 0. 0 indicates it is an liability. 1 indicates it is an asset
-- amout = $ value of asset of liability
CREATE Table If not exists itemsEntered (
	itemID INT NOT NULL PRIMARY KEY,
	userID INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	category VARCHAR(255) NOT NULL,
	type INT NOT NULL,
	amount FLOAT NOT NULL

);

--  netWorthInfo: used to store total networth of each user
-- userID = connects the user to their net worth
-- totalAssets = keeps tracks of total assets as things are added/removed
-- totalLiabilities = keeps tracks of total liabilities as things are added/removed
-- netWorth = total assets - total liabilities
CREATE TABLE IF NOT EXISTS netWorthInfo (
	userID INT NOT NULL,
	totalAssets FLOAT DEFAULT 0,
	totalLiabilities FLOAT DEFAULT 0,
	netWorth FLOAT DEFAULT 0
);

-- userInfo: DT to store user info that is gathered when they create an account
-- the rest is self explanatory. Nothing can be missing 
CREATE TABLE IF NOT EXISTS userInfo (
	userID INT NOT NULL PRIMARY KEY,
	firstName VARCHAR(45) NOT NULL,
	lastName VARCHAR(45) NOT NULL,
	username VARCHAR(45) NOT NULL,
	password VARCHAR(45) NOT NULL,
	email VARCHAR(45) NOT NULL
);

-- // -----------------------------------------------------------------------------------------------------
-- INSERT SAMPLE DATA BELOW:
-- // -----------------------------------------------------------------------------------------------------

-- SAMPLE DATA INCLUDES 50 users:
insert into userInfo (userID, firstName, lastName, username, password, email) values (1, 'Jacquenetta', 'Hagger', 'jhagger0', '2nVnxeVrk4', 'jhagger0@home.pl');
insert into userInfo (userID, firstName, lastName, username, password, email) values (2, 'Ive', 'Wishart', 'iwishart1', '5wj3xil', 'iwishart1@google.nl');
insert into userInfo (userID, firstName, lastName, username, password, email) values (3, 'Kenton', 'Middell', 'kmiddell2', 'QoAHKI', 'kmiddell2@ocn.ne.jp');
insert into userInfo (userID, firstName, lastName, username, password, email) values (4, 'Aindrea', 'Wanderschek', 'awanderschek3', 'xAdnGE', 'awanderschek3@i2i.jp');
insert into userInfo (userID, firstName, lastName, username, password, email) values (5, 'Augustine', 'Feldstein', 'afeldstein4', '0S3Iu1G', 'afeldstein4@nytimes.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (6, 'Beryl', 'Dammarell', 'bdammarell5', '0aPNOQczmkB', 'bdammarell5@liveinternet.ru');
insert into userInfo (userID, firstName, lastName, username, password, email) values (7, 'Corinne', 'Brickstock', 'cbrickstock6', 'nM32vWO3r0M', 'cbrickstock6@mlb.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (8, 'Rita', 'Whiting', 'rwhiting7', 'F5xuoTVM', 'rwhiting7@myspace.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (9, 'Ana', 'Caville', 'acaville8', 'gkilQgLIf', 'acaville8@digg.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (10, 'Kelsi', 'Fibbings', 'kfibbings9', 'ENARjDKYsY', 'kfibbings9@wired.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (11, 'Corey', 'Cromie', 'ccromiea', 'ra0tndUHnFt9', 'ccromiea@independent.co.uk');
insert into userInfo (userID, firstName, lastName, username, password, email) values (12, 'Linc', 'Beggin', 'lbegginb', 'Y8xi68bLEa', 'lbegginb@hao123.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (13, 'Cosmo', 'Beswick', 'cbeswickc', 'qiQ7UcCV3', 'cbeswickc@theatlantic.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (14, 'Nicolle', 'Largent', 'nlargentd', '8vxSpogRpd7L', 'nlargentd@wikipedia.org');
insert into userInfo (userID, firstName, lastName, username, password, email) values (15, 'Benson', 'Redmayne', 'bredmaynee', 'WCi3G9wVijE', 'bredmaynee@trellian.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (16, 'Gayler', 'Smeuin', 'gsmeuinf', 'mbiqh07Yu', 'gsmeuinf@timesonline.co.uk');
insert into userInfo (userID, firstName, lastName, username, password, email) values (17, 'Maxine', 'Bownde', 'mbowndeg', 'duJ66edFrnpd', 'mbowndeg@columbia.edu');
insert into userInfo (userID, firstName, lastName, username, password, email) values (18, 'Elsa', 'Hanington', 'ehaningtonh', '9JMr77YleV', 'ehaningtonh@tinypic.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (19, 'Ophelie', 'Heckle', 'ohecklei', 'MSIUQcVpCPOm', 'ohecklei@hp.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (20, 'Malachi', 'Davage', 'mdavagej', 'NwZkpzXbv', 'mdavagej@tripadvisor.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (21, 'Pablo', 'Weymouth', 'pweymouthk', 'G8vJzso', 'pweymouthk@aol.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (22, 'Ciro', 'Revely', 'crevelyl', 'kbiuqjk9ghRt', 'crevelyl@netvibes.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (23, 'Archaimbaud', 'Littleproud', 'alittleproudm', 'dleT2jRqx', 'alittleproudm@mail.ru');
insert into userInfo (userID, firstName, lastName, username, password, email) values (24, 'Maribeth', 'Overbury', 'moverburyn', 'aqPjmzvT7', 'moverburyn@buzzfeed.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (25, 'Edwina', 'Braden', 'ebradeno', 'Md2vE9N', 'ebradeno@geocities.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (26, 'Ibby', 'De Hooch', 'idehoochp', 'IlAHIBRUN9', 'idehoochp@trellian.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (27, 'Reena', 'Whitehorne', 'rwhitehorneq', 'u1BegVYa', 'rwhitehorneq@foxnews.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (28, 'Lazarus', 'Gilbride', 'lgilbrider', 'NDYTUGbmA', 'lgilbrider@google.fr');
insert into userInfo (userID, firstName, lastName, username, password, email) values (29, 'Goldie', 'Simm', 'gsimms', 'aNjK1Sjed84b', 'gsimms@deliciousdays.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (30, 'Mile', 'Scanderet', 'mscanderett', 'yMo0pY9rHGE0', 'mscanderett@lycos.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (31, 'Mallory', 'Mallatratt', 'mmallatrattu', 'WkvP8dYsdw', 'mmallatrattu@apple.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (32, 'Clarissa', 'Hixley', 'chixleyv', 'RovhX2LYc', 'chixleyv@opensource.org');
insert into userInfo (userID, firstName, lastName, username, password, email) values (33, 'Imogene', 'Fackney', 'ifackneyw', 'AbFTa32Mh', 'ifackneyw@newyorker.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (34, 'Nathan', 'Krop', 'nkropx', 'NFXPNByspTK8', 'nkropx@mashable.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (35, 'Pauline', 'Byrkmyr', 'pbyrkmyry', 'iCcOkPe', 'pbyrkmyry@comcast.net');
insert into userInfo (userID, firstName, lastName, username, password, email) values (36, 'Nerita', 'Haliburton', 'nhaliburtonz', 'O721s8FE4p', 'nhaliburtonz@tmall.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (37, 'Yvon', 'Arton', 'yarton10', 'xGv3QvnZ', 'yarton10@springer.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (38, 'Merrick', 'Antwis', 'mantwis11', 'vYVVwbzw', 'mantwis11@seattletimes.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (39, 'Heinrick', 'Walling', 'hwalling12', 'Wx5H6fI', 'hwalling12@sciencedaily.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (40, 'Anderea', 'Sebright', 'asebright13', 'Usl6Pm4cm', 'asebright13@dyndns.org');
insert into userInfo (userID, firstName, lastName, username, password, email) values (41, 'Merissa', 'Arminger', 'marminger14', 'tuErULqS0Ac', 'marminger14@lulu.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (42, 'Saw', 'Boakes', 'sboakes15', 'r0787iO', 'sboakes15@loc.gov');
insert into userInfo (userID, firstName, lastName, username, password, email) values (43, 'Lacy', 'Golden of Ireland', 'lgoldenofireland16', 'nI7X4asJB8', 'lgoldenofireland16@youtube.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (44, 'Dallas', 'Shipp', 'dshipp17', 'MKgzA24Ff', 'dshipp17@artisteer.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (45, 'Loretta', 'Milmore', 'lmilmore18', 'XDCqFjq2', 'lmilmore18@gnu.org');
insert into userInfo (userID, firstName, lastName, username, password, email) values (46, 'Otho', 'Tschursch', 'otschursch19', 'lutXox', 'otschursch19@nbcnews.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (47, 'Starla', 'Laister', 'slaister1a', 'xWjcvpd5M', 'slaister1a@pagesperso-orange.fr');
insert into userInfo (userID, firstName, lastName, username, password, email) values (48, 'Annabela', 'Brimblecomb', 'abrimblecomb1b', 'wRnuxyY3Mwf', 'abrimblecomb1b@pagesperso-orange.fr');
insert into userInfo (userID, firstName, lastName, username, password, email) values (49, 'Salvidor', 'Montford', 'smontford1c', '8f7jYp', 'smontford1c@wufoo.com');
insert into userInfo (userID, firstName, lastName, username, password, email) values (50, 'Celene', 'Biggen', 'cbiggen1d', 'fhl8McrS1kGR', 'cbiggen1d@nasa.gov');


-- INITIALIZE NETWEORTH INFO TO $0.00 FOR ALL USERS:
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (1, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (2, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (3, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (4, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (5, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (6, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (7, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (8, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (9, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (10, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (11, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (12, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (13, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (14, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (15, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (16, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (17, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (18, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (19, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (20, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (21, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (22, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (23, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (24, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (25, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (26, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (27, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (28, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (29, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (30, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (31, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (32, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (33, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (34, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (35, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (36, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (37, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (38, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (39, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (40, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (41, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (42, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (43, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (44, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (45, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (46, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (47, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (48, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (49, 0.0, 0.0, 0.0);
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values (50, 0.0, 0.0, 0.0);

-- SAMPLE DATA FOR ITEMS ENTERED
insert into itemsEntered (itemID, userID, name, category, type, amount) values (1, 23, 'tincidunt', 'Sports', 1, 7252.82);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (2, 38, 'vel accumsan', 'Baby', 0, 426237.69);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (3, 22, 'lectus in', 'Outdoors', 1, 619711.8);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (4, 9, 'consequat morbi', 'Games', 1, 250455.36);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (5, 3, 'sapien', 'Health', 0, 767288.28);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (6, 7, 'dolor sit amet', 'Baby', 0, 926211.04);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (7, 45, 'venenatis', 'Industrial', 0, 212041.83);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (8, 1, 'at nibh in', 'Shoes', 0, 952942.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (9, 48, 'vulputate elementum nullam', 'Outdoors', 1, 446664.07);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (10, 23, 'faucibus accumsan odio', 'Health', 0, 653680.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (11, 50, 'orci luctus et', 'Grocery', 0, 501129.69);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (12, 33, 'bibendum imperdiet nullam', 'Automotive', 1, 853880.87);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (13, 31, 'ante vestibulum ante', 'Sports', 1, 587228.1);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (14, 7, 'eget tincidunt', 'Health', 0, 539440.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (15, 35, 'sapien ut nunc', 'Shoes', 0, 29610.32);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (16, 38, 'aliquet', 'Sports', 0, 656089.11);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (17, 32, 'tempor turpis nec', 'Toys', 1, 53.38);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (18, 45, 'vel sem', 'Music', 0, 248633.79);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (19, 32, 'felis fusce', 'Industrial', 0, 441838.33);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (20, 5, 'consequat varius integer', 'Music', 1, 850072.37);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (21, 35, 'luctus', 'Shoes', 0, 259405.12);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (22, 26, 'tortor id', 'Outdoors', 1, 50265.13);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (23, 3, 'in', 'Home', 1, 512937.38);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (24, 18, 'sodales sed tincidunt', 'Electronics', 1, 129953.48);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (25, 16, 'habitasse platea', 'Garden', 0, 635695.13);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (26, 22, 'eu', 'Electronics', 0, 613469.51);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (27, 39, 'eget elit', 'Clothing', 0, 606241.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (28, 50, 'lectus', 'Shoes', 1, 873847.75);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (29, 18, 'nisl nunc nisl', 'Grocery', 1, 989574.72);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (30, 31, 'suspendisse potenti', 'Tools', 1, 800443.63);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (31, 30, 'at', 'Industrial', 1, 189898.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (32, 27, 'lorem integer tincidunt', 'Movies', 1, 72197.32);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (33, 6, 'ipsum', 'Clothing', 1, 767596.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (34, 18, 'eros suspendisse accumsan', 'Outdoors', 0, 764417.51);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (35, 21, 'sem', 'Shoes', 1, 832052.45);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (36, 24, 'metus arcu', 'Home', 0, 350299.44);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (37, 48, 'velit vivamus', 'Beauty', 1, 643075.35);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (38, 36, 'quis orci', 'Electronics', 1, 167618.45);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (39, 23, 'magna', 'Movies', 1, 618323.7);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (40, 18, 'nullam orci pede', 'Sports', 0, 900163.43);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (41, 30, 'mauris', 'Movies', 1, 474613.07);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (42, 39, 'iaculis', 'Music', 0, 998327.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (43, 45, 'in sagittis', 'Health', 1, 750035.18);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (44, 18, 'nec condimentum neque', 'Outdoors', 0, 456689.06);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (45, 32, 'eu massa donec', 'Sports', 0, 536350.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (46, 27, 'pellentesque eget nunc', 'Home', 1, 400520.08);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (47, 17, 'porttitor', 'Computers', 0, 426200.51);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (48, 32, 'eget nunc donec', 'Automotive', 0, 344329.1);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (49, 24, 'laoreet ut rhoncus', 'Shoes', 1, 822285.16);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (50, 8, 'porta volutpat', 'Sports', 1, 851394.39);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (51, 8, 'nulla elit', 'Shoes', 0, 600760.6);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (52, 10, 'nulla', 'Clothing', 1, 442273.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (53, 5, 'odio donec vitae', 'Clothing', 0, 924754.57);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (54, 9, 'ante vivamus', 'Health', 0, 338238.93);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (55, 21, 'scelerisque', 'Tools', 1, 440131.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (56, 22, 'nisl', 'Games', 1, 231701.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (57, 29, 'non ligula', 'Clothing', 0, 10767.08);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (58, 22, 'erat', 'Baby', 0, 911604.35);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (59, 48, 'amet sapien dignissim', 'Home', 0, 386492.81);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (60, 24, 'bibendum felis', 'Toys', 1, 524532.47);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (61, 10, 'est', 'Outdoors', 0, 53194.36);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (62, 4, 'suscipit nulla elit', 'Tools', 0, 628172.91);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (63, 5, 'interdum in', 'Garden', 0, 754457.75);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (64, 12, 'cras non velit', 'Clothing', 0, 748344.37);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (65, 37, 'montes nascetur ridiculus', 'Baby', 0, 49728.13);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (66, 19, 'sapien urna pretium', 'Industrial', 1, 638740.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (67, 44, 'eget', 'Books', 1, 71796.91);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (68, 9, 'quam fringilla rhoncus', 'Jewelery', 0, 260952.54);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (69, 40, 'est et', 'Baby', 1, 439161.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (70, 38, 'ultrices', 'Computers', 0, 173980.23);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (71, 34, 'libero', 'Health', 0, 198900.85);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (72, 48, 'euismod', 'Books', 1, 873588.5);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (73, 34, 'ante ipsum primis', 'Beauty', 0, 474582.24);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (74, 15, 'justo in blandit', 'Tools', 0, 765399.82);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (75, 7, 'nam', 'Toys', 0, 313688.6);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (76, 40, 'lorem', 'Electronics', 1, 956162.34);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (77, 43, 'in', 'Sports', 0, 247032.2);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (78, 34, 'viverra', 'Kids', 1, 470199.22);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (79, 15, 'risus praesent', 'Clothing', 0, 994254.81);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (80, 13, 'sed augue', 'Books', 0, 331909.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (81, 46, 'nulla nunc purus', 'Garden', 1, 726358.76);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (82, 9, 'cras in purus', 'Health', 0, 204106.82);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (83, 28, 'magnis', 'Automotive', 1, 778901.58);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (84, 28, 'varius ut blandit', 'Shoes', 1, 729053.99);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (85, 38, 'justo morbi', 'Baby', 1, 86430.28);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (86, 25, 'volutpat', 'Home', 0, 688451.99);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (87, 33, 'dui', 'Games', 1, 822037.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (88, 13, 'ligula vehicula', 'Kids', 0, 476721.22);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (89, 5, 'sit amet erat', 'Beauty', 0, 39574.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (90, 50, 'eu sapien', 'Toys', 1, 624254.65);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (91, 41, 'est', 'Kids', 1, 278475.37);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (92, 33, 'morbi ut', 'Movies', 0, 344626.82);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (93, 32, 'duis consequat', 'Movies', 0, 45266.91);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (94, 43, 'sit amet', 'Computers', 0, 227616.48);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (95, 35, 'vulputate', 'Tools', 0, 811567.06);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (96, 2, 'platea dictumst', 'Baby', 1, 352668.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (97, 24, 'augue a suscipit', 'Home', 0, 777762.47);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (98, 23, 'convallis eget', 'Computers', 0, 226539.19);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (99, 37, 'pretium', 'Clothing', 0, 281773.65);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (100, 31, 'lectus pellentesque at', 'Outdoors', 0, 876365.19);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (101, 14, 'id', 'Baby', 1, 169958.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (102, 33, 'vitae', 'Computers', 0, 209210.73);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (103, 7, 'interdum', 'Jewelery', 0, 758464.64);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (104, 50, 'pretium quis', 'Clothing', 0, 260523.05);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (105, 30, 'lobortis vel', 'Books', 0, 65167.04);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (106, 22, 'gravida sem praesent', 'Outdoors', 0, 849526.24);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (107, 13, 'consequat nulla', 'Games', 1, 188576.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (108, 1, 'curae duis faucibus', 'Computers', 1, 759704.94);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (109, 25, 'orci pede venenatis', 'Electronics', 1, 856807.73);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (110, 22, 'praesent lectus', 'Shoes', 1, 526637.05);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (111, 19, 'eros vestibulum', 'Toys', 1, 923834.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (112, 22, 'ut', 'Automotive', 1, 175854.12);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (113, 18, 'phasellus', 'Sports', 1, 156276.5);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (114, 31, 'posuere', 'Shoes', 1, 450019.76);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (115, 26, 'ultrices aliquet maecenas', 'Outdoors', 1, 872324.33);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (116, 10, 'eget congue', 'Kids', 0, 279839.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (117, 36, 'cursus', 'Industrial', 0, 355005.18);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (118, 50, 'dui vel', 'Outdoors', 1, 672891.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (119, 40, 'eget elit sodales', 'Outdoors', 0, 419431.67);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (120, 8, 'ac', 'Beauty', 1, 810911.12);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (121, 24, 'amet turpis', 'Baby', 1, 690971.46);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (122, 13, 'in', 'Garden', 0, 20146.7);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (123, 32, 'aliquet', 'Tools', 1, 695022.18);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (124, 22, 'eu orci mauris', 'Music', 1, 301746.65);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (125, 6, 'pharetra magna', 'Sports', 1, 878733.56);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (126, 11, 'quis turpis', 'Computers', 0, 779351.42);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (127, 43, 'ipsum', 'Health', 0, 575389.61);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (128, 6, 'scelerisque mauris sit', 'Sports', 0, 631417.54);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (129, 16, 'turpis', 'Home', 0, 180601.15);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (130, 7, 'venenatis', 'Movies', 0, 246214.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (131, 5, 'quisque', 'Computers', 0, 241943.61);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (132, 18, 'vestibulum', 'Sports', 0, 958782.46);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (133, 5, 'vel', 'Jewelery', 0, 151350.67);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (134, 5, 'magnis dis parturient', 'Clothing', 1, 298749.89);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (135, 26, 'neque', 'Movies', 0, 734421.13);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (136, 10, 'dictumst etiam faucibus', 'Shoes', 0, 758312.08);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (137, 50, 'donec vitae nisi', 'Shoes', 1, 142358.62);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (138, 39, 'tristique in', 'Kids', 1, 460454.84);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (139, 43, 'ligula suspendisse', 'Movies', 0, 526252.99);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (140, 26, 'vel', 'Outdoors', 0, 440563.84);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (141, 7, 'lobortis', 'Grocery', 0, 631207.99);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (142, 40, 'est', 'Garden', 1, 176215.25);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (143, 10, 'mauris', 'Electronics', 0, 34529.43);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (144, 11, 'quam', 'Industrial', 0, 689563.05);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (145, 32, 'laoreet', 'Toys', 1, 21481.58);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (146, 35, 'cursus urna ut', 'Industrial', 0, 831559.03);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (147, 28, 'integer non', 'Kids', 0, 631891.73);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (148, 23, 'penatibus et magnis', 'Sports', 0, 710372.72);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (149, 29, 'pede posuere', 'Jewelery', 1, 836366.3);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (150, 46, 'augue quam sollicitudin', 'Industrial', 0, 187352.17);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (151, 16, 'sollicitudin', 'Clothing', 1, 831047.89);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (152, 24, 'imperdiet nullam', 'Industrial', 1, 245384.49);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (153, 44, 'sagittis sapien', 'Toys', 0, 207810.54);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (154, 5, 'curae', 'Movies', 1, 724528.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (155, 42, 'vitae nisi', 'Garden', 1, 585025.58);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (156, 18, 'nulla', 'Clothing', 1, 514292.33);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (157, 47, 'hac', 'Baby', 0, 273781.46);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (158, 17, 'et ultrices', 'Tools', 0, 700198.85);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (159, 48, 'turpis adipiscing lorem', 'Health', 0, 876030.14);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (160, 16, 'duis ac', 'Electronics', 1, 540294.2);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (161, 43, 'nec molestie', 'Shoes', 0, 451890.86);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (162, 15, 'nibh in quis', 'Garden', 0, 66721.58);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (163, 34, 'convallis', 'Clothing', 0, 170913.69);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (164, 15, 'id ornare', 'Beauty', 0, 956391.57);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (165, 31, 'nisl', 'Baby', 0, 179920.54);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (166, 27, 'eget elit', 'Clothing', 0, 348454.1);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (167, 36, 'pede venenatis', 'Books', 0, 691690.18);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (168, 6, 'lacinia aenean', 'Health', 1, 944305.26);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (169, 49, 'nec sem', 'Outdoors', 0, 486124.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (170, 33, 'non mattis pulvinar', 'Outdoors', 0, 267804.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (171, 7, 'aenean auctor gravida', 'Movies', 0, 465474.15);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (172, 49, 'etiam vel augue', 'Outdoors', 0, 697174.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (173, 5, 'quisque', 'Kids', 1, 440252.48);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (174, 41, 'rutrum', 'Outdoors', 0, 650033.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (175, 7, 'aliquam non mauris', 'Automotive', 1, 823001.11);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (176, 25, 'nec dui', 'Music', 0, 168472.75);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (177, 48, 'neque', 'Baby', 0, 403761.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (178, 5, 'tincidunt', 'Home', 1, 423591.2);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (179, 36, 'eget eros elementum', 'Baby', 1, 516611.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (180, 11, 'molestie hendrerit', 'Games', 0, 223569.64);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (181, 31, 'velit nec nisi', 'Health', 1, 114792.57);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (182, 32, 'purus eu', 'Computers', 1, 418663.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (183, 1, 'eu felis', 'Electronics', 0, 592175.85);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (184, 20, 'maecenas', 'Games', 1, 285948.73);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (185, 5, 'commodo vulputate justo', 'Outdoors', 1, 593281.47);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (186, 22, 'nulla', 'Toys', 1, 43704.31);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (187, 20, 'suscipit nulla', 'Tools', 0, 373352.2);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (188, 36, 'tincidunt', 'Computers', 0, 691685.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (189, 21, 'at nulla', 'Shoes', 1, 575711.45);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (190, 49, 'donec dapibus duis', 'Shoes', 1, 727205.31);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (191, 8, 'augue quam', 'Toys', 0, 803418.39);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (192, 17, 'turpis nec', 'Clothing', 1, 9500.05);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (193, 16, 'odio curabitur convallis', 'Music', 1, 280127.92);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (194, 14, 'vestibulum aliquet', 'Beauty', 0, 974187.51);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (195, 3, 'diam neque vestibulum', 'Computers', 1, 596098.69);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (196, 47, 'enim lorem ipsum', 'Kids', 1, 522267.82);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (197, 48, 'aliquam sit', 'Health', 0, 675077.67);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (198, 4, 'imperdiet et commodo', 'Movies', 1, 715913.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (199, 30, 'hendrerit', 'Games', 1, 466103.78);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (200, 10, 'orci', 'Movies', 0, 978902.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (201, 1, 'vestibulum eget', 'Books', 0, 837864.36);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (202, 17, 'quis libero nullam', 'Tools', 1, 713950.18);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (203, 40, 'aliquam augue', 'Jewelery', 0, 210821.83);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (204, 11, 'volutpat erat quisque', 'Music', 0, 226323.53);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (205, 35, 'vitae nisi nam', 'Shoes', 0, 65153.89);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (206, 37, 'quam fringilla rhoncus', 'Beauty', 1, 280451.52);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (207, 27, 'quis', 'Home', 1, 127713.19);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (208, 33, 'id', 'Beauty', 0, 366854.06);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (209, 6, 'mauris viverra', 'Toys', 1, 138438.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (210, 20, 'in sapien iaculis', 'Movies', 1, 414291.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (211, 5, 'dis parturient', 'Baby', 0, 67470.67);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (212, 3, 'sed accumsan', 'Books', 0, 859788.05);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (213, 16, 'dui luctus', 'Jewelery', 0, 425256.86);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (214, 18, 'id sapien in', 'Books', 0, 800190.21);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (215, 21, 'odio', 'Kids', 1, 128107.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (216, 43, 'ut odio', 'Books', 0, 669240.35);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (217, 34, 'risus dapibus augue', 'Movies', 0, 19696.52);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (218, 35, 'phasellus', 'Sports', 1, 53100.08);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (219, 38, 'rhoncus', 'Garden', 1, 142483.29);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (220, 28, 'at diam nam', 'Industrial', 1, 512829.71);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (221, 9, 'sed tincidunt', 'Tools', 1, 374760.9);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (222, 13, 'et ultrices posuere', 'Home', 0, 305921.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (223, 47, 'morbi a ipsum', 'Industrial', 0, 644328.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (224, 30, 'vestibulum proin eu', 'Automotive', 1, 542032.16);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (225, 33, 'bibendum morbi', 'Shoes', 1, 192622.9);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (226, 12, 'ut', 'Movies', 1, 765181.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (227, 4, 'fusce posuere felis', 'Automotive', 1, 373868.28);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (228, 33, 'cursus', 'Movies', 1, 423564.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (229, 10, 'non', 'Home', 1, 753163.98);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (230, 14, 'justo', 'Health', 0, 226433.36);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (231, 39, 'elementum', 'Jewelery', 1, 198470.57);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (232, 13, 'dapibus duis', 'Garden', 1, 886488.11);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (233, 23, 'massa quis augue', 'Automotive', 0, 115934.12);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (234, 14, 'leo maecenas', 'Automotive', 0, 795222.57);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (235, 4, 'rhoncus sed vestibulum', 'Music', 0, 247827.09);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (236, 37, 'ante nulla', 'Sports', 0, 580554.42);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (237, 13, 'in', 'Tools', 1, 734286.79);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (238, 47, 'semper', 'Electronics', 1, 120555.17);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (239, 13, 'quam a odio', 'Tools', 0, 215006.22);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (240, 23, 'elementum pellentesque quisque', 'Automotive', 0, 363018.11);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (241, 38, 'quam', 'Automotive', 1, 406218.28);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (242, 19, 'in quis justo', 'Electronics', 0, 721868.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (243, 40, 'eu nibh', 'Kids', 0, 659605.29);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (244, 22, 'at nibh in', 'Outdoors', 1, 239529.76);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (245, 21, 'massa id', 'Kids', 0, 174842.44);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (246, 38, 'ac neque', 'Clothing', 0, 708175.23);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (247, 40, 'eu', 'Industrial', 0, 337751.12);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (248, 14, 'donec odio', 'Outdoors', 1, 466512.21);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (249, 19, 'in', 'Movies', 0, 792208.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (250, 14, 'ut suscipit a', 'Outdoors', 1, 586299.49);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (251, 7, 'id justo', 'Grocery', 1, 624673.97);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (252, 29, 'nisl duis', 'Jewelery', 0, 682507.33);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (253, 38, 'est', 'Computers', 0, 68772.11);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (254, 31, 'duis faucibus', 'Computers', 0, 984052.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (255, 1, 'justo sollicitudin', 'Health', 0, 595282.64);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (256, 6, 'molestie hendrerit', 'Home', 0, 251332.19);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (257, 23, 'neque', 'Tools', 1, 286749.39);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (258, 10, 'lorem', 'Baby', 0, 171903.17);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (259, 50, 'primis', 'Baby', 0, 881140.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (260, 15, 'aenean sit amet', 'Health', 1, 562747.7);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (261, 46, 'ut nulla', 'Music', 0, 774967.33);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (262, 30, 'in congue etiam', 'Tools', 1, 138849.03);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (263, 34, 'proin eu mi', 'Toys', 0, 525907.88);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (264, 26, 'ut dolor morbi', 'Toys', 0, 999438.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (265, 5, 'volutpat erat', 'Movies', 1, 564203.54);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (266, 6, 'sapien cum sociis', 'Movies', 0, 919785.1);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (267, 41, 'semper sapien a', 'Clothing', 1, 190763.91);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (268, 48, 'a libero', 'Kids', 1, 277581.27);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (269, 36, 'molestie', 'Computers', 0, 843211.22);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (270, 40, 'eu sapien cursus', 'Music', 0, 487266.26);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (271, 34, 'vulputate justo', 'Books', 0, 707901.42);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (272, 33, 'eu felis', 'Home', 0, 366240.16);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (273, 13, 'vulputate ut ultrices', 'Movies', 0, 689489.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (274, 34, 'cum sociis natoque', 'Home', 0, 836154.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (275, 36, 'est lacinia nisi', 'Clothing', 0, 914258.22);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (276, 38, 'sed', 'Electronics', 0, 696974.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (277, 37, 'sed tristique', 'Automotive', 0, 780785.16);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (278, 11, 'quam sapien varius', 'Books', 1, 172981.55);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (279, 47, 'duis', 'Garden', 1, 322349.68);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (280, 32, 'commodo placerat', 'Jewelery', 1, 709157.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (281, 15, 'vehicula', 'Home', 0, 13143.93);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (282, 5, 'ipsum primis', 'Health', 1, 266871.0);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (283, 13, 'sollicitudin ut suscipit', 'Outdoors', 1, 563293.01);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (284, 37, 'ligula', 'Movies', 0, 341368.78);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (285, 30, 'erat nulla tempus', 'Shoes', 0, 371285.19);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (286, 30, 'sed', 'Outdoors', 0, 662886.23);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (287, 28, 'aliquet', 'Music', 0, 131696.08);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (288, 33, 'vel', 'Computers', 1, 178017.1);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (289, 11, 'amet', 'Health', 1, 486777.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (290, 18, 'interdum eu tincidunt', 'Industrial', 1, 483513.78);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (291, 44, 'lectus aliquam sit', 'Health', 1, 251046.46);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (292, 35, 'quis lectus suspendisse', 'Baby', 1, 787180.84);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (293, 42, 'lectus pellentesque', 'Health', 0, 912216.26);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (294, 5, 'nec euismod scelerisque', 'Jewelery', 1, 181436.66);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (295, 38, 'porta volutpat quam', 'Books', 1, 682785.96);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (296, 46, 'et', 'Beauty', 0, 347378.16);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (297, 37, 'nulla', 'Electronics', 0, 343041.2);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (298, 31, 'accumsan', 'Baby', 0, 327253.84);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (299, 15, 'purus aliquet at', 'Music', 1, 409850.92);
insert into itemsEntered (itemID, userID, name, category, type, amount) values (300, 49, 'nec sem', 'Clothing', 1, 45656.55);