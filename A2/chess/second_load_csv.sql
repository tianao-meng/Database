LOAD DATA LOCAL INFILE '/Users/mengtianao/Documents/ece656/MengTianao/A2/games_without_dupes.csv' INTO TABLE Second_chess
  FIELDS
    TERMINATED BY ','
  LINES
    TERMINATED BY '\n'
  IGNORE 1 LINES

  -- Put the numeric fields in user variables (names prefixed by @) to avoid warnings
  (Game_ID, Rated, Start_time, End_time, Number_of_Turns, Game_Status, Winner, Time_Increment, White_Player_ID, White_Player_Rating,
   Black_Player_ID, Black_Player_Rating, @moves, Opening_Eco, Opening_Name, Opening_Ply);

