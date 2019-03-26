## Database-Assignment-3

### Abstract

The assignment is about to normalize database, create index to enhance the performance of the user case, create 5 functions and 5 procedures.

## Normalization
### 1NF
**Requirement:**
1. No repeating groups
2. Atomic
3. Each field has a unique name
4. Primary key

*Table 1: teamnames*
>```mysql
>ALTER TABLE teamnames
>ADD CONSTRAINT pk_teamnames
>PRIMARY KEY teamnames(Team(25));
>```
>Primary key is pk_teamnames, teamnames table is in 1NF

*Table 2: Detail*
>```mysql
>ALTER TABLE Detail
>ADD Personid INT UNIQUE AUTO_INCREMENT;
>ALTER TABLE Detail
>ADD CONSTRAINT pk_Detail
>PRIMARY KEY(Personid);
>```
>Create primary key for Detail table: pl_Detail
>```mysql
>Alter TAble Detail 
>ADD COLUMN FirstName varchar(50), 
>ADD COLUMN LastName varchar(50);
>UPDATE Detail 
>SET FirstName = SUBSTRING_INDEX(PlayerName, " ", 1) , LastName = SUBSTRING_INDEX(PlayerName, " ", -1);
>```
>To make the table atomic
>```mysql
>ALTER TABLE Detail 
>DROP COLUMN PlayerName;
>```
>No repeating groups.\
>Detail table is in 1NF

*Table 3: Stats*
>```mysql
>ALTER TABLE Stats
>ADD CONSTRAINT pk_Stats
>PRIMARY KEY(Personid);
>```
>Create primary key for the table.
>```mysql
>ALTER TABLE Stats
>DROP COLUMN Player,
>DROP COLUMN Team;
>```
>No repeating groups.\
>Table 3 is in 1NF

*Table 4: Salary*
>```mysql
>ALTER TABLE Salary
>ADD CONSTRAINT pk_Salary
>PRIMARY KEY(Personid);
>```
>Create primary key for Salary table as pk_Salary
>```mysql
>Alter table Salary
>DROP COLUMN Player,
>DROP COLUMN Team;
>```
>No repeating groups\
>Table 4 is in 1NF

*Table 5: teamstats*
>```mysql
>ALTER TABLE teamstats
>add constraint pk_teamstats
>primary key (Team(255));
>```
>Create primary key for teamstats\
>The table is in 1NF

*Table 6: nba_twitter_account*
>```mysql
>Alter Table nba_twitter_accounts
>add constraint account_pk
>primary key(Account(255));
>```
>Create primary key for nba_twitter_account\
>The table in is 1NF

*Table 7: Tweets*
>```mysql
>Alter table Tweets
>add constraint pk_tweets
>primary key (id);
>```
>Create primary key for Tweets table
>```mysql
>ALTER TABLE Tweets
>DROP COLUMN team;
>```
>>No repeating groups\
>Table 7 is in 1NF

*Table 8: Hashtag*
>```mysql
>SELECT count(id) FROM Basketball.hashtags;
>DROP TABLE Hashtag;
>CREATE TABLE TEMP AS
>SELECT id,N1 as ht FROM hashtags
>UNION
>SELECT id,N2 as ht FROM hashtags
>UNION
>SELECT id,N3 as ht FROM hashtags;
>DELETE FROM TEMP 
>WHERE ht='';
>CREATE TABLE Hashtag AS
>SELECT * FROM TEMP WHERE ht!='' or ht is not null;
>DROP TABLE TEMP;
>```
>Combine 3 columns of hashtags into 1 column, delete all repeating groups.
>```mysql
>ALTER TABLE Hashtag
>ADD CONSTRAINT pk_hashtag
>PRIMARY KEY (id,ht(255));
>```
>Create primary key for the table.\
>The table is in 1NF

### 2NF
**Requirement:**
1. Already 1NF
2. No partial dependencies
3. No calculated data

>1.All the table are in 1NF\
>2.Hashtag table do not have non-key attributes, and other tables only have one primary key, So there is no partial dependency.\
>3.All table do not have calculated data.

### 3NF
**Requirement:**
1. Already 2NF
2. No transitive dependencies

*Table 1: teamnames*
> Already in 3NF

*Table 2: Detail*
> Already in 3NF 

*Table 3: Stats*
>```mysql
>ALTER TABLE Stats
>DROP COLUMN Player,
>DROP COLUMN Team;
>```
>Because Team is depends on Players, and Player is depends on Personid. \
>Now Table 3 is in 3NF

*Table 4: Salary*
>```mysql
>Alter table Salary
>DROP COLUMN Player,
>DROP COLUMN Team;
>```
>The reason is as same as it for table 4.\
>Table 4 is in 3NF

*Table 5: teamstats*
> Already in 3NF

*Table 6: nba_twitter_account*
> Already in 3NF

*Table 7: Tweets*

