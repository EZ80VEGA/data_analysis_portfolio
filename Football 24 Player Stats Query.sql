/*SHOW VARIABLES LIKE 'character_set_server';*/

/*SELECT default_character_set_name FROM information_schema.SCHEMATA WHERE schema_name = 'football_2024_player_stats';*/

/*SHOW FULL COLUMNS FROM player_stats;*/

/*To find directory to import files*/
/*SHOW VARIABLES LIKE "secure_file_priv";*/

/*Loading specified CSV file into the indicated table*/

/*
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Football24PlayerStatsDataset.csv'
INTO TABLE player_stats
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/

CREATE DATABASE Football_2024_Player_Stats;

/*Selecting the Database we want to work in*/
USE Football_2024_Player_Stats;

/*Deletes the table selected*/
DROP TABLE player_stats;

/*Shows list of tables are available*/
SHOW TABLES;

/*Creates a table with the specified columns and colum-types*/
CREATE TABLE Player_Stats(
player VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_general_ci,
country VARCHAR(250),
height INT,	
weight INT,
age INT,
club VARCHAR(250),
ball_control INT,
dribbling INT,
marking VARCHAR(250),
slide_tackle INT,
stand_tackle INT,
aggression INT,
reactions INT,
att_position INT,
interceptions INT,
vision INT,
composure INT,
crossing INT,
short_pass INT,
long_pass INT,
acceleration INT,
stamina INT,
strength INT,
balance INT,
sprint_speed INT,
agility INT,
jumping INT,
heading INT,
shot_power INT,
finishing INT,
long_shots INT,
curve INT,
fk_acc INT,
penalties INT,
volleys INT,
gk_positioning INT,
gk_diving INT,
gk_handling INT,
gk_kicking INT,
gk_reflexes INT,
value DECIMAL(12,2)
);

/*Shows us how the selected table is constructed*/
DESC player_stats;

/*Shows ALL the data within the selected table*/
SELECT * FROM player_stats
LIMIT 5;

/* 1. Club Comparison - Which club has the highest average value for its players in the dataset? */
SELECT TRIM(UPPER(club)) AS club, AVG(value) AS average_value /*TRIM removes leading/trailing spaces*/
FROM player_stats
GROUP BY TRIM(UPPER(club))
ORDER BY AVG(value) DESC
LIMIT 1;
/*Answer: Paris SG*/

/* 2. Age Distribution - What is the average age of players in the dataset, and how is the age distributed? */
SELECT AVG(age) 
FROM player_stats;
/* Average Age: 26.32 years*/

SELECT age, count(*)
FROM player_stats
GROUP BY age
ORDER BY count(*) DESC
LIMIT 10;
/* Distribution: Most players are between 21 and 31 years of age */

/* 3. Positional Dominance - Can you identify the country with the highest combined average ball control and dribbling skills? */

/* Using these two statements below to double check each individual column's average */
/*SELECT country, AVG(ball_control) AS ball_control_average  
FROM player_stats
GROUP BY country
ORDER BY ball_control_average DESC;
*/
/* SELECT country, AVG(dribbling)  AS dribbling_average
FROM player_stats
GROUP BY country
ORDER BY dribbling_average DESC;
*/

SELECT country, AVG(ball_control + dribbling) AS average_combined
FROM player_stats
GROUP BY country
ORDER BY average_combined DESC
LIMIT 1 ;
/* Jordan has the highest combined average ball control and dribbling skills with 151 */

/* 4. National Performance - Find the top three countries with the highest average player value. */ 
SELECT country, AVG(value) AS average_value,
FORMAT(AVG(value), 2) AS average_value_currency
FROM player_stats
GROUP BY country
ORDER BY average_value DESC
;

