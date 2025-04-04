use ndap;


-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName -- Unique state names
FROM FarmersInsuranceData
ORDER BY srcStateName;
###

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
SELECT srcStateName,
    SUM(TotalFarmersCovered) AS total_farmers_covered,
    SUM(SumInsured) AS total_sum_insured
FROM 
    FarmersInsuranceData
GROUP BY 
    srcStateName
ORDER BY 
    total_farmers_covered DESC;
-- ###

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *
FROM FarmersInsuranceData
WHERE Year = '2020';
-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *
FROM FarmersInsuranceData 
WHERE 
    TotalPopulationRural > 1000000
    AND srcStateName = 'HIMACHAL PRADESH';

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName,
    srcDistrictName,
    SUM(FarmersPremiumAmount) AS total_farmers_premium
FROM 
    FarmersInsuranceData
WHERE 
    Year = 2018
GROUP BY 
    srcStateName,
    srcDistrictName
ORDER BY 
    total_farmers_premium ASC;

-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName,
    SUM(TotalFarmersCovered) AS total_farmers_covered,
    SUM(GrossPremiumAmountToBePaid) AS total_gross_premium
FROM 
    FarmersInsuranceData
WHERE 
    InsuredLandArea > 5.0
    AND Year = 2018
GROUP BY 
    srcStateName
ORDER BY 
    total_farmers_covered DESC;	  
-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
SELECT 
    srcYear,
    AVG(InsuredLandArea) AS avg_insured_land_area
FROM 
    FarmersInsuranceData
GROUP BY 
    srcYear
ORDER BY 
    srcYear;
-- Answer
#2021	39.291116625310195
#2020	47.89145238095237
#2019	39.105263157894754
#2018	37.94337786259541
-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcDistrictName,
    SUM(TotalFarmersCovered) AS total_farmers_covered
FROM 
    FarmersInsuranceData
WHERE 
    `Insurance units` > 0
GROUP BY 
    srcDistrictName
ORDER BY 
    total_farmers_covered DESC;

-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- ###
SELECT 
    srcStateName,
    SUM(FarmersPremiumAmount) AS total_farmers_premium,
    SUM(StatePremiumAmount) AS total_state_premium,
    SUM(GOVPremiumAmount) AS total_gov_premium,
    SUM(TotalFarmersCovered) AS total_farmers_covered
FROM 
    FarmersInsuranceData
WHERE 
SumInsured > 5 -- As scaling factor is 100000
    -- (SumInsured * 100000) > 500000  -- Applying scaling factor to Sum Insured
GROUP BY 
    srcStateName
ORDER BY 
    total_farmers_covered DESC;
-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT 
    srcDistrictName,
    TotalPopulation
FROM 
    FarmersInsuranceData
WHERE 
    Year = 2020
ORDER BY 
    TotalPopulation DESC
LIMIT 5;

-- ###

-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName, 
    srcDistrictName, 
    SumInsured 
FROM 
    FarmersInsuranceData 
WHERE 
    FarmersPremiumAmount > 0  -- Excluding zero values
ORDER BY 
    FarmersPremiumAmount ASC, 
    SumInsured ASC 
LIMIT 10;

###

-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName, 
    srcYear, 
    SUM(TotalFarmersCovered) AS total_farmers_covered, 
    SUM(TotalPopulation) AS total_population,
    (SUM(TotalFarmersCovered) * 1.0 / SUM(TotalPopulation)) AS insured_ratio
FROM 
    FarmersInsuranceData
WHERE 
    TotalPopulation > 0  -- Avoiding division by zero
GROUP BY 
    srcStateName, srcYear
ORDER BY 
    insured_ratio DESC
LIMIT 3;

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    DISTINCT srcStateName, 
    LEFT(srcStateName, 3) AS StateShortName
FROM 
    FarmersInsuranceData;
-- ###

-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcDistrictName 
FROM FarmersInsuranceData 
WHERE srcDistrictName LIKE 'B%';

-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName, srcDistrictName
FROM FarmersInsuranceData
WHERE srcDistrictName LIKE '%pur';
-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    f.srcStateName,
    f.srcDistrictName,
    f.srcYear,
    SUM(f.FarmersPremiumAmount) AS total_farmers_premium
FROM 
    FarmersInsuranceData f
INNER JOIN (
    SELECT 
        srcStateName,
        srcDistrictName,
        srcYear
    FROM 
        FarmersInsuranceData
    WHERE 
        `Insurance units` > 10
) filtered
ON 
    f.srcStateName = filtered.srcStateName AND
    f.srcDistrictName = filtered.srcDistrictName AND
    f.srcYear = filtered.srcYear
GROUP BY 
    f.srcStateName, f.srcDistrictName, f.srcYear
ORDER BY 
    total_farmers_premium DESC;

-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName,
    srcDistrictName,
    Year,
    TotalPopulation,
    MAX(FarmersPremiumAmount) * 100000 AS HighestFarmersPremiumAmount
FROM 
    FarmersInsuranceData
GROUP BY 
    srcStateName,
    srcDistrictName,
    Year,
    TotalPopulation
HAVING 
    MAX(FarmersPremiumAmount) * 100000 > 200000000  -- 20 crores
ORDER BY 
    HighestFarmersPremiumAmount DESC;


-- ###

-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    f.srcStateName,
    f.srcDistrictName,
    SUM(f.FarmersPremiumAmount) * 100000 AS TotalFarmersPremiumAmount,
    AVG(pop.AvgPopulation) AS AvgPopulation,
    SUM(f.TotalFarmersCovered) AS TotalFarmersCovered,
    SUM(f.SumInsured) * 100000 AS TotalSumInsured
FROM 
    FarmersInsuranceData f
LEFT JOIN (
    SELECT 
        srcStateName,
        srcDistrictName,
        AVG(TotalPopulation) AS AvgPopulation
    FROM 
        FarmersInsuranceData
    GROUP BY 
        srcStateName, srcDistrictName
) pop
ON 
    f.srcStateName = pop.srcStateName AND
    f.srcDistrictName = pop.srcDistrictName
GROUP BY 
    f.srcStateName, f.srcDistrictName
HAVING 
    TotalFarmersPremiumAmount > 1000000000  -- ₹100 crores after scaling
ORDER BY 
    TotalFarmersPremiumAmount DESC
LIMIT 100;

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcDistrictName,
    srcStateName,
    TotalFarmersCovered
FROM 
    FarmersInsuranceData
WHERE 
    TotalFarmersCovered > (
        SELECT 
            AVG(TotalFarmersCovered)
        FROM 
            FarmersInsuranceData
    )
ORDER BY 
    TotalFarmersCovered DESC;

-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- Step 1: Find the highest FarmersPremiumAmount and its corresponding SumInsured
-- Find the district with the highest FarmersPremiumAmount
SELECT srcStateName, srcDistrictName, FarmersPremiumAmount, SumInsured
FROM FarmersInsuranceData
ORDER BY FarmersPremiumAmount DESC
LIMIT 1;
-- Get the corresponding SumInsured value (scaled)
SELECT SUM(SumInsured) * 100000 AS TotalSumInsured
FROM FarmersInsuranceData
WHERE srcDistrictName = (
    SELECT srcDistrictName
    FROM FarmersInsuranceData
    ORDER BY FarmersPremiumAmount DESC
    LIMIT 1
);
-- Now find all states whose total SumInsured is greater than that value
SELECT srcStateName, SUM(SumInsured) * 100000 AS StateSumInsured
FROM FarmersInsuranceData
GROUP BY srcStateName
HAVING StateSumInsured > (
    SELECT SUM(SumInsured) * 100000
    FROM FarmersInsuranceData
    WHERE srcDistrictName = (
        SELECT srcDistrictName
        FROM FarmersInsuranceData
        ORDER BY FarmersPremiumAmount DESC
        LIMIT 1
    )
);

