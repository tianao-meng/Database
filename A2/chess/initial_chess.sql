DROP TABLE IF EXISTS `Initial_chess`;
-- show warnings;
CREATE TABLE `Initial_chess` (
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
  `moves` varchar(2000),
  `Opening_Eco` varchar(100),
  `Opening_Name` varchar(100),
  `Opening_Ply` int
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