/* 5. Atrributes Correlation - Is there a strong correlation between reactions and shot power? */
/*
SELECT player, reactions, shot_power
FROM player_stats
ORDER BY reactions DESC
LIMIT 15;
*/
/*
SELECT player, reactions, shot_power
FROM player_stats
ORDER BY shot_power DESC
LIMIT 15;
*/
SELECT 
(avg(reactions * shot_power) - avg(reactions) * avg(shot_power)) / 
(sqrt(avg(reactions * reactions) - avg(reactions) * avg(reactions)) * sqrt(avg(shot_power * shot_power) - avg(shot_power) * avg(shot_power))) *100
AS correlation_coefficient
FROM player_stats;
/* Correlation: 0.52 or 52% is moderate */

/* 6. Height VS Heading - Analyze the relationship between a player's height and their heading ability. */
SELECT 
(avg(height * heading) - avg(height) * avg(heading)) / 
(sqrt(avg(height * height) - avg(height) * avg(height)) * sqrt(avg(heading * heading) - avg(heading) * avg(heading))) *100
AS correlation_coefficient
FROM player_stats;
/* Correlation/Relationship: 0.09 or 9% is low */

/* Just checking how these individually look
SELECT player, height, heading
FROM player_stats
ORDER BY height DESC
LIMIT 10;

SELECT player, height, heading
FROM player_stats
ORDER BY heading DESC
LIMIT 10;
*/

/* 8. Skillfull Player - Find the player with the highest overall skill (sum of ball control, dribbling, and vision). */
SELECT player, SUM(ball_control + dribbling + vision) AS skill_total
FROM player_stats
GROUP BY player
ORDER BY skill_total DESC
LIMIT 1;
/* Highest overall skillful player: Emmanuel Boateng at skill total of 564 */

/* 9. Defensive Prowess - Determine the top three players with the best defensive skills, considering marking, slide tackle, and stand tackle. */
SELECT player, club , AVG(marking + slide_tackle + stand_tackle) AS defense_total
FROM player_stats
GROUP BY player, club
ORDER BY defense_total DESC
LIMIT 3;
/* Top 3 Highest overall defensive players: Virgil Van Dijk at 177 for defense total, Kalidou Koulibaly at 175 for defense total, Dayot Upamecano at 172 for defense total */

/*10. Goalkeeper Analysis: - Identify the goalkeeper with the highest overall goalkeeping skills (sum of gk_positioning, gk_diving, gk_handling, gk_kicking, gk_reflexes).
 */
 SELECT player, club, AVG(gk_positioning + gk_diving + gk_handling +gk_kicking + gk_reflexes) AS gk_skills
FROM player_stats
GROUP BY player, club
ORDER BY gk_skills DESC
LIMIT 1;
/* GK with the highest overall goalkeeping skills is Gianluigi Donnarumma at 426 gk_skills */

/*11. Club Depth - Analyze the distribution of player values within each club – are there clear differences in the quality of players within the same club?*/
SELECT player, club, AVG(ball_control + dribbling + att_position + reactions + vision + short_pass + agility) AS average_qualities, value
FROM player_stats
GROUP BY player, club, value
ORDER BY club, average_qualities
LIMIT 50;

/* As player quality increases so does their value - clubs have varying quality of players this can be due to the level of competition they face too*/

/*12.	Age Group Analysis - Divide players into age groups (e.g., 18-24, 25-30, 31-35) and analyze the average values for each group. Are there any noticeable trends? */
SELECT
    CASE
        WHEN age BETWEEN 16 AND 22 THEN '16-22'
        WHEN age BETWEEN 23 AND 29 THEN '23-29'
        WHEN age BETWEEN 30 AND 35 THEN '30-35'
        WHEN age BETWEEN 36 AND 41 THEN '36-41'
        ELSE 'Other'
    END AS age_group,
    COUNT(*) AS player_count,
    FORMAT(AVG(value), 2) AS average_value
FROM
    Player_Stats
GROUP BY
    age_group
ORDER BY age_group;

/* Answer: As players age, they reach a peak in their value between 30-35 years of age then start declining. Also there is typically less players in this age group that are valued at 3.1 million. */ 




