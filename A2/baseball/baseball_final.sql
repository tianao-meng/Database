-- 1)

-- without index
USE BASEBALL;
EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM Master
WHERE birthYear = '' or birthMonth = '' or birthDay = '';

-- with primary key
USE BASEBALL_PKFK;
SHOW INDEXES IN Master;

EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM Master
WHERE birthYear = '' or birthMonth = '' or birthDay = '';

-- add index birthYear, birthMonth, birhtDay
USE BASEBALL;
CREATE INDEX birthYear on Master(birthYear);
CREATE INDEX birthMonth on Master(birthMonth);
CREATE INDEX birthDay on Master(birthDay);
SHOW INDEXES IN Master;

EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM Master
WHERE birthYear = '' or birthMonth = '' or birthDay = '';

ALTER TABLE Master DROP INDEX birthYear;
ALTER TABLE Master DROP INDEX birthMonth;
ALTER TABLE Master DROP INDEX birthDay;

-- 2)

-- a

USE BASEBALL;
EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM HallOfFame;

-- with Primary key
ALTER TABLE HALLOFFAME ADD PRIMARY KEY (PLAYERID, YEARID, VOTEDBY);
SHOW INDEXES IN HALLOFFAME;
EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM HallOfFame;
ALTER TABLE HALLOFFAME DROP PRIMARY KEY;



-- with pk and fk
USE BASEBALL_PKFK;

SHOW INDEXES IN HALLOFFAME;

EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM HallOfFame;

-- add PLAYERID index;
USE BASEBALL;
CREATE INDEX PLAYERID on HALLOFFAME(PLAYERID);
SHOW INDEXES IN HALLOFFAME;

EXPLAIN SELECT COUNT(DISTINCT playerID)
FROM HallOfFame;

ALTER TABLE HALLOFFAME DROP INDEX PLAYERID;

-- b
USE BASEBALL;
SHOW INDEXES IN Master;
SHOW INDEXES IN HallOfFame;

EXPLAIN SELECT t1.category, t2.dead, t3.alive, t1.total, t1.fraction

FROM

(SELECT DISTINCT category,COUNT(DISTINCT playerID)/(SELECT COUNT(DISTINCT playerID) FROM HallOfFame) AS fraction, COUNT(DISTINCT playerID) AS total
FROM HallOfFame
group by category) t1

INNER JOIN

(SELECT DISTINCT category,Count(DISTINCT Master.playerID) AS dead
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay != '' and deathMonth != '' and deathYear != ''
group by category) t2

ON t1.category = t2.category

INNER JOIN


(SELECT DISTINCT category, Count(DISTINCT Master.playerID) AS alive
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay = '' and deathMonth = '' and deathYear = ''
group by category) t3

ON t1.category = t3.category;


-- only primary key

ALTER TABLE HALLOFFAME ADD PRIMARY KEY (PLAYERID, YEARID, VOTEDBY);
ALTER TABLE MASTER ADD PRIMARY KEY (PLAYERID);
SHOW INDEXES IN HALLOFFAME;
SHOW INDEXES IN Master;


EXPLAIN SELECT t1.category, t2.dead, t3.alive, t1.total, t1.fraction

FROM

(SELECT DISTINCT category,COUNT(DISTINCT playerID)/(SELECT COUNT(DISTINCT playerID) FROM HallOfFame) AS fraction, COUNT(DISTINCT playerID) AS total
FROM HallOfFame
group by category) t1

INNER JOIN

(SELECT DISTINCT category,Count(DISTINCT Master.playerID) AS dead
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay != '' and deathMonth != '' and deathYear != ''
group by category) t2

ON t1.category = t2.category

INNER JOIN


(SELECT DISTINCT category, Count(DISTINCT Master.playerID) AS alive
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay = '' and deathMonth = '' and deathYear = ''
group by category) t3

ON t1.category = t3.category;


ALTER TABLE HALLOFFAME DROP PRIMARY KEY;
ALTER TABLE MASTER DROP PRIMARY KEY;

