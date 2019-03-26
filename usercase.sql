#usecases
-- 1.
-- Based on EFF of each player, user want to know 
-- what were the teams that top 10 players served
-- and their teams' performance

CREATE OR REPLACE VIEW Top_Players_Team AS
SELECT 
	-- NAME OF PLAYER
        p.Player
	-- EFF IS ((Points + Rebounds + Assists + Steals + Blocks) - ((Field Goals Att. - Field Goals Made) + (Free Throws Att. - Free Throws Made) + Turnovers))
        ,eff
	-- TEAM NAMES
        ,t.Team_Name
	-- WINS / (WINS + LOSSES)
        ,win_percentage
FROM (SELECT Team_Name
,Team
,Wins / (Wins + Losses) as win_percentage
FROM teamstats) t
JOIN (SELECT Player
, Team
, ((PPG+RPG+APG+SPG+BPG)-((FGA-FGM)+(FTA-FTM)+TOV)) as eff
FROM player_stats) p
ON t.Team = p.Team
ORDER BY eff DESC
LIMIT 10;  

-- 2.
-- create a view to show the average eff of each age 
CREATE OR REPLACE VIEW AGE_PERF AS
SELECT
	YEAR(CURDATE()) - YEAR(DATE_FORMAT(STR_TO_DATE(pd.BirthDate, '%m/%d/%Y'), "%Y-%m-%d")) AS age,
    sum((ps.PPG+ps.RPG+ps.APG+ps.SPG+ps.BPG)-((ps.FGA-ps.FGM)+(ps.FTA-ps.FTM)+ps.TOV))/count(ps.Player) as eff
    FROM player_details pd, player_stats ps
    WHERE pd.PlayerName = ps.Player
    group by age
    order by age ASC;

-- 3.
-- create a view to show the salaries of all-stars, AND their current team

CREATE OR REPLACE VIEW ALL_STAR_SALARY AS
SELECT 
	-- PLAYER NAME
		Player,
	-- TEAM NAME
		Team,
	-- SALARY OF PLAYER
        Salary
		FROM nba_salary
        WHERE Allstar = 'True';
        
-- 4.
-- Find the total likes of each teams' major twitter accounts.
-- This can show which team is currently the most popular team.
SELECT team,
	sum(likes)/count(Tweets) as pop
    FROM NBA_twitter
    group by team
    order by pop DESC
    limit 10;

-- What are the most liked Tweets of each of these 10 Teams
DROP TABLE if exists POP_TEAM; 
CREATE VIEW POP_TEAM AS
SELECT m.team,
	Tweets,
	likes
    From NBA_twitter n join(
    SELECT team,
	sum(likes)/count(Tweets) as pop
    FROM NBA_twitter
    group by team
    order by pop DESC
    limit 10
    )m on n.team = m.team
    order by likes DESC;
SELECT
	team,
	Tweets,
	likes
    From NBA_twitter n join(
    select max(likes) as lk
	from POP_TEAM
	group by team
	) p on n.likes = p.lk; 

-- 5.
-- Find the most used hashtags 
Create or replace view pop_hash as
SELECT distinct N1, count(N1) c1
FROM NBA_twitter
where N1 is not Null
group by N1
order by c1 DESC
limit 20
;
-- And what is the most popular hashtag

SELECT distinct N1, sum(likes) c1
FROM NBA_twitter
where N1 is not Null
group by N1
order by c1 DESC
limit 20
;
