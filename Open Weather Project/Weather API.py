import requests
import os
import pyodbc
from datetime import datetime

# SQL Server Connection
server = 'Philip'
database = 'WeatherDB'
driver = '{ODBC Driver 17 for SQL Server}'

# Use Windows Authentication (trusted connection)
connection = pyodbc.connect(f'DRIVER={driver};SERVER={server};DATABASE={database};Trusted_Connection=yes;')
cursor = connection.cursor()

user_api = os.environ['user_api']
locations = ["Las Vegas", "Phoenix", "Chicago", "New York", "Dallas", "Atlanta", "Los Angeles", "Seattle", "Denver", "Memphis"]

for i in locations:
    complete_api_link = f"https://api.openweathermap.org/data/2.5/weather?q={i}&appid={user_api}"
    api_link = requests.get(complete_api_link)
    api_data = api_link.json()

    if api_data['cod'] != 200:
        print(f"Error fetching data for {i}: {api_data['message']}")
        continue

    # Extracting data from API
    city_name = api_data['name']
    country = api_data['sys']['country']
    latitude = api_data['coord']['lat']
    longitude = api_data['coord']['lon']
    
    temp_kelvin = api_data['main']['temp']
    temperature_Celsius = round(temp_kelvin - 273.15, 2)
    temperature_Fahrenheit = round((temp_kelvin - 273.15) * 9/5 + 32, 2)
    feels_like_Celsius = round(api_data['main']['feels_like'] - 273.15, 2)
    feels_like_Fahrenheit = round((feels_like_Celsius * 9/5) + 32, 2)
    pressure = api_data['main']['pressure']
    humidity = api_data['main']['humidity']
    visibility = api_data['visibility']
    date_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    wind_speed = api_data['wind']['speed']
    wind_direction = api_data['wind']['deg']
    wind_gusts = api_data['wind'].get('gust', 0)
    
    rain_1h = api_data.get('rain', {}).get('1h', 0)
    weather_description = api_data['weather'][0]['description']

    # Insert city data
    cursor.execute("""
        INSERT INTO Cities (CityName, Country, Latitude, Longitude)
        VALUES (?, ?, ?, ?)
    """, (city_name, country, latitude, longitude))
    
    # Get the CityID for the inserted city
    cursor.execute("SELECT CityID FROM Cities WHERE CityName = ? AND Country = ?", (city_name, country))
    city_id = cursor.fetchone()[0]
    
    # Insert weather data
    cursor.execute("""
        INSERT INTO WeatherData (CityID, Temperature_Celsius, Temperature_Fahrenheit, FeelsLike_Celsius, FeelsLike_Fahrenheit, 
        Pressure, Humidity, Visibility, DateTime)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (city_id, temperature_Celsius, temperature_Fahrenheit, feels_like_Celsius, feels_like_Fahrenheit,
          pressure, humidity, visibility, date_time))
    
    # Insert wind data
    cursor.execute("""
        INSERT INTO WindTable (CityID, WindSpeed, WindDirection, WindGusts, DateTime)
        VALUES (?, ?, ?, ?, ?)
    """, (city_id, wind_speed, wind_direction, wind_gusts, date_time))

    # Insert rain data
    cursor.execute("""
        INSERT INTO RainTable (CityID, Rainfall_1h, DateTime)
        VALUES (?, ?, ?)
    """, (city_id, rain_1h, date_time))

    # Insert weather condition data
    cursor.execute("""
        INSERT INTO WeatherConditions (CityID, ConditionDescription, DateTime)
        VALUES (?, ?, ?)
    """, (city_id, weather_description, date_time))

# Commit changes and close the connection
connection.commit()
cursor.close()
connection.close()

print("\nWeather data for all cities stored in SQL Server successfully!")