-- with pk and fk

USE BASEBALL_PKFK;
SHOW INDEXES IN HALLOFFAME;
SHOW INDEXES IN Master;

EXPLAIN SELECT t1.category, t2.dead, t3.alive, t1.total, t1.fraction

FROM

(SELECT DISTINCT category,COUNT(DISTINCT playerID)/(SELECT COUNT(DISTINCT playerID) FROM HallOfFame) AS fraction, COUNT(DISTINCT playerID) AS total
FROM HallOfFame
group by category) t1

INNER JOIN

(SELECT DISTINCT category,Count(DISTINCT Master.playerID) AS dead
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay != '' and deathMonth != '' and deathYear != ''
group by category) t2

ON t1.category = t2.category

INNER JOIN


(SELECT DISTINCT category, Count(DISTINCT Master.playerID) AS alive
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay = '' and deathMonth = '' and deathYear = ''
group by category) t3

ON t1.category = t3.category;

-- using index on category
CREATE INDEX PLAYERID on HALLOFFAME(playerID);
CREATE INDEX Category on HallOfFame(category);
SHOW INDEXES IN HALLOFFAME;
SHOW INDEXES IN Master;

EXPLAIN SELECT t1.category, t2.dead, t3.alive, t1.total, t1.fraction

FROM

(SELECT DISTINCT category,COUNT(DISTINCT playerID)/(SELECT COUNT(DISTINCT playerID) FROM HallOfFame) AS fraction, COUNT(DISTINCT playerID) AS total
FROM HallOfFame
group by category) t1

INNER JOIN

(SELECT DISTINCT category,Count(DISTINCT Master.playerID) AS dead
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay != '' and deathMonth != '' and deathYear != ''
group by category) t2

ON t1.category = t2.category

INNER JOIN


(SELECT DISTINCT category, Count(DISTINCT Master.playerID) AS alive
FROM HallOfFame INNER JOIN Master
ON (HallOfFame.playerID = Master.playerID)
WHERE deathDay = '' and deathMonth = '' and deathYear = ''
group by category) t3

ON t1.category = t3.category;
ALTER TABLE HALLOFFAME DROP INDEX CATEGORY;
ALTER TABLE HALLOFFAME DROP INDEX PLAYERID;
-- 3)

-- a)

-- without any index

USE BASEBALL;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)


Order BY total DESC
LIMIT 3;

-- with pk

ALTER TABLE Salaries ADD PRIMARY KEY (yearID, teamID, playerID);
ALTER TABLE MASTER ADD PRIMARY KEY (PLAYERID);
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Master;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)


Order BY total DESC
LIMIT 3;


ALTER TABLE Salaries DROP PRIMARY KEY;
ALTER TABLE MASTER DROP PRIMARY KEY;

-- with pk and fk

USE BASEBALL_PKFK;
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Master;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)


Order BY total DESC
LIMIT 3;


-- b

-- players only

-- without any index

