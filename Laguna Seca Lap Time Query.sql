/*
CREATE DATABASE laguna_seca_project;
*/

USE laguna_seca_project;

/*
CREATE TABLE ls_data(
Vehicle VARCHAR(255), 
CarLink VARCHAR(255),
Time_SEC DECIMAL(5,2),
Power_HP INT,
Weight_KG INT,
Car_type VARCHAR(255),
Year INT,
Country_of_Origin VARCHAR(255),
Engine_type	VARCHAR(255),
Displacement DECIMAL(2,1),
Transmission VARCHAR(255),
Engine_Layout VARCHAR(255),
Drivetrain VARCHAR(255)
);
*/

/*
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LagunaSecaLapTimesDataset.csv'
INTO TABLE ls_data
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/

SELECT * FROM ls_data 
LIMIT 5;

/* 1. Top Performers: What are the top 5 lap times recorded at Laguna Seca Racetrack? - Which cars have achieved the fastest lap times? */
SELECT vehicle, Time_SEC 
FROM ls_data
ORDER BY Time_SEC
LIMIT 5;

/* Answer: 
Acura ARX-01b - 70.10 SECONDS
Porsche RS Spyder (Evo) - 70.35 SECONDS 
Acura ARX-01a - 70.91 SECONDS   
Audi R10 TDI - 71.17 SECONDS
Porsche RS Spyder -  74.03 SECONDS
*/

/*
2. Yearly Performance - How has the average lap time changed over the years? - Which year had the fastest average lap times?
*/
SELECT AVG(Time_SEC) AS average_time_sec, Year AS model_year FROM ls_data
GROUP BY model_year
ORDER BY model_year DESC
;
/*
Answer 1: Average Lap times have decreased over the years
*/

SELECT AVG(Time_SEC) AS average_time_sec, Year AS model_year FROM ls_data
GROUP BY model_year
ORDER BY average_time_sec 
;
/*
Answer 2: 2007 Has the lowest average lap time
*/

/*
3. Country Comparison: - What is the average lap time for cars from each country of origin? - Which country's cars, on average, perform the best at Laguna Seca?
*/
SELECT AVG(Time_SEC) AS average_time_sec, Country_of_origin
FROM ls_data
GROUP BY Country_of_Origin
ORDER BY average_time_sec
LIMIT 5;
/*
Answer: Italian cars seem to perform better lap times at Laguna Seca
*/

/*
4. Engine Analysis: - What is the distribution of engine types (Engine_type) in the dataset? - Is there a correlation between engine displacement and lap time?
*/
/*Answer 1:*/
SELECT AVG(Time_SEC) AS average_time_sec, Engine_type FROM ls_data
GROUP BY Engine_type 
ORDER BY average_time_sec
;

/*Answer 2:*/
SELECT 
(avg(Time_SEC * Engine_type) - avg(Time_SEC) * avg(Engine_type)) / 
(sqrt(avg(Time_SEC * Time_SEC) - avg(Time_SEC) * avg(Time_SEC)) * sqrt(avg(Engine_type * Engine_type) - avg(Engine_type) * avg(Engine_type))) *100
AS correlation_coefficient
FROM ls_data;
/*Answer 2: Correlation of 21.28 is on the lower end. Indicating that the engine type was a small factor to the record lap times*/

/*
5. Transmission Impact: - How do lap times vary between different types of transmissions? - Are cars with manual transmissions faster than automatic ones, on average?
*/
SELECT AVG(Time_SEC), Transmission FROM ls_data
GROUP BY Transmission
ORDER BY AVG(Time_SEC)
LIMIT 20
;
/*
Answer: Vehicles with Sequential Transmissions lead in shortest lap times followed by Dual Clutch Transmissions. Vehicles with manual transmissions are slower in comparison to automatic-type of transmissions and aren't even in the top 10 lap records. 
*/

/* 
6. Performance Over Time: - Are there any trends in lap times over the years? - Have cars generally become faster or slower at Laguna Seca?
*/
SELECT Year, AVG(Time_SEC) AS average_time_sec
FROM ls_data
GROUP BY Year
ORDER BY Year
;
/*
Answer: Over the years lap times have decreased and become faster. Although the record for fastest recorded laps was in 2007 the trend is shorter lap times as technology in cars advances.
*/

/*
7. Weight vs. Performance: - Is there a correlation between the weight of a car and its lap time? - Do lighter cars tend to have faster lap times?
*/
SELECT
(AVG(Weight_KG * Power_HP * Time_SEC) - AVG(Weight_KG) * AVG(Power_HP) * AVG(Time_SEC)) / 
(sqrt(AVG(Weight_KG * Weight_KG) - AVG(Weight_KG) * AVG(Weight_KG)) * sqrt(AVG(Power_HP * Power_HP) - AVG(Power_HP) * AVG(Power_HP)) * sqrt(AVG(Time_SEC * Time_SEC) - AVG(Time_SEC) * AVG(Time_SEC))) *100
AS correlation_coefficient
FROM ls_data;
/*
Answer: The correlation between weight, power and lap time is 65% or higher than moderate. This means that the lighter cars are along with higher horsepower can achieve faster lap times.
*/

/*
8. Drivetrain Performance: - How do lap times differ between different drivetrains? - Are rear-wheel-drive cars faster than front-wheel-drive cars
*/
SELECT AVG(Time_SEC) AS average_lap_time, Drivetrain 
FROM ls_data
GROUP BY Drivetrain
ORDER BY average_lap_time
;
/*
Answer: All wheel drive vehicles have faster lap times compared to rear wheel drive vehicles and front wheel drive vehicles. All wheel drive and rear wheel drive vehicles are head to head but All wheel drive vehicles have the upper advantage.
*/

/*
9. Car Type Impact: - What is the distribution of car types (Car_type) in the dataset? - Do certain types of cars consistently perform better than others?
*/
SELECT Car_type, COUNT(Car_type), AVG(Time_SEC) AS average_lap_time 
FROM ls_data
GROUP BY Car_type 
ORDER BY average_lap_time;
/*
Answer: 78% of the vehicles are coupes which also happen to have the lowest average lap time
*/

/*
10. Best in Class: - For each car type, what is the fastest lap time recorded? - Which car types dominate in terms of lap time performance?
*/
SELECT Car_type, MIN(Time_SEC) 
FROM ls_data
GROUP BY Car_type;
/*
Answer: Coupe's dominate the lap time performances with the record lap time of 70.10 seconds.
*/

