-- US HOUSEHOLD INCOME EXPLORATORY DATA ANALYSIS

SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;

SELECT 
	state_name, 
    SUM(aland), 
    SUM(awater)
FROM us_project.us_household_income
GROUP BY state_name
ORDER BY SUM(aland) DESC
LIMIT 10;

SELECT 
	state_name, 
    SUM(aland), 
    SUM(awater)
FROM us_project.us_household_income
GROUP BY state_name
ORDER BY SUM(awater) DESC
LIMIT 10;

SELECT *
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id;
        
SELECT *
FROM us_project.us_household_income AS u
	RIGHT JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
WHERE u.id IS NULL;

SELECT *
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
WHERE mean <> 0;

SELECT 
	u.state_name, 
    county, 
    type, 
    `primary`, 
    mean, 
    median
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
WHERE mean <> 0;

SELECT 
	u.state_name, 
    ROUND(AVG(mean), 1), 
    ROUND(AVG(median), 1)
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
WHERE mean <> 0
GROUP BY u.state_name
ORDER BY 2 DESC
LIMIT 10;

SELECT 
	type,
    COUNT(type),
    ROUND(AVG(mean), 1), 
    ROUND(AVG(median), 1)
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
WHERE mean <> 0
GROUP BY type
	HAVING COUNT(type) > 100
ORDER BY 4 DESC
LIMIT 15;

SELECT *
FROM us_household_income
WHERE type = 'community';

SELECT 
	u.state_name, 
    city, 
    ROUND(AVG(mean), 1), 
    ROUND(AVG(median), 1)
FROM us_project.us_household_income AS u
	JOIN us_project.us_household_income_statistics AS us
		ON u.id = us.id
GROUP BY u.state_name, city
ORDER BY ROUND(AVG(mean), 1) DESC;