USE BASEBALL;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID IN (SELECT playerID FROM Master) AND playerID NOT IN (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


-- with pk


ALTER TABLE Salaries ADD PRIMARY KEY (yearID, teamID, playerID);
ALTER TABLE Managers ADD PRIMARY KEY (PLAYERID, YEARID, INSEASON);
ALTER TABLE MASTER ADD PRIMARY KEY (PLAYERID);
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID IN (SELECT playerID FROM Master) AND playerID NOT IN (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


ALTER TABLE Salaries DROP PRIMARY KEY;
ALTER TABLE Managers DROP PRIMARY KEY;
ALTER TABLE MASTER DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;
EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID IN (SELECT playerID FROM Master) AND playerID NOT IN (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;



-- managerss only

-- without any index

USE BASEBALL;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID in (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


-- with pk


ALTER TABLE Salaries ADD PRIMARY KEY (yearID, teamID, playerID);
ALTER TABLE Managers ADD PRIMARY KEY (PLAYERID, YEARID, INSEASON);
ALTER TABLE MASTER ADD PRIMARY KEY (PLAYERID);
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID in (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


ALTER TABLE Salaries DROP PRIMARY KEY;
ALTER TABLE Managers DROP PRIMARY KEY;
ALTER TABLE MASTER DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID in (SELECT playerID FROM Managers)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;






-- others

-- without any index

USE BASEBALL;

EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID not in (SELECT playerID FROM Managers) and playerID not in (SELECT playerID FROM Master)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


-- with pk


ALTER TABLE Salaries ADD PRIMARY KEY (yearID, teamID, playerID);
ALTER TABLE Managers ADD PRIMARY KEY (PLAYERID, YEARID, INSEASON);
ALTER TABLE MASTER ADD PRIMARY KEY (PLAYERID);
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;


EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID not in (SELECT playerID FROM Managers) and playerID not in (SELECT playerID FROM Master)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;


ALTER TABLE Salaries DROP PRIMARY KEY;
ALTER TABLE Managers DROP PRIMARY KEY;
ALTER TABLE MASTER DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Salaries;
SHOW INDEXES IN Managers;
SHOW INDEXES IN Master;


EXPLAIN SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

FROM

(SELECT DISTINCT playerID, SUM(salary) AS total
FROM Salaries
WHERE playerID not in (SELECT playerID FROM Managers) and playerID not in (SELECT playerID FROM Master)
group by playerID
) t1

INNER JOIN

(

SELECT playerID, nameFirst, nameLast, nameGiven
FROM Master

) t2

ON (t1.playerID = t2.playerID)

Order BY total DESC
LIMIT 3;



-- with index

-- d)

-- without any index

USE BASEBALL;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT playerID, SUM(HR) AS player_HR
FROM Batting
group by playerID) t1;


-- with pk


ALTER TABLE Batting ADD PRIMARY KEY (playerID, yearID, stint);
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT playerID, SUM(HR) AS player_HR
FROM Batting
group by playerID) t1;



ALTER TABLE Batting DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT playerID, SUM(HR) AS player_HR
FROM Batting
group by playerID) t1;




-- with index
USE BASEBALL_PKFK;
CREATE INDEX PLAYERID on Batting(playerID);
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT playerID, SUM(HR) AS player_HR
FROM Batting
group by playerID) t1;

ALTER TABLE Batting DROP INDEX PLAYERID;

-- e



-- without any index

USE BASEBALL;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
FROM Batting
group by Batting.playerID) t1
WHERE player_HR >= 1;


-- with pk


ALTER TABLE Batting ADD PRIMARY KEY (playerID, yearID, stint);
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
FROM Batting
group by Batting.playerID) t1
WHERE player_HR >= 1;



ALTER TABLE Batting DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
FROM Batting
group by Batting.playerID) t1
WHERE player_HR >= 1;




-- with index
USE BASEBALL;
CREATE INDEX PLAYERID on Batting(playerID);
CREATE INDEX HR on Batting(HR);
SHOW INDEXES IN Batting;

EXPLAIN SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
FROM Batting
group by Batting.playerID) t1
WHERE player_HR >= 1;



ALTER TABLE Batting DROP INDEX HR;

ALTER TABLE Batting DROP INDEX PLAYERID;


-- F
-- without any index

USE BASEBALL;

EXPLAIN SELECT COUNT(t6.playerID) AS Good_Player

FROM

