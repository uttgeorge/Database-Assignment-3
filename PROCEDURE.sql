#PROCEDURE
#1. search the tweets of a team

SELECT * FROM Tweets;
SELECT * FROM nba_twitter_accounts;
DROP Procedure teamtweets;
DELIMITER //
CREATE PROCEDURE teamtweets(teamabbr TEXT)
#RETURNS TEXT
BEGIN 
	#DECLARE tweets TEXT;
    SELECT a.Tweets,a.Account
    FROM (
		SELECT t.Tweets,n.Account
        FROM Tweets t join nba_twitter_accounts n
        on t.account = n.Account
        WHERE n.Abbr = teamabbr
        ORDER BY n.Account
        
    )a
    ;
	#RETURN tweets;
END;
//
DELIMITER ;

CALL teamtweets('ATL');

#2. Show the salary of allstar players
SELECT * FROM Salary;
SELECT * FROM Detail;
DROP Procedure allstarsalary;
DELIMITER //
CREATE PROCEDURE allstarsalary()

BEGIN 
	SELECT d.FirstName, d.LastName, s.Salary
	FROM Salary s join Detail d
	on s.Personid = d.Personid
	WHERE s.Allstar = 'True'
	ORDER BY s.Salary
    ;

END;
//
DELIMITER ;

CALL allstarsalary();

#3. SHow the datatype of the database
DROP PROCEDURE explainDatabase;
DELIMITER //
CREATE PROCEDURE explainDatabase()
BEGIN
  SHOW DATABASES;

  SHOW TABLES;
  
  SELECT info.TABLE_NAME, info.COLUMN_NAME, info.DATA_TYPE
  FROM information_schema.columns info
  WHERE table_schema = 'Basketball';
  
END;//
DELIMITER ;

CALL explainDatabase();


#4. find the top ten popular hashtags
SELECT * FROM Hashtag;
DROP PROCEDURE tenpophash;
DELIMITER //
CREATE PROCEDURE tenpophash()
BEGIN
  SELECT 
        ht as hashtag, count(ht) as counts
    FROM
        Hashtag
    GROUP BY hashtag
    ORDER BY counts DESC
    LIMIT 10;
END;
//
DELIMITER ;

CALL tenpophash();

#5. 
# show the likes of each account
SELECT * FROM Tweets;
DROP PROCEDURE popaccount;
DELIMITER //
CREATE PROCEDURE popaccount()
BEGIN
  SELECT account , sum(likes) as pop
  FROM Tweets
  GROUP BY account
  ORDER BY pop DESC;
END;
//
DELIMITER ;

CALL popaccount();