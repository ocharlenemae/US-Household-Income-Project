-- US HOUSEHOLD INCOMCE DATA CLEANING

SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;

ALTER TABLE us_project.us_household_income_statistics 
RENAME COLUMN `ï»¿id` TO `id`;

SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

SELECT 
	id, 
    COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

SELECT row_id
FROM (
	SELECT 
		row_id, 
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_project.us_household_income
	) AS duplicates
WHERE row_num > 1;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT 
			row_id, 
			id, 
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
		) AS duplicates
	WHERE row_num > 1);
    
SELECT 
	id, 
    COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;

SELECT state_name, COUNT(state_name)
FROM us_project.us_household_income
GROUP BY state_name;

SELECT DISTINCT state_name
FROM us_project.us_household_income
ORDER BY state_name;

UPDATE us_project.us_household_income
SET state_name = 'Georgia'
WHERE state_name = 'georia';

UPDATE us_project.us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama';

SELECT DISTINCT state_ab
FROM us_project.us_household_income
ORDER BY state_ab;

SELECT *
FROM us_project.us_household_income
WHERE place = '';

SELECT *
FROM us_project.us_household_income
WHERE county = 'Autauga County';

UPDATE us_household_income
SET place = 'Autaugaville'
WHERE county = 'Autauga County' AND city = 'Vinemont';

SELECT type, COUNT(type)
FROM us_project.us_household_income
GROUP BY type
ORDER BY type;

UPDATE us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs';

SELECT ALand, AWater
FROM us_project.us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL;

SELECT DISTINCT AWater
FROM us_project.us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL;

SELECT ALand, AWater
FROM us_project.us_household_income
WHERE 
	(AWater = 0 OR AWater = '' OR AWater IS NULL)
    AND (ALand = 0 OR ALand = '' OR ALand IS NULL);
    
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL);