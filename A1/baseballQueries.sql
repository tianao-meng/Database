-- Q1
SELECT COUNT(playerID)
FROM Master
WHERE birthYear = '' or birthMonth = '' or birthDay = '';

-- Q2
-- 1)

SELECT COUNT(DISTINCT playerID)
FROM HallOfFame;

-- 2)

SELECT t1.category, t2.dead, t3.alive, t1.total, t1.fraction

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

-- Q3

-- 1)

SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

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

-- 2) only player

SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

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

-- 3) only Managers

SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

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


-- 3) Other

SELECT t2.nameFirst, t2.nameLast, t2.nameGiven, total

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

-- Q4 HomeRun per player

-- SELECT (SUM(t1.player_HR) / COUNT(t1.playerID)) AS HR
SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT playerID, SUM(HR) AS player_HR
FROM Batting
group by playerID) t1;

-- Q5

-- SELECT (SUM(t1.player_HR) / COUNT(t1.playerID)) AS HR
SELECT AVG(player_HR) AS HR

FROM

(SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
FROM Batting
group by Batting.playerID) t1
WHERE player_HR >= 1;

-- Q6

SELECT COUNT(t6.playerID) AS Good_Player

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



-- ((SELECT DISTINCT Batting.playerID, SUM(Batting.HR) AS player_HR
-- FROM Batting
-- group by Batting.playerID) t1

-- INNER JOIN

-- (SELECT DISTINCT Pitching.playerID, SUM(Pitching.SHO) AS player_SHO
-- FROM Pitching
-- group by Pitching.playerID) t2

-- ON t2.playerID = t1.playerID)

-- WHERE (player_HR > AVG(player_HR)) AND (player_SHO > AVG(player_SHO));

-- WHERE (t1.player_HR > t3.HR) AND (t2.player_SHO > t3.SHO);








