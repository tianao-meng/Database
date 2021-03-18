SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `Emp`;
CREATE TABLE `Emp` (
  `empID` int NOT NULL,
  `first_name` varchar(100),
  `last_name` varchar(100),
  `middle_name` varchar(100),
  `job` varchar(100),
  `salary` int,
  PRIMARY KEY(`empID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

DROP TABLE IF EXISTS `Proj`;
CREATE TABLE `Proj` (
  `projID` int NOT NULL,
  `title` varchar(100),
  `budget` int,
  `funds` int,
  PRIMARY KEY(`projID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

DROP TABLE IF EXISTS `Dept`;
CREATE TABLE `Dept` (
  `deptID` int NOT NULL,
  `deptName` varchar(100),
  PRIMARY KEY(`deptID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;




DROP TABLE IF EXISTS `Belong`;
CREATE TABLE `Belong` (
  `empID` int,
  `deptID` int,
  FOREIGN KEY(`empID`) references Emp(`empID`),
  FOREIGN KEY(`deptID`) references Dept(`deptID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

DROP TABLE IF EXISTS `Assign`;
CREATE TABLE `Assign` (
  `empID` int,
  `projID` int,
  `role` varchar(100),
  FOREIGN KEY(`empID`) references Emp(`empID`),
  FOREIGN KEY(`projID`) references Proj(`projID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

DROP TABLE IF EXISTS `Location`;
CREATE TABLE `Location` (
  `deptID` int,
  `street_number` int,
  `street_name` varchar(100),
  `city_name` varchar(100),
  `province` varchar(100),
  `postal_code` varchar(100),
  FOREIGN KEY(`deptID`) references Dept(`deptID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
SET FOREIGN_KEY_CHECKS=1;


