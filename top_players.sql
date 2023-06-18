    #Creating the database where our tables will live
# CREATE DATABASE top_soccer;

    #Need to select which database we want to use before any further steps
# USE top_soccer;

    #Creating our table with the data we would like it to have
# CREATE TABLE player_info(
#    Name             VARCHAR(75) NOT NULL PRIMARY KEY
#   ,Full_Name        VARCHAR(150)
#   ,Position         VARCHAR(150) NOT NULL
#   ,League           VARCHAR(50) NOT NULL
#   ,Club             VARCHAR(75) NOT NULL
#   ,Shirt_number     INTEGER  NOT NULL
#   ,Agent            VARCHAR(75)
#   ,Joined_club      DATE  NOT NULL
#   ,Contract_expires DATE 
#   ,Market_value     NUMERIC(6,3)
#   ,Max_MarketValue  NUMERIC(6,3)
#   ,Outfitter        VARCHAR(75)
#   ,Age              INTEGER  NOT NULL
#   ,Height           NUMERIC(4,2)
#   ,Foot             VARCHAR(10)
#   ,Nationality      VARCHAR(150) NOT NULL
#   ,Birthplace       VARCHAR(150)
# );

    #Creating a second height column in feet for us Americans
# ALTER TABLE player_info
# ADD Height_feet DECIMAL(10,2);

    
    #Filling up our new height column with a simple multiplication equation
# UPDATE player_info 
# SET Height_feet = Height * 3.28084;

    #This gives me the names of the players and their respective height from shortes to tallest including only that data filled in 
# SELECT Name, Position, League, Height, Height_feet FROM player_info
#     WHERE Height IS NOT NULL
#     ORDER BY Height
#     LIMIT 20; 

    #This gives me the Top 10 shortest players and their respective position and league
# SELECT Name, League, Position, Height, Height_feet FROM player_info
#     WHERE Height IS NOT NULL
#     ORDER BY Height
#     LIMIT 10;

    #This gives me the positions that the top 5 shortest players play for
# SELECT Name, Position, Height_feet FROM player_info
#     WHERE Height IS NOT NULL
#     ORDER BY Height
#     LIMIT 5;

    #This tells me where the top 5 shortest players play  
# SELECT Name, League, Club, Height_feet FROM player_info
#     WHERE Height IS NOT NULL
#     ORDER BY Height
#     LIMIT 5;
    

    #This tells me how many players are in each league
# SELECT League, COUNT(*) FROM player_info
# # GROUP BY League
# #     ;

    #This tells me how many left-footed players are in the English Premier League
SELECT League, COUNT(*) FROM player_info
    WHERE League = 'EPL'
    AND Foot = 'left'
    LIMIT 5
    ;