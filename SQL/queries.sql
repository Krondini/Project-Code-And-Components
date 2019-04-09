# Queries needed for project:

select * from networthinfo NI;
-------------------------------------------------------------------------

# Case where new user is added:
-- need to determine what the new user id should be (need to find MAX and add 1)
-- need to INSERT user info into userInfo database
	--IRL you would need to pass in the values for name, username, password, and email via VARIABLES in javascript
	--------insert into userInfo (userID, firstName, lastName, username, password, email) values( (Select max(userID) + 1 from (select * from userInfo) a),first_name, last_name, username, password, email);
		--dummy entry for userId (NOTE: columns must be in single quotes in postgres):

insert into userInfo (userID, firstName, lastName, username, password, email) values( (Select max(userID) + 1 from (select * from userInfo) a),'nicole', 'costello', 'user', 'pass', 'nic@google.com');

-- need to INSERT user into newWorthInfo table (everything initialized to 0)
-- NOTE THAT NO +1 HERE. This is because we already added the new user so we just want the max userid
insert into netWorthInfo (userID, totalAssets, totalLiabilities, netWorth) values ((Select max(userID) from (select * from userInfo) a), 0.0, 0.0, 0.0);


----------------------------------------------------------------------------
# Case where user adds a new entry
-- update the itemsEntered table with INSERT. Indicate with 1 or 0 if it is a liab or asset.
-- need to use actual variables holding user info
insert into itemsEntered (itemID, userID, name, category, type, amount) values (var_item, var_user, var_name, var_category, var_indicator, var_amount);
	--dummy example for testing:
insert into itemsEntered (itemID, userID, name, category, type, amount) values (1, 23, 'mazda', 'Vehicles', 1, 7252.82);

-- update the net worth table (UPATE TABLE)

	-- UPDATE TOTAL ASSETS -- 
UPDATE networthinfo

Set totalAssets = ASSET.totA

FROM (Select userID, sum(amount) totA from itemsEntered
	where type = 1
	Group by userId) ASSET

WHERE networthinfo.userID = ASSET.userID;

	-- UPDATE TOTAL LIABILITIES --
UPDATE networthinfo

Set totalLiabilities = LIAB.totA

FROM (Select userID, sum(amount) totA from itemsEntered
	where type = 0
	Group by userId) LIAB

WHERE networthinfo.userID = LIAB.userID;

	-- UPDATE NET WORTH --
UPDATE
    netWorthInfo
SET
    netWorth = (totalAssets - totalLiabilities);

-- need to return results of the updated netWorthInfo to display it to user (A,L,NW)
-- would need to have user id of current user stored in a javascript variable (i.e. var_userid)
Select totalAssets from networthinfo where userId = var_userid;
Select totalLiabilities from networthinfo where userId = var_userid;
Select netWorth from networthinfo where userId = var_userid;

	--sample to use for testing with user 1
Select totalAssets from networthinfo where userId = 1;
Select totalLiabilities from networthinfo where userId = 1;
Select netWorth from networthinfo where userId = 1;

-----------------------------------------------------------------------------
# Case where user needs to update an entry
-- UPDATE itemsEntered table (only need to update amount)
UPDATE
	itemsEntered
Set amount = var_new_amount

WHERE itemId = var_itemid;
--SAMPLE:
UPDATE
	itemsEntered
Set amount = 2222

WHERE itemId = 1;

-- if item amount is set to $0, need to DELETE that row of the table
Delete itemsEntered where itemId = var_item_id; --sample where var_item_id is a variable passed in

-- UPDATE netWorthInfo table (update all)
	-- UPDATE TOTAL ASSETS -- 
UPDATE networthinfo

Set totalAssets = ASSET.totA

FROM (Select userID, sum(amount) totA from itemsEntered
	where type = 1
	Group by userId) ASSET

WHERE networthinfo.userID = ASSET.userID;

	-- UPDATE TOTAL LIABILITIES --
UPDATE networthinfo

Set totalLiabilities = LIAB.totA

FROM (Select userID, sum(amount) totA from itemsEntered
	where type = 0
	Group by userId) LIAB

WHERE networthinfo.userID = LIAB.userID;

	-- UPDATE NET WORTH --
UPDATE
    netWorthInfo
SET
    netWorth = (totalAssets - totalLiabilities);

------------------------------------------------------
#SENDING EMAILS TO OTHER USERS
-- will need to get email of other user based on username
Select email from userinfo where username = var_username;
	--dummy sample
Select email from userinfo where username = 'lgilbrider';