>```mysql
>ALTER TABLE Tweets
>DROP COLUMN team;
>```
> Same reason.\
>Table 7 is in 3NF

*Table 8: Hashtag*
>```mysql
> Already in 3NF


## Users cases' views
##### User Case 1:
Based on EFF of each player, user want to know what were the teams that top 10 players served and their teams' performance
>```mysql
>CREATE OR REPLACE VIEW Top_Players_Team AS
>SELECT 
>	-- NAME OF PLAYER
>        p.Player
>	-- EFF IS ((Points + Rebounds + Assists + Steals + Blocks) - ((Field Goals Att. - Field Goals Made) + (Free Throws Att. - Free Throws Made) + Turnovers))
>        ,eff
>	-- TEAM NAMES
>        ,t.Team_Name
>	-- WINS / (WINS + LOSSES)
>        ,win_percentage
>FROM (SELECT Team_Name
>,Team
>,Wins / (Wins + Losses) as win_percentage
>FROM teamstats) t
>JOIN (SELECT Player
>, Team
>, ((PPG+RPG+APG+SPG+BPG)-((FGA-FGM)+(FTA-FTM)+TOV)) as eff
>FROM player_stats) p
>ON t.Team = p.Team
>ORDER BY eff DESC
>LIMIT 10;  
>```
Result:\
| Player                | eff                | Team | win_percentage |
|-----------------------|--------------------|------|----------------|
| Anthony Davis         | 32.900000000000006 | NOP  |         0.5854 |
| LeBron James          |               32.7 | CLE  |         0.6098 |
| Giannis Antetokounmpo | 30.799999999999997 | MIL  |         0.5366 |
| DeMarcus Cousins      | 30.200000000000003 | NOP  |         0.5854 |
| James Harden          | 30.199999999999992 | HOU  |         0.7927 |
| Russell Westbrook     | 29.400000000000002 | OKC  |         0.5854 |
| Karl-Anthony Towns    | 29.099999999999994 | MIN  |         0.5732 |
| Kevin Durant          | 28.799999999999994 | GSW  |         0.7073 |
| Stephen Curry         | 27.500000000000007 | GSW  |         0.7073 |
| Andre Drummond        | 27.200000000000003 | DET  |         0.4756 |

##### User Case 2:
Create a view to show the average eff of each age 
>```mysql
>CREATE OR REPLACE VIEW AGE_PERF AS
>SELECT
>	YEAR(CURDATE()) - YEAR(DATE_FORMAT(STR_TO_DATE(pd.BirthDate, '%m/%d/%Y'), "%Y-%m-%d")) AS age,
>    sum((ps.PPG+ps.RPG+ps.APG+ps.SPG+ps.BPG)-((ps.FGA-ps.FGM)+(ps.FTA-ps.FTM)+ps.TOV))/count(ps.Player) as eff
>    FROM player_details pd, player_stats ps
>    WHERE pd.PlayerName = ps.Player
>    group by age
>    order by age ASC;
>```
Result:\
| age  | eff                |
|------|--------------------|
|   21 |  5.916666666666665 |
|   22 |            9.20625 |
|   23 |  9.021052631578948 |
|   24 | 12.517647058823528 |
|   25 | 12.100000000000001 |
|   26 | 14.169230769230767 |
|   27 |  13.35217391304348 |
|   28 |              11.05 |
|   29 |  14.74705882352941 |
|   30 | 14.833333333333332 |
|   31 | 14.635294117647055 |
|   32 |              11.27 |
|   33 | 13.290000000000001 |
|   34 | 15.277777777777779 |
|   35 |             10.375 |
|   37 | 11.599999999999996 |
|   38 | 15.099999999999996 |
|   39 |  8.450000000000001 |
|   41 | 14.400000000000002 |

##### User Case 3:
Create a view to show the salaries of all-stars, AND their current team
>```mysql
>CREATE OR REPLACE VIEW ALL_STAR_SALARY AS
>SELECT 
>	-- PLAYER NAME
>		Player,
>	-- TEAM NAME
>		Team,
>	-- SALARY OF PLAYER
>       Salary
>		FROM nba_salary
>        WHERE Allstar = 'True';
>```
Result:\
| Player                | Team | Salary   |
|-----------------------|------|----------|
| Stephen Curry         | GSW  | 34682550 |
| LeBron James          | CLE  | 33285709 |
| Kyle Lowry            | TOR  | 28703704 |
| Russell Westbrook     | OKC  | 28530608 |
| James Harden          | HOU  | 28299399 |
| DeMar DeRozan         | TOR  | 27739975 |
| Al Horford            | BOS  | 27734405 |
| Damian Lillard        | POR  | 26153057 |
| Kevin Durant          | GSW  | 25000000 |
| Bradley Beal          | WAS  | 23775506 |
| Anthony Davis         | NOP  | 23775506 |
| Andre Drummond        | DET  | 23775506 |
| Kevin Love            | CLE  | 22642350 |
| Giannis Antetokounmpo | MIL  | 22471910 |
| LaMarcus Aldridge     | SAS  | 21461010 |
| Victor Oladipo        | IND  | 21000000 |
| Paul George           | OKC  | 19508958 |
| Jimmy Butler          | MIN  | 19301070 |
| Kyrie Irving          | BOS  | 18868625 |
| John Wall             | WAS  | 18063850 |
| DeMarcus Cousins      | NOP  | 18063850 |
| Klay Thompson         | GSW  | 17826150 |
| Goran Dragic          | MIA  | 17000450 |
| Draymond Green        | GSW  | 16400000 |
| Kemba Walker          | CHO  | 12000000 |
| Karl-Anthony Towns    | MIN  |  6216840 |
| Joel Embiid           | PHI  |  6100266 |
| Kristaps Porzingis    | NYK  |  4503600 |        


##### User Case 4:
Find the total likes of each teams' major twitter accounts.\
What are the most liked Tweets for every top 10 popular Teams
>```mysql
>CREATE VIEW POP_TEAM AS
>SELECT m.team,
>	Tweets,
>	likes
>    From NBA_twitter n join(
>    SELECT team,
>	sum(likes)/count(Tweets) as pop
>    FROM NBA_twitter
>    group by team
>    order by pop DESC
>    limit 10
>    )m on n.team = m.team
>    order by likes DESC;
>```

>```mysql    
>CREATE VIEW MOST_POP_TWEET AS
>SELECT
>	team,
>	Tweets,
>	likes
>    From NBA_twitter n join(
>    select max(likes) as lk
>	from POP_TEAM
>	group by team
>	) p on n.likes = p.lk; 
>```
Result (Only show first 5):\
| team                  | Tweets                                                                                                                     | likes |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------|-------|
| Boston Celtics        | RAISE IT UP JT 🏆 https://t.co/yKDin52NdO                                                                                    | 11160 |
| Golden State Warriors | drip on 100,000 💧 https://t.co/ylURP2b3wd                                                                                   | 26647 |
| Los Angeles Lakers    | 👀 @kylekuzma with his @ZO2_ impression https://t.co/QchoNtuboj                                                              | 19403 |
| Oklahoma City Thunder | PAUL. GEORGE.                                                                                                              | 13198 |
| Toronto Raptors       | For all the good times 
For all you’ve done for this City, for Canada

Thank you, @DeMar_DeRozan https://t.co/uxFLPQv1Sw   | 19331 |


##### User Case 5:
What is the most popular hashtag
>```mysql
>CREATE VIEW pop_hash AS
>SELECT hashtag, COUNT(hashtag) AS N
>FROM hashtags
>WHERE (hashtag IS NOT NULL)
>GROUP BY hashtag
>ORDER BY Count DESC
>LIMIT 20;
>```
Result:\
| hashtag            | N  |
|--------------------|----|
| RipCity            |  3 |
| Nuggets            |  3 |
| Cavs               |  2 |
| Knicks             |  2 |
| GatorsHoop         |  2 |
| NBAAllStar         |  2 |
| Pistons            |  2 |
| TrueToAtlanta      |  2 |
| NBA                |  2 |
| FearTheDeer        |  2 |
| Sixers             |  2 |
| WeGoHard           |  2 |
| SunsVsJazz         |  2 |
| WeTheNorth         |  2 |
| IWD2019            |  2 |
| MileHighBasketball |  2 |
| Rockets            |  2 |
| GoSpursGo          |  2 |
| NEBHInjuryReport   |  1 |
| 313Day             |  1 |


### Index
##### User case 1:
Join player detail and team stats.
>```mysql
>EXPLAIN SELECT player_details.*,teamstats.Points
>FROM player_details join teamstats
>on player_details.Team = teamstats.Team;
>```
Original:
>It has to search 499 rows in details table.

Now create index on Team:
>```mysql
>CREATE INDEX team_idx
>on player_details(Team(25));
>EXPLAIN SELECT player_details.*,teamstats.Points
>FROM player_details join teamstats
>on player_details.Team = teamstats.Team;
>```
Performance:
>Only have to search 16 rows.

##### User case 2: 
>```mysql
>EXPLAIN SELECT PlayerName
>From player_details
>where Pos = 'C';
>```
Original:
>Search 499 rows.

>```mysql
>CREATE INDEX position_idx
>on player_details(Pos(25));
>EXPLAIN SELECT PlayerName
>From player_details
>where Pos = 'C';
>```
Performance:
>Only search 69 rows. 

##### User case 3: 
>```mysql
>explain
>SELECT teamstats.Team,teamstats.Wins,teamstats.Losses,nba_twitter_accounts.Account
>FROM teamstats right join nba_twitter_accounts
>on teamstats.Team = nba_twitter_accounts.Abbr
>Where teamstats.Wins > teamstats.Losses
>ORDER BY Team;
>```
Original:
> Search 65 rows in nba_twitter_account table.\ Time 0.0019 sec

>```mysql
>CREATE INDEX idx_tm
>on nba_twitter_accounts(Abbr(25));
>explain
>SELECT teamstats.Team,teamstats.Wins,teamstats.Losses,nba_twitter_accounts.Account
>FROM teamstats right join nba_twitter_accounts
>on teamstats.Team = nba_twitter_accounts.Abbr
>Where teamstats.Wins > teamstats.Losses
>ORDER BY Team;
>```
Performance:
> Only search 2 rows.\ Time is 0.00074 sec.

##### User case 4:
>```mysql
>SELECT * FROM Salary;
>explain
>SELECT Personid,Salary
>FROM Salary
>WHERE Allstar = 'True';
>```
Original:
> Search 229 rows.

>```mysql
>CREATE INDEX idx_star
>on Salary(Allstar(25));
>explain
>SELECT Personid,Salary
>FROM Salary
>WHERE Allstar = 'True';
>```
Performance:
>Only search 23 rows.

##### User case 5:
>```mysql
>SELECT * FROM player_details;
>explain
>SELECT PlayerName
>FROM player_details
>WHERE ExperienceYear>=8;
>```
Original:
>Search 499 rows.

>```mysql
>CREATE INDEX idx_exp
>on player_details(ExperienceYear);
>explain
>SELECT PlayerName
>FROM player_details
>WHERE ExperienceYear>=8;
>```
performance:
>Search 110 rows.


### Functions
##### 1. Find the salary of a player
>```mysql
>DELIMITER //
>CREATE FUNCTION callsalary (firstname TEXT,lastname TEXT)
>RETURNS INT
>BEGIN
>	DECLARE Income INT;
>    SELECT t.Salary INTO Income
>    FROM (
>		SELECT d.FirstName,d.LastName,s.Salary
>        FROM Detail d join Salary s
>        ON d.Personid = s.Personid
>        WHERE d.FirstName = firstname and d.LastName = lastname
>        )t;
>    RETURN Income;
>END;
>//
>DELIMITER ;
>```

Test:
>```mysql
>SELECT callsalary('John','Wall');
>```
Result:\
| callsalary('John','Wall') |
|---------------------------|
|                  18063850 |

##### 2. To check whether a player is an all-star player
>```mysql
>SELECT * FROM Detail;
>DROP FUNCTION ifallstar;
>DELIMITER //
>CREATE FUNCTION ifallstar(firstname TEXT,lastname TEXT)
>RETURNS Boolean
>BEGIN 
>	DECLARE idx TEXT;
>    SELECT t.AllStar INTO idx
>    FROM (
>		SELECT d.FirstName,d.LastName,s.AllStar
>        FROM Detail d join Salary s
>        ON d.Personid = s.Personid
>        WHERE d.FirstName = firstname and d.LastName = lastname
>        )t;
>	IF idx = 'True' THEN RETURN TRUE;
>    ELSE RETURN FALSE;
>    END IF;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>SELECT ifallstar('John','Wall') "1 is true,0 is false";
>```
result:\
| 1 is true,0 is false |
|----------------------|
|                    1 |
>```mysql
>SELECT ifallstar('Amir','Johnson') "1 is true,0 is false";
>```
Result:\
| 1 is true,0 is false |
|----------------------|
|                    0 |

##### 3. find the most common hashtag
>```mysql
>SELECT * FROM Hashtag;
>DROP FUNCTION commonhashtag;
>DELIMITER //
>CREATE FUNCTION commonhashtag()
>RETURNS TEXT
>BEGIN 
>	DECLARE hashtag TEXT;
>    SELECT  ht INTO hashtag
>    FROM Hashtag
>    GROUP BY ht
>    ORDER BY count(ht) DESC
>    LIMIT 1;
>	RETURN hashtag;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>select commonhashtag();
>```
Result:\
| commonhashtag() |
|-----------------|
| Knicks          |

##### 4. find the most popular tweet of a team
>```mysql
>SELECT * FROM Tweets;
>DROP FUNCTION poptweet;
>DELIMITER //
>CREATE FUNCTION poptweet(abbr TEXT)
>RETURNS TEXT
>BEGIN 
>	DECLARE popt TEXT;
>    SELECT a.Tweets INTO popt
>    FROM (
>        SELECT t.Tweets,t.likes
>        FROM Tweets t join nba_twitter_accounts n
>        on t.account = n.Account
>        WHERE n.Abbr = abbr
>        ORDER BY t.likes DESC
>    )a
>    limit 1;
>	RETURN popt;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>SELECT poptweet('ATL');
>```
Result:\
| poptweet('ATL')                              |
|----------------------------------------------|
| @BleacherReport admiring our twitter account |

#####5. Find the best player of a team
>```mysql
>SELECT * FROM Stats;
>DROP FUNCTION bestplayer; 
>DELIMITER //
>CREATE FUNCTION bestplayer(teamabbr TEXT)
>RETURNS TEXT
>BEGIN
>	DECLARE player TEXT;
>    SELECT CONCAT(a.FirstName, ' ', a.LastName) INTO player
>    FROM(
>		SELECT d.FirstName,d.LastName,d.Team,
>        ((s.PPG+s.RPG+s.APG+s.SPG+s.BPG)-((s.FGA-s.FGM)+(s.FTA-s.FTM)+s.TOV)) as eff
>        FROM Detail d join Stats s
>        ON d.Personid = s.Personid
>        ) a
>	WHERE a.Team = teamabbr
>    ORDER BY a.eff DESC
>    limit 1;
>    RETURN player;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>SELECT bestplayer('HOU');
>```
Result:\
| bestplayer('HOU') |
|-------------------|
| James Harden      |


### Procedures

##### 1. search the tweets of a team
>```mysql
>SELECT * FROM Tweets;
>SELECT * FROM nba_twitter_accounts;
>DROP Procedure teamtweets;
>DELIMITER //
>CREATE PROCEDURE teamtweets(teamabbr TEXT)
>#RETURNS TEXT
>BEGIN 
>	#DECLARE tweets TEXT;
>    SELECT a.Tweets,a.Account
>    FROM (
>		SELECT t.Tweets,n.Account
>        FROM Tweets t join nba_twitter_accounts n
>        on t.account = n.Account
>        WHERE n.Abbr = teamabbr
>        ORDER BY n.Account        
>    )a
>    ;
>	#RETURN tweets;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>CALL teamtweets('ATL');
>```
Result(Only show first 10):\
| Tweets                                                                                                                                        | Account          |
|-----------------------------------------------------------------------------------------------------------------------------------------------|------------------|
| RT @ESPNNBA: Trae Young didn't even cross half court before throwing this alley-oop 😳

(📍 @StateFarm) https://t.co/sMIYzRkTPi                   | @atl_hawksnation |
| RT @YahooSportsNBA: Trae Young throws a 60 foot lob to John Collins!

(via @ESPNNBA)
https://t.co/lsLS3DNtyp                                  | @atl_hawksnation |
| RT @ATLHawks: @BleacherReport admiring our twitter account                                                                                    | @atl_hawksnation |
| Our @atlhawks win against the @memgrizz! #ATLHawks #TruetoAtlanta #HawksvsGrizzlies https://t.co/L6lpZFNmC5                                   | @atl_hawksnation |
| RT @ATLHawks: oh
.
.
.
.
.
OOOOHHHH. 😱 https://t.co/WVq9MxO7sU                                                                                 | @atl_hawksnation |
| Facebook and Instagram been tripping Alll day                                                                                                 | @atl_hawksnation |
| @TheTraeYoung Big facts                                                                                                                       | @atl_hawksnation |
| RT @TheTraeYoung: Whoever is trying to bring you down, is already below you💯                                                                   | @atl_hawksnation |
| Our @atlhawks are back in action tonight against the @memgrizz. #GOHAWKS! #ATLHawks #HawksvsGrizzlies https://t.co/IVMoOlxrUF                 | @atl_hawksnation |
| RT @HawksPR: John Collins (20 points/10 rebounds) recorded his 18th contest with at least 20 points and 10 rebounds, the fifth-most in the…   | @atl_hawksnation |


##### 2. Show the salary of allstar players
>```mysql
>SELECT * FROM Salary;
>SELECT * FROM Detail;
>DROP Procedure allstarsalary;
>DELIMITER //
>CREATE PROCEDURE allstarsalary()
>
>BEGIN 
>	SELECT d.FirstName, d.LastName, s.Salary
>	FROM Salary s join Detail d
>	on s.Personid = d.Personid
>	WHERE s.Allstar = 'True'
>	ORDER BY s.Salary
>    ;
>
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>CALL allstarsalary();
>```
Result:\
| FirstName    | LastName      | Salary   |
|--------------|---------------|----------|
| Kristaps     | Porzingis     |  4503600 |
| Joel         | Embiid        |  6100266 |
| Karl-Anthony | Towns         |  6216840 |
| Draymond     | Green         | 16400000 |
| Goran        | Dragic        | 17000450 |
| Klay         | Thompson      | 17826150 |
| John         | Wall          | 18063850 |
| Kyrie        | Irving        | 18868625 |
| Paul         | George        | 19508958 |
| Victor       | Oladipo       | 21000000 |
| LaMarcus     | Aldridge      | 21461010 |
| Giannis      | Antetokounmpo | 22471910 |
| Kevin        | Love          | 22642350 |
| Bradley      | Beal          | 23775506 |
| Anthony      | Davis         | 23775506 |
| Andre        | Drummond      | 23775506 |
| Kevin        | Durant        | 25000000 |
| Damian       | Lillard       | 26153057 |
| Al           | Horford       | 27734405 |
| James        | Harden        | 28299399 |
| Russell      | Westbrook     | 28530608 |
| Kyle         | Lowry         | 28703704 |
| Stephen      | Curry         | 34682550 |

##### 3. SHow the datatype of the database
>```mysql
>DROP PROCEDURE explainDatabase;
>DELIMITER //
>CREATE PROCEDURE explainDatabase()
>BEGIN
>  SHOW DATABASES;
>  SHOW TABLES;  
>  SELECT info.TABLE_NAME, info.COLUMN_NAME, info.DATA_TYPE
>  FROM information_schema.columns info
>  WHERE table_schema = 'Basketball';  
>END;//
>DELIMITER ;
>```
Test:
>```mysql
>CALL explainDatabase();
>```
Result:\
| Database           |
|--------------------|
| Basketball         |
| information_schema |
| mysql              |
| performance_schema |
| sys                |\

5 rows in set (0.00 sec)\


| Tables_in_basketball |
|----------------------|
| age_perf             |
| all_star_salary      |
| Detail               |
| Hashtag              |
| hashtags             |
| most_pop_tweet       |
| nba_salary           |
| nba_tweets           |
| NBA_Twitter          |
| nba_twitter_accounts |
| new_age_perf         |
| new_pop_hash         |
| player_details       |
| player_stats         |
| pop_hash             |
| POP_TEAM             |
| Salary               |
| Stats                |
| teamnames            |
| teamstats            |
| top_players_team     |
| Tweets               |\

22 rows in set (0.01 sec)\


| TABLE_NAME           | COLUMN_NAME             | DATA_TYPE  |
|----------------------|-------------------------|------------|
| age_perf             | age                     | int        |
| age_perf             | eff                     | double     |
| all_star_salary      | Player                  | text       |
| all_star_salary      | Salary                  | double     |
| all_star_salary      | Team                    | text       |
| Detail               | BirthCity               | text       |
| Detail               | BirthDate               | text       |
| Detail               | College                 | text       |
| Detail               | ExperienceYear          | int        |
| Detail               | FirstName               | varchar    |
| Detail               | Height                  | int        |
| Detail               | JerseyNo                | int        |
| Detail               | LastName                | varchar    |
| Detail               | Personid                | int        |
| Detail               | PhotoUrl                | text       |
| Detail               | Position                | text       |
| Detail               | Team                    | varchar    |
| Detail               | Weight                  | int        |
| Hashtag              | ht                      | mediumtext |
| Hashtag              | id                      | bigint     |
| hashtags             | id                      | bigint     |
| hashtags             | N1                      | text       |
| hashtags             | N2                      | text       |
| hashtags             | N3                      | text       |
| most_pop_tweet       | likes                   | int        |
| most_pop_tweet       | team                    | text       |
| most_pop_tweet       | Tweets                  | text       |
| nba_salary           | AllStar                 | text       |
| nba_salary           | Player                  | text       |
| nba_salary           | Salary                  | double     |
| nba_salary           | Team                    | text       |
| nba_tweets           | #hashtag                | int        |
| nba_tweets           | account                 | text       |
| nba_tweets           | date                    | text       |
| nba_tweets           | id                      | varchar    |
| nba_tweets           | len                     | int        |
| nba_tweets           | likes                   | int        |
| nba_tweets           | retweets                | int        |
| nba_tweets           | team                    | text       |
| nba_tweets           | Tweets                  | text       |
| NBA_Twitter          | #hashtag                | int        |
| NBA_Twitter          | account                 | text       |
| NBA_Twitter          | date                    | text       |
| NBA_Twitter          | id                      | bigint     |
| NBA_Twitter          | len                     | int        |
| NBA_Twitter          | likes                   | int        |
| NBA_Twitter          | N1                      | text       |
| NBA_Twitter          | N2                      | text       |
| NBA_Twitter          | N3                      | text       |
| NBA_Twitter          | retweets                | int        |
| NBA_Twitter          | team                    | text       |
| NBA_Twitter          | Tweets                  | text       |
| nba_twitter_accounts | Abbr                    | text       |
| nba_twitter_accounts | Account                 | text       |
| nba_twitter_accounts | Name                    | text       |
| new_age_perf         | age                     | int        |
| new_age_perf         | eff                     | double     |
| new_pop_hash         | c1                      | bigint     |
| new_pop_hash         | N1                      | text       |
| player_details       | BirthCity               | text       |
| player_details       | BirthDate               | text       |
| player_details       | College                 | text       |
| player_details       | ExperienceYear          | int        |
| player_details       | Height                  | int        |
| player_details       | JerseyNo                | int        |
| player_details       | Personid                | int        |
| player_details       | PhotoUrl                | text       |
| player_details       | PlayerName              | text       |
| player_details       | Pos                     | varchar    |
| player_details       | Team                    | text       |
| player_details       | Weight                  | int        |
| player_stats         | 3P%                     | double     |
| player_stats         | 3PA                     | double     |
| player_stats         | 3PM                     | double     |
| player_stats         | APG                     | double     |
| player_stats         | BPG                     | double     |
| player_stats         | DRB                     | double     |
| player_stats         | FG%                     | double     |
| player_stats         | FGA                     | double     |
| player_stats         | FGM                     | double     |
| player_stats         | FT%                     | double     |
| player_stats         | FTA                     | double     |
| player_stats         | FTM                     | double     |
| player_stats         | GP                      | int        |
| player_stats         | MPG                     | double     |
| player_stats         | ORB                     | double     |
| player_stats         | PF                      | double     |
| player_stats         | Player                  | text       |
| player_stats         | PPG                     | double     |
| player_stats         | RPG                     | double     |
| player_stats         | SPG                     | double     |
| player_stats         | Team                    | text       |
| player_stats         | TOV                     | double     |
| pop_hash             | N1                      | text       |
| pop_hash             | N2                      | text       |
| pop_hash             | N3                      | text       |
| POP_TEAM             | likes                   | int        |
| POP_TEAM             | team                    | text       |
| POP_TEAM             | Tweets                  | text       |
| Salary               | AllStar                 | text       |
| Salary               | Personid                | int        |
| Salary               | Salary                  | double     |
| Stats                | 3P%                     | double     |
| Stats                | 3PA                     | double     |
| Stats                | 3PM                     | double     |
| Stats                | APG                     | double     |
| Stats                | BPG                     | double     |
| Stats                | DRB                     | double     |
| Stats                | FG%                     | double     |
| Stats                | FGA                     | double     |
| Stats                | FGM                     | double     |
| Stats                | FT%                     | double     |
| Stats                | FTA                     | double     |
| Stats                | FTM                     | double     |
| Stats                | GP                      | int        |
| Stats                | MPG                     | double     |
| Stats                | ORB                     | double     |
| Stats                | Personid                | int        |
| Stats                | PF                      | double     |
| Stats                | PPG                     | double     |
| Stats                | RPG                     | double     |
| Stats                | SPG                     | double     |
| Stats                | TOV                     | double     |
| teamnames            | Team                    | varchar    |
| teamnames            | Team_Name               | text       |
| teamstats            | Assists                 | double     |
| teamstats            | Blocks                  | double     |
| teamstats            | DefensiveRebounds       | double     |
| teamstats            | FieldGoalsAttempted     | double     |
| teamstats            | FieldGoalsMade          | double     |
| teamstats            | FieldGoalsPercentage    | double     |
| teamstats            | Fouls                   | double     |
| teamstats            | FreeThrowsAttempted     | double     |
| teamstats            | FreeThrowsMade          | double     |
| teamstats            | FreeThrowsPercentage    | double     |
| teamstats            | Losses                  | int        |
| teamstats            | Minutes                 | int        |
| teamstats            | OffensiveRebounds       | double     |
| teamstats            | Points                  | double     |
| teamstats            | Rebounds                | double     |
| teamstats            | Steals                  | double     |
| teamstats            | Team                    | text       |
| teamstats            | ThreePointersAttempted  | double     |
| teamstats            | ThreePointersMade       | double     |
| teamstats            | ThreePointersPercentage | double     |
| teamstats            | Turnovers               | double     |
| teamstats            | TwoPointersAttempted    | double     |
| teamstats            | TwoPointersMade         | double     |
| teamstats            | TwoPointersPercentage   | double     |
| teamstats            | Wins                    | int        |
| top_players_team     | eff                     | double     |
| top_players_team     | Player                  | text       |
| top_players_team     | Team                    | text       |
| top_players_team     | win_percentage          | decimal    |
| Tweets               | #hashtag                | int        |
| Tweets               | account                 | text       |
| Tweets               | date                    | text       |
| Tweets               | id                      | varchar    |
| Tweets               | len                     | int        |
| Tweets               | likes                   | int        |
| Tweets               | retweets                | int        |
| Tweets               | Tweets                  | text       |
##### 4. find the top ten popular hashtags
>```mysql
>SELECT * FROM Hashtag;
>DROP PROCEDURE tenpophash;
>DELIMITER //
>CREATE PROCEDURE tenpophash()
>BEGIN
>  SELECT 
>        ht as hashtag, count(ht) as counts
>    FROM
>        Hashtag
>    GROUP BY hashtag
>    ORDER BY counts DESC
>    LIMIT 10;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>CALL tenpophash();
>```
Result:\
| hashtag            | counts |
|--------------------|--------|
| Knicks             |      3 |
| MileHighBasketball |      3 |
| Nuggets            |      3 |
| RipCity            |      3 |
| Rockets            |      3 |
| WizHornets         |      2 |
| NBA                |      2 |
| sixers             |      2 |
| TrueToAtlanta      |      2 |
| FearTheDeer        |      2 |

##### 5. Show the likes of each account
>```mysql
>SELECT * FROM Tweets;
>DROP PROCEDURE popaccount;
>DELIMITER //
>CREATE PROCEDURE popaccount()
>BEGIN
>  SELECT account , sum(likes) as pop
>  FROM Tweets
>  GROUP BY account
>  ORDER BY pop DESC;
>END;
>//
>DELIMITER ;
>```
Test:
>```mysql
>CALL popaccount();
>```
Result:\
| account          | pop    |
|------------------|--------|
| @Warriors        | 407761 |
| @Lakers          | 245205 |
| @Celtics         | 231208 |
| @Sixers          | 208038 |
| @OKCthunder      | 141801 |
| @Spurs           | 137395 |
| @Dallasmavs      | 116321 |
| @Raptors         | 109104 |
| @MiamiHeat       |  91720 |
| @HoustonRockets  |  89263 |
| @RoyceYoung      |  66444 |
| @ChicagoBulls    |  65694 |
| @BrooklynNets    |  62963 |
| @Timberwolves    |  59959 |
| @NYKnicks        |  57387 |
| @UtahJazz        |  54552 |
| @Trailblazers    |  48810 |
| @AnthonyVslater  |  47534 |
| @LaClippers      |  45907 |
| @LakersReporter  |  45222 |
| @Suns            |  42907 |
| @Taniaganguli    |  41038 |
| @Pacers          |  36543 |
| @Bucks           |  35199 |
| @Nuggets         |  34753 |
| @SacramentoKings |  32181 |
| @DetroitPistons  |  29054 |
| @Mike_bresnahan  |  27799 |
| @ATLHawks        |  24903 |
| @JLew1050        |  24097 |
| @OrlandoMagic    |  19763 |
| @WashWizards     |  16608 |
| @AdamHimmelsbach |  16573 |
| @ByJayKing       |  14178 |
| @Andyblarsen     |  14035 |
| @KellyIkoNBA     |  13470 |
| @memgrizz        |  12623 |
| @patboylanpacers |  11410 |
| @cavsjoeg        |  11273 |
| @StephNoh        |  10623 |
| @kcjhoop         |  10219 |
| @APOOCH          |  10108 |
| @DerekBodnerNBA  |   9866 |
| @Hornets         |   8018 |
| @PompeyOnSixers  |   7843 |
| @Samsmithhoops   |   7789 |
| @KatyWinge       |   7546 |
| @EthanJSkolnick  |   7535 |
| @ErikHorneOK     |   7351 |
| @joevardon       |   7262 |
| @DanWoikeSports  |   6979 |
| @ESefko          |   6624 |
| @Jonathan_Feigen |   6596 |
| @PelicansNBA     |   6432 |
| @Chrisadempsey   |   6396 |
| @CHold           |   6264 |
| @Sunscommunity   |   6247 |
| @Con_chron       |   6222 |
| @IraHeatBeat     |   6060 |
| @Matt_velazquez  |   5957 |
| @Tribjazz        |   5473 |
| @Wolstatsun      |   4968 |
| @Geoff_calkins   |   4888 |
| @JoshuaBRobbins  |   4760 |
| @Poundingtherock |   4727 |
| @JMcDonald_SAEN  |   4473 |
| @CvivlamoreAJC   |   4432 |
| @SmithRaps       |   4364 |
| @DetnewsRodBeard |   4234 |
| @MFollowill      |   4156 |
| @Keith_langlois  |   4001 |
| @Scottagness     |   3988 |
| @MikeVorkunov    |   3760 |
| @MikeGrich       |   3694 |
| @kayte_c         |   3603 |
| @TJMcBrideNBA    |   3563 |
| @SixersBeat      |   3026 |
| @MyMikeCheck     |   2951 |
| @ginamizell      |   2883 |
| @FredKatz        |   2874 |
| @ReedWallach     |   2830 |
| @DwainPrice      |   2644 |
| @PDcavsinsider   |   2606 |
| @GeraldBourguet  |   2179 |
| @CAGrizBeat      |   1911 |
| @NetsDaily       |   1865 |
| @Mcristaldi      |   1772 |
| @JohnDenton555   |   1576 |
| @Jim_Eichenhofer |   1571 |
| @ChristopherHine |   1351 |
| @mr_jasonjones   |   1306 |
| @FlyerGrizBlog   |   1292 |
| @CandaceDBuckner |   1228 |
| @Vincent_ellis56 |    827 |
| @PelicansCR      |    809 |
| @StevePopper     |    783 |
| @Rick_bonnell    |    708 |
| @cf_gardner      |    666 |
| @MRidenourABJ    |    567 |
| @atl_hawksnation |    501 |
| @JeffGSpursZone  |    501 |
| @Zacharysrosen   |    231 |
| @nuggetsnews     |    201 |


## Contribution
All by myself.

## References
Tutorial by Prof.Brown: [Link](https://github.com/nikbearbrown/INFO_6210/blob/master/Assingments/INFO_6210_SP19_Assignment_3.pdf)<br/>


