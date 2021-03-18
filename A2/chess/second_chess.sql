SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `Second_chess`;
-- show warnings;
CREATE TABLE `Second_chess` (
  `Game_ID` varchar(100),
  `Rated` varchar(100),
  `Start_time` varchar(100),
  `End_time` varchar(100),
  `Number_of_Turns` int,
  `Game_Status` varchar(100),
  `Winner` varchar(100),
  `Time_Increment` varchar(100),
  `White_Player_ID` varchar(100),
  `White_Player_Rating` int,
  `Black_Player_ID` varchar(100),
  `Black_Player_Rating` int,
  `Opening_Eco` varchar(100),
  `Opening_Name` varchar(100),
  `Opening_Ply` int,
  primary key(`Game_ID`,`Start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
SET FOREIGN_KEY_CHECKS=1;
