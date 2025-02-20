***Weather Data Pipeline***

***Overview***

This project automates the retrieval and storage of real-time weather data from the OpenWeatherMap API into a Microsoft SQL Server database. It collects temperature, humidity, wind conditions, rainfall, and general weather descriptions for multiple cities and stores them in structured tables for further analysis.

***Features***

Fetches real-time weather data for multiple cities

Stores data in an SQL Server database

Records temperature, humidity, wind conditions, and weather descriptions

Supports Windows Authentication for database access

Uses Python (requests, pyodbc, and os modules) to interact with API and database

***Technologies Used***

Python: Data retrieval and database interaction

OpenWeatherMap API: Real-time weather data source

SQL Server: Database to store weather information

ODBC Driver 17 for SQL Server: Enables database connectivity

***Prerequisites****

Install Python (>=3.7 recommended)

Install required Python libraries:

pip install requests pyodbc

Set up an SQL Server database (WeatherDB) and execute the provided SQL script to create tables.

Obtain an API key from OpenWeatherMap and store it in an environment variable named user_api.

***Setup & Usage***

1. Configure Database

Execute the SQL script (weather_db_schema.sql) to create the necessary tables in your SQL Server instance.

2. Set Environment Variable

Set your API key as an environment variable:

For macOS/Linux: 

export user_api='your_api_key_here'

For Windows:

set user_api=your_api_key_here

3. Run the Script

Execute the Python script to fetch and store weather data:

python weather_data_pipeline.py

***Database Schema***

The following tables are used to store weather data:

Cities: Stores city names, country codes, and geographical coordinates.

WeatherData: Stores temperature, humidity, and visibility data.

WindTable: Stores wind speed, direction, and gusts.

RainTable: Records rainfall data.

WeatherConditions: Stores weather condition descriptions.

***Example Queries***

To retrieve the latest weather data for all cities:

SELECT c.CityName, wd.Temperature_Celsius, wd.Humidity, wc.ConditionDescription

FROM WeatherData wd

JOIN Cities c ON wd.CityID = c.CityID

JOIN WeatherConditions wc ON wd.CityID = wc.CityID;

***Future Enhancements***

Add support for more weather parameters.

Implement a scheduling mechanism to fetch data at regular intervals.

Develop a visualization dashboard using Power BI or Tableau.


For any questions or feedback, reach out via GitHub Issues or email me at philmens100@gmail.com

