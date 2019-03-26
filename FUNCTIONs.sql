
SET GLOBAL log_bin_trust_function_creators = 1;

# 1. Find the salary of a player

DELIMITER //
CREATE FUNCTION callsalary (firstname TEXT,lastname TEXT)
RETURNS INT
BEGIN
	DECLARE Income INT;
    SELECT t.Salary INTO Income
    FROM (
		SELECT d.FirstName,d.LastName,s.Salary
        FROM Detail d join Salary s
        ON d.Personid = s.Personid
        WHERE d.FirstName = firstname and d.LastName = lastname
        )t;
    RETURN Income;
END;
//
DELIMITER ;

SELECT FirstName,LastName FROM Detail;


SELECT callsalary('John','Wall');


#2. To check whether a player is an allstar player
SELECT * FROM Detail;
DROP FUNCTION ifallstar;
DELIMITER //
CREATE FUNCTION ifallstar(firstname TEXT,lastname TEXT)
RETURNS Boolean
BEGIN 
	DECLARE idx TEXT;
    SELECT t.AllStar INTO idx
    FROM (
		SELECT d.FirstName,d.LastName,s.AllStar
        FROM Detail d join Salary s
        ON d.Personid = s.Personid
        WHERE d.FirstName = firstname and d.LastName = lastname
        )t;
	IF idx = 'True' THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END;
//
DELIMITER ;
SELECT ifallstar('John','Wall') "1 is true,0 is false";
SELECT ifallstar('Amir','Johnson') "1 is true,0 is false";


#3. find the most common hashtag
SELECT * FROM Hashtag;
DROP FUNCTION commonhashtag;
DELIMITER //
CREATE FUNCTION commonhashtag()
RETURNS TEXT
BEGIN 
	DECLARE hashtag TEXT;
    SELECT  ht INTO hashtag
    FROM Hashtag
    GROUP BY ht
    ORDER BY count(ht) DESC
    LIMIT 1;
	RETURN hashtag;
END;
//
DELIMITER ;

select commonhashtag();


#4. find the most popular tweet of a team
SELECT * FROM Tweets;
DROP FUNCTION poptweet;
DELIMITER //
CREATE FUNCTION poptweet(abbr TEXT)
RETURNS TEXT
BEGIN 
	DECLARE popt TEXT;
    SELECT a.Tweets INTO popt
    FROM (
        SELECT t.Tweets,t.likes
        FROM Tweets t join nba_twitter_accounts n
        on t.account = n.Account
        WHERE n.Abbr = abbr
        ORDER BY t.likes DESC
    )a
    limit 1;
	RETURN popt;
END;
//
DELIMITER ;

SELECT poptweet('ATL');

#5. find the best player of a team

SELECT * FROM Stats;
DROP FUNCTION bestplayer; 
DELIMITER //
CREATE FUNCTION bestplayer(teamabbr TEXT)
RETURNS TEXT
BEGIN
	DECLARE player TEXT;
    SELECT CONCAT(a.FirstName, ' ', a.LastName) INTO player
    FROM(
		SELECT d.FirstName,d.LastName,d.Team,
        ((s.PPG+s.RPG+s.APG+s.SPG+s.BPG)-((s.FGA-s.FGM)+(s.FTA-s.FTM)+s.TOV)) as eff
        FROM Detail d join Stats s
        ON d.Personid = s.Personid
        ) a
	WHERE a.Team = teamabbr
    ORDER BY a.eff DESC
    limit 1;
    
    RETURN player;
END;
//
DELIMITER ;

SELECT bestplayer('HOU');




