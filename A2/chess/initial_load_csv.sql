LOAD DATA LOCAL INFILE '/Users/mengtianao/Documents/ece656/MengTianao/A2/games_without_dupes.csv' INTO TABLE Initial_chess
  FIELDS
    TERMINATED BY ','
  LINES
    TERMINATED BY '\n'
  IGNORE 1 LINES

  -- Put the numeric fields in user variables (names prefixed by @) to avoid warnings
  (Game_ID, Rated, Start_time, End_time, Number_of_Turns, Game_Status, Winner, Time_Increment, White_Player_ID, White_Player_Rating,
   Black_Player_ID, Black_Player_Rating, moves, Opening_Eco, Opening_Name, Opening_Ply);
show warnings;

  -- Now check for empty strings and set the numeric columns to null if they're found
  -- set teamID = if(@teamID="", null, @teamID),
  -- lgID = if(@lgID="", null, @lgID),
  -- G = if(@G="", null, @G),
  -- AB = if(@AB="", null, @AB),
  -- R = if(@R="", null, @R),
  -- H = if(@H="", null, @H),
  -- 2B = if(@2B="", null, @2B),
  -- 3B = if(@3B="", null, @3B),
  -- HR = if(@HR="", null, @HR),
  -- RBI = if(@RBI="", null, @RBI),
  -- SB = if(@SB="", null, @SB),
  -- CS = if(@CS="", null, @CS),
  -- BB = if(@BB="", null, @BB),
  -- SO = if(@SO="", null, @SO)

