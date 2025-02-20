CREATE DATABASE WeatherDB;
GO

CREATE TABLE Cities (
    CityID INT PRIMARY KEY IDENTITY(1,1),
    CityName NVARCHAR(100),
    Country NVARCHAR(50),
    Latitude FLOAT,
    Longitude FLOAT
);


CREATE TABLE WeatherData (
    WeatherDataID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT,
    Temperature_Celsius FLOAT,
    Temperature_Fahrenheit FLOAT,
    FeelsLike_Celsius FLOAT,
    FeelsLike_Fahrenheit FLOAT,
    Pressure INT,
    Humidity INT,
    Visibility INT,
    DateTime DATETIME,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);



CREATE TABLE WindTable (
    WindID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT,
    WindSpeed FLOAT,
    WindDirection INT,
    WindGusts FLOAT,
    DateTime DATETIME,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);



CREATE TABLE RainTable (
    RainID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT,
    Rainfall_1h FLOAT,
    DateTime DATETIME,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);


CREATE TABLE WeatherConditions (
    ConditionID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT,
    ConditionDescription NVARCHAR(255),
    DateTime DATETIME,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);


SELECT * FROM Cities

SELECT * FROM WeatherData

SELECT * FROM WindTable

SELECT * FROM RainTable

SELECT * FROM WeatherConditions


--- Latest Weather Data for Each City
WITH LatestWeather AS (
    SELECT 
        wd.CityID, 
        wd.Temperature_Celsius, 
        wd.Humidity, 
        wt.WindSpeed, 
        wc.ConditionDescription, 
        wd.DateTime,
        ROW_NUMBER() OVER (PARTITION BY wd.CityID ORDER BY wd.DateTime DESC) AS rn
    FROM WeatherData wd
    JOIN WindTable wt ON wd.CityID = wt.CityID AND wd.DateTime = wt.DateTime
    JOIN WeatherConditions wc ON wd.CityID = wc.CityID AND wd.DateTime = wc.DateTime
)
SELECT 
    c.CityName, 
    c.Country, 
    lw.Temperature_Celsius, 
    lw.Humidity, 
    lw.WindSpeed, 
    lw.ConditionDescription, 
    lw.DateTime
FROM LatestWeather lw
JOIN Cities c ON lw.CityID = c.CityID
WHERE lw.rn = 1;



--- Average Weather Conditions per City Over the Last 7 Days
SELECT 
    c.CityName, 
    c.Country, 
    ROUND(AVG(wd.Temperature_Celsius), 2) AS Avg_Temperature_Celsius, 
    ROUND(AVG(wd.Humidity), 2) AS Avg_Humidity, 
    ROUND(AVG(wt.WindSpeed), 2) AS Avg_WindSpeed
FROM WeatherData wd
JOIN Cities c ON wd.CityID = c.CityID
JOIN WindTable wt ON wd.CityID = wt.CityID AND wd.DateTime = wt.DateTime
WHERE wd.DateTime >= DATEADD(DAY, -7, GETDATE())
GROUP BY c.CityName, c.Country
ORDER BY Avg_Temperature_Celsius DESC;



--- Cities with Temperatures Below Freezing (0°C)
SELECT 
    c.CityName, 
    c.Country, 
    wd.Temperature_Celsius, 
    wd.DateTime
FROM WeatherData wd
JOIN Cities c ON wd.CityID = c.CityID
WHERE wd.Temperature_Celsius < 0
ORDER BY wd.Temperature_Celsius ASC;
