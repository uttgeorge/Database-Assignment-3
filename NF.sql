#This is the 1NF

#1.1 To delete redundant
Drop Table if exists Salary;
CREATE TABLE Salary AS
SELECT nba_salary.*
FROM nba_salary inner join player_details
ON (nba_salary.Player = player_details.PlayerName)
and (nba_salary.Team = player_details.Team);
SELECT COUNT(*) FROM Salary;

Drop Table  if exists Detail;
CREATE TABLE Detail AS
SELECT player_details.*
FROM nba_salary inner join player_details
ON (nba_salary.Player = player_details.PlayerName)
and (nba_salary.Team = player_details.Team);
SELECT COUNT(*) FROM Detail;

Drop Table  if exists Stats;
SELECT * FROM player_stats;
CREATE TABLE Stats AS
SELECT player_stats.*
FROM player_stats inner join player_details
ON (player_stats.Player = player_details.PlayerName)
and (player_stats.Team = player_details.Team);
SELECT COUNT(*) FROM Stats;

# tweets

CREATE TABLE Tweets AS
SELECT Distinct * 
FROM nba_tweets;


ALTER TABLE Tweets
DROP COLUMN team;

#1.2
# CLEAN DATA
# Detail Table 
DELETE Detail 
FROM Detail
WHERE PlayerName is NULL;

Describe Detail;
SELECT * FROM Detail;
alter table Detail modify PlayerName text not null;
Describe Detail;

#Salary Table
DELETE FROM Salary
WHERE Player is NULL;

Describe Salary;
SELECT * FROM Salary;
alter table Salary modify Player text not null;
Describe Salary;

#Stats Table
DELETE FROM Stats
WHERE Player is NULL;

Describe Stats;
SELECT * FROM Stats;
alter table Stats modify Player text not null;
Describe Stats; 


#1.3 primary key
#Tweets
describe Tweets;
Alter table Tweets
add constraint tweets_pk
primary key (id);


#Define Primary key of Detail Table
ALTER TABLE Detail
DROP COLUMN Personid;
Select * from Detail;

ALTER TABLE Detail
   ADD Personid INT UNIQUE AUTO_INCREMENT;
Select * from Detail;
ALTER TABLE Detail
   ADD CONSTRAINT Detail_pk
   PRIMARY KEY(Personid);
Describe Detail;

ALTER TABLE Detail
   modify Team varchar(255) not null;


# define foreign key
describe teamnames;

ALTER TABLE teamnames
   modify Team varchar(255) not null;

alter table Detail
add constraint detail_teamnames_fk
foreign key (Team) references teamnames (Team);

#define id for each table

# Detail has primary key called Personid

    
# Salary table

CREATE TABLE  if not exists TEMP AS
SELECT * FROM Salary;
DROP TABLE Salary;
CREATE TABLE Salary AS
SELECT Detail.Personid,TEMP.*
FROM Detail join TEMP
on Detail.PlayerName = TEMP.Player;
DROP TABLE TEMP;
SELECT * FROM Salary;


ALTER TABLE Salary
   ADD CONSTRAINT Salary_pk
   PRIMARY KEY(Personid);

SELECT * FROM Salary;

Alter table Salary
DROP COLUMN Player;
Alter table Salary
DROP COLUMN Team;

DESCRIBE Salary;

# Stats table
CREATE TABLE  if not exists TEMP AS
SELECT * FROM Stats;
DROP TABLE Stats;
CREATE TABLE Stats AS
SELECT Detail.Personid,TEMP.*
FROM Detail join TEMP
on Detail.PlayerName = TEMP.Player;
DROP TABLE TEMP;
SELECT * FROM Stats;


ALTER TABLE Stats
   ADD CONSTRAINT Stats_pk
   PRIMARY KEY(Personid);

SELECT * FROM Stats;

ALTER TABLE Stats
DROP COLUMN Player,
DROP COLUMN Team;


DESCRIBE Stats;

#
SELECT Account FROM Basketball.nba_twitter_accounts;
SELECT Count(*) FROM nba_twitter_accounts
where Abbr is NULL
or Name is NULL
or Account is NULL ;

Alter Table nba_twitter_accounts
add constraint account_pk
primary key(Account(255));


#

SELECT * FROM Basketball.teamnames;

SELECT COUNT(*) 
FROM teamnames
WHERE Team is NULL;

Describe teamnames;

#
SELECT * FROM Basketball.teamstats;
Describe teamstats;
ALTER TABLE teamstats
add constraint teamstats_pk
primary key (Team(255));

Alter Table Basketball.teamstats
DROP COLUMN Team_Name;
SELECT * FROM teamstats;



#1.4

#Atomic

Select * from Detail;
# We should plit names
#define firstname and surname
#SET @Firstname,@Surname;


Alter TAble Detail 
ADD COLUMN FirstName varchar(50), 
add column LastName varchar(50);

UPDATE Detail 
SET FirstName = SUBSTRING_INDEX(PlayerName, " ", 1) , LastName = SUBSTRING_INDEX(PlayerName, " ", -1);

ALTER TABLE Detail 
DROP COLUMN PlayerName;

SELECT * FROM Detail;



# hashtag table

SELECT count(id) FROM Basketball.hashtags;

DROP TABLE Hashtag;
CREATE TABLE TEMP AS
SELECT id,N1 as ht FROM hashtags
UNION
SELECT id,N2 as ht FROM hashtags
UNION
SELECT id,N3 as ht FROM hashtags;

DELETE FROM TEMP 
WHERE ht='';
CREATE TABLE Hashtag AS
SELECT * FROM TEMP WHERE ht!='' or ht is not null;
DROP TABLE TEMP;
SELECT * FROM Hashtag;

ALTER TABLE Hashtag
ADD CONSTRAINT pk_hashtag
PRIMARY KEY (id,ht(255));

DESCRIBE Hashtag;