-- Combined Query:
SELECT 
    srcStateName, 
    SUM(SumInsured) * 100000 AS TotalStateSumInsured
FROM 
    FarmersInsuranceData
GROUP BY 
    srcStateName
HAVING 
    TotalStateSumInsured > (
        SELECT 
            SUM(SumInsured) * 100000
        FROM 
            FarmersInsuranceData
        WHERE 
            srcDistrictName = (
                SELECT 
                    srcDistrictName
                FROM 
                    FarmersInsuranceData
                ORDER BY 
                    FarmersPremiumAmount DESC
                LIMIT 1
            )
    );


-- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcDistrictName, 
    srcStateName, 
    FarmersPremiumAmount
FROM 
    FarmersInsuranceData
WHERE 
    FarmersPremiumAmount > (
        SELECT 
            AVG(FarmersPremiumAmount)
        FROM 
            FarmersInsuranceData
        WHERE 
            srcStateName = (
                SELECT 
                    srcStateName
                FROM 
                    FarmersInsuranceData
                GROUP BY 
                    srcStateName
                ORDER BY 
                    SUM(TotalPopulation) DESC
                LIMIT 1
            )
    );

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    ROW_NUMBER() OVER (ORDER BY TotalFarmersCovered DESC) AS row_num,
    srcStateName,
    srcDistrictName,
    TotalFarmersCovered
FROM 
    FarmersInsuranceData;

-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName,
    srcDistrictName,
    SumInsured,
    RANK() OVER (
        PARTITION BY srcStateName 
        ORDER BY SumInsured DESC
    ) AS rank_in_state
FROM 
    FarmersInsuranceData
ORDER BY 
    srcStateName ASC, rank_in_state ASC;

-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT 
    srcStateName,
    srcDistrictName,
    srcYear,
    FarmersPremiumAmount,
    SUM(FarmersPremiumAmount) OVER (
        PARTITION BY srcStateName, srcDistrictName 
        ORDER BY srcYear ASC
    ) AS cumulative_farmers_premium
FROM 
    FarmersInsuranceData
ORDER BY 
    srcStateName, srcDistrictName, srcYear;

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
DROP TABLE IF EXISTS states;
DROP TABLE IF EXISTS districts;
CREATE TABLE states (
    StateCode INT PRIMARY KEY,
    StateName TEXT NOT NULL
);

CREATE TABLE districts (
    DistrictCode INT PRIMARY KEY,
    DistrictName TEXT NOT NULL,
    StateCode INT,
    FOREIGN KEY (StateCode) REFERENCES states(StateCode)
);

-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
ALTER TABLE districts
ADD CONSTRAINT fk_statecode
FOREIGN KEY (StateCode) REFERENCES states(StateCode);

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SET SQL_SAFE_UPDATES = 0;
UPDATE FarmersInsuranceData
SET FarmersPremiumAmount = 500.0
WHERE rowID = 1;
SET SQL_SAFE_UPDATES = 1;
-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SET SQL_SAFE_UPDATES = 0;
UPDATE FarmersInsuranceData
SET Year = 2021
WHERE srcStateName = 'HIMACHAL PRADESH';
SET SQL_SAFE_UPDATES = 1;
-- ###

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT COUNT(*) FROM FarmersInsuranceData
WHERE Year = 2020;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM FarmersInsuranceData
WHERE TotalFarmersCovered < 10000
  AND Year = 2020;
SET SQL_SAFE_UPDATES = 1;
-- ###SELECT      srcStateName,     SUM(TotalFarmersCovered) AS total_farmers_covered,     SUM(GrossPremiumAmountToBePaid) AS total_gross_premium FROM      FarmersInsuranceData WHERE      InsuredLandArea > 5.0     AND Year = 2018 GROUP BY      srcStateName ORDER BY      total_farmers_covered DESC LIMIT 0, 50000