((SELECT t1.playerID


FROM

(SELECT DISTINCT playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t1

WHERE (t1.player_HR >
    (SELECT AVG(t2.player_HR) AS HR FROM (SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t2))) t3

INNER JOIN

(SELECT t4.playerID


FROM

(SELECT DISTINCT playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t4

WHERE (t4.player_SHO >
    (SELECT AVG(t5.player_SHO) AS SHO FROM (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t5))) t6

ON t3.playerID = t6.playerID);


-- with pk


ALTER TABLE Batting ADD PRIMARY KEY (playerID, yearID, stint);
ALTER TABLE Pitching ADD PRIMARY KEY (playerID, yearID, stint);

SHOW INDEXES IN Batting;
SHOW INDEXES IN Pitching;

EXPLAIN SELECT COUNT(t6.playerID) AS Good_Player

FROM

((SELECT t1.playerID


FROM

(SELECT DISTINCT playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t1

WHERE (t1.player_HR >
    (SELECT AVG(t2.player_HR) AS HR FROM (SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t2))) t3

INNER JOIN

(SELECT t4.playerID


FROM

(SELECT DISTINCT playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t4

WHERE (t4.player_SHO >
    (SELECT AVG(t5.player_SHO) AS SHO FROM (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t5))) t6

ON t3.playerID = t6.playerID);



ALTER TABLE Batting DROP PRIMARY KEY;
ALTER TABLE Pitching DROP PRIMARY KEY;


-- with pk and fk
USE BASEBALL_PKFK;
SHOW INDEXES IN Batting;
SHOW INDEXES IN Pitching;



EXPLAIN SELECT COUNT(t6.playerID) AS Good_Player

FROM

((SELECT t1.playerID


FROM

(SELECT DISTINCT playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t1

WHERE (t1.player_HR >
    (SELECT AVG(t2.player_HR) AS HR FROM (SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t2))) t3

INNER JOIN

(SELECT t4.playerID


FROM

(SELECT DISTINCT playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t4

WHERE (t4.player_SHO >
    (SELECT AVG(t5.player_SHO) AS SHO FROM (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t5))) t6

ON t3.playerID = t6.playerID);


-- with index
USE BASEBALL_PKFK;
CREATE INDEX HR on Batting(HR);
CREATE INDEX SHO on Pitching(SHO);
CREATE INDEX PLAYERID on Batting(PLAYERID);
CREATE INDEX PLAYERID on Pitching(PLAYERID);


SHOW INDEXES IN Batting;
SHOW INDEXES IN Pitching;

EXPLAIN SELECT COUNT(t6.playerID) AS Good_Player

FROM

((SELECT t1.playerID


FROM

(SELECT DISTINCT playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t1

WHERE (t1.player_HR >
    (SELECT AVG(t2.player_HR) AS HR FROM (SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t2))) t3

INNER JOIN

(SELECT t4.playerID


FROM

(SELECT DISTINCT playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t4

WHERE (t4.player_SHO >
    (SELECT AVG(t5.player_SHO) AS SHO FROM (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t5))) t6

ON t3.playerID = t6.playerID);



ALTER TABLE Batting DROP INDEX HR;
ALTER TABLE Pitching DROP INDEX SHO;
ALTER TABLE Batting DROP INDEX PLAYERID;
ALTER TABLE Pitching DROP INDEX PLAYERID;
USE BASEBALL;
CREATE INDEX HR on Batting(HR);
CREATE INDEX SHO on Pitching(SHO);
CREATE INDEX PLAYERID on Batting(PLAYERID);
CREATE INDEX PLAYERID on Pitching(PLAYERID);


SHOW INDEXES IN Batting;
SHOW INDEXES IN Pitching;

EXPLAIN SELECT COUNT(t6.playerID) AS Good_Player

FROM

((SELECT t1.playerID


FROM

(SELECT DISTINCT playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t1

WHERE (t1.player_HR >
    (SELECT AVG(t2.player_HR) AS HR FROM (SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR FROM Batting group by Batting.playerID) t2))) t3

INNER JOIN

(SELECT t4.playerID


FROM

(SELECT DISTINCT playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t4

WHERE (t4.player_SHO >
    (SELECT AVG(t5.player_SHO) AS SHO FROM (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO FROM Pitching group by Pitching.playerID) t5))) t6

ON t3.playerID = t6.playerID);



ALTER TABLE Batting DROP INDEX HR;
ALTER TABLE Pitching DROP INDEX SHO;
ALTER TABLE Batting DROP INDEX PLAYERID;
ALTER TABLE Pitching DROP INDEX PLAYERID;




