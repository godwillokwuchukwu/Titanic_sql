-- Calculate the average age of passengers who survived and those who did not 
SELECT 
AVG(CASE WHEN [Survived] = 1 THEN [Age] END) AS Avg_Age_Of_Survivors,
AVG(CASE WHEN [Survived] = 0 THEN [Age] END) AS Avg_Age_Of_Non_Survivors
FROM [dbo].[train_clean];

-- Find the top 5 most common titles (e.g., Mr., Mrs., Miss) among the passengers 
SELECT TOP 5 [Title], COUNT(*) as No_Of_Passengers
FROM [dbo].[train_clean]
GROUP BY [Title]
ORDER BY No_Of_Passengers DESC;

-- Calculate the average fare paid by passengers in each passenger class (Pclass)
SELECT [Pclass], AVG([Fare]) AS Avg_Fare_Paid
FROM [dbo].[train_clean]
GROUP BY [Pclass]
ORDER BY Avg_Fare_Paid DESC;

-- Retrieve passengers with the highest and lowest fare 
SELECT [PassengerId], [Name], [Fare],
 CASE 
        WHEN [Fare] = (SELECT MAX([Fare]) FROM [dbo].[train_clean]) THEN 'Highest Fare'
        WHEN [Fare] = (SELECT MIN([Fare]) FROM [dbo].[train_clean]) THEN 'Lowest Fare'
    END AS Fare_Type
FROM 
    [dbo].[train_clean]
WHERE 
    [Fare] = (SELECT MAX([Fare]) FROM [dbo].[train_clean] )
    OR [Fare] = (SELECT MIN([Fare]) FROM [dbo].[train_clean])
ORDER BY Fare_Type;

-- Find the survival rate for male and female passengers
SELECT 
    [Sex],
    COUNT(*) AS Total_Passengers,
    COUNT(CASE WHEN [Survived] = 1 THEN 1 END) AS Survived, 
    ROUND(100.0 * COUNT(CASE WHEN [Survived] = 1 THEN 1 END) / COUNT(*), 2) AS Survival_Rate
FROM 
    [dbo].[train_clean]
GROUP BY 
    [Sex]
ORDER BY 
    [Sex];

-- Calculate the average family size (SibSp + Parch + 1) for passengers who survived and those who did not 
SELECT 
    [Survived],
    AVG([SibSp] + [Parch] + 1) AS Avg_Family_Size
FROM [dbo].[train_clean]
GROUP BY [Survived]
ORDER BY [Survived]; 

-- Retrieve the names of passengers whose age is missing (NULL) 
SELECT [Name]
FROM [dbo].[train_clean]
WHERE [Age] IS NULL;

-- Find the most common port of embarkation (Embarked) and its corresponding number of passengers 
SELECT TOP 1 [Embarked], COUNT(*) AS No_Of_Passengers
FROM [dbo].[train_clean]
GROUP BY [Embarked]
ORDER BY No_Of_Passengers;

-- Calculate the average age for passengers in each passenger class and gender combination
SELECT [Pclass], [Sex], AVG([Age]) AS Avg_Passenger_Age
FROM [dbo].[train_clean]
GROUP BY [Pclass], [Sex]
ORDER BY [Pclass], [Sex];

-- Retrieve passengers who were traveling alone (Family_Size = 1) and did not survive
SELECT [PassengerId],[Title], [Name], [Fare], [Sex], [Family_Size]
FROM [dbo].[train_clean]
WHERE [Family_Size] = 1
AND [Survived] = 0;