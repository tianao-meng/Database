LOAD DATA LOCAL INFILE 'Batting.csv' INTO TABLE Batting
  FIELDS
    TERMINATED BY ','
  LINES
    TERMINATED BY '\n'
  IGNORE 1 LINES

  -- Put the numeric fields in user variables (names prefixed by @) to avoid warnings
  (playerID, yearID, stint, @teamID, @lgID, @G, @AB, @R, @H, @2B, @3B,
   @HR, @RBI, @SB, @CS, @BB, @SO, IBB, HBP, SH, SF, GIDP)

  -- Now check for empty strings and set the numeric columns to null if they're found
  set teamID = if(@teamID="", null, @teamID),
  lgID = if(@lgID="", null, @lgID),
  G = if(@G="", null, @G),
  AB = if(@AB="", null, @AB),
  R = if(@R="", null, @R),
  H = if(@H="", null, @H),
  2B = if(@2B="", null, @2B),
  3B = if(@3B="", null, @3B),
  HR = if(@HR="", null, @HR),
  RBI = if(@RBI="", null, @RBI),
  SB = if(@SB="", null, @SB),
  CS = if(@CS="", null, @CS),
  BB = if(@BB="", null, @BB),
  SO = if(@SO="", null, @SO)

