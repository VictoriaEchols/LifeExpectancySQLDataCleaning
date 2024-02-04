-- World Life Expectancy Exploratory Project 

SELECT *
FROM world_life_expectancy
;

-- Which countries have increased their life expectancy the most? 
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;
-- Zimbabwe (MIN 44.3, MAX 67), Zambia (MIN 43.8, MAX 63), Yemen (MIN 61.1, MAX 68)



-- What country has the biggest difference in their life expectancy?
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;
-- Haiti (28.7 years), Zimbabwe (22.7 years), Eritrea (21.7 years)


-- What is the average life expectancy per year?
SELECT Year, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;
-- As a world, there was about a 6 year increase in life expectancy



-- Correlation between life expectancy and GDP
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;
-- Lower GDPs are correlated with lower life expectancies

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;


-- Count of countries involved/ Correllation between 'Status' of country and 'Life Expectancy'
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;
-- Developed: 32 countries/ 79.2 years
-- Developing 161 countries/ 66.8 years

-- Correlation between BMI and Life Expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;
-- Lower BMI, Lower Life Expectancy


SELECT Country,
Year, 
`Life Expectancy`
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
;