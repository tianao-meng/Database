DROP TABLE IF EXISTS `Batting`;
CREATE TABLE `Batting` (
  `playerID` varchar(255) DEFAULT NULL,
  `yearID` int(11) DEFAULT NULL,
  `stint` int(11) DEFAULT NULL,
  `teamID` varchar(255) DEFAULT NULL,
  `lgID` varchar(255) DEFAULT NULL,
  `G` int(11) DEFAULT NULL,
  `AB` int(11) DEFAULT NULL,
  `R` int(11) DEFAULT NULL,
  `H` int(11) DEFAULT NULL,
  `2B` int(11) DEFAULT NULL,
  `3B` int(11) DEFAULT NULL,
  `HR` int(11) DEFAULT NULL,
  `RBI` int(11) DEFAULT NULL,
  `SB` int(11) DEFAULT NULL,
  `CS` int(11) DEFAULT NULL,
  `BB` int(11) DEFAULT NULL,
  `SO` int(11) DEFAULT NULL,
  `IBB` varchar(255) DEFAULT NULL,
  `HBP` varchar(255) DEFAULT NULL,
  `SH` varchar(255) DEFAULT NULL,
  `SF` varchar(255) DEFAULT NULL,
  `GIDP` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

