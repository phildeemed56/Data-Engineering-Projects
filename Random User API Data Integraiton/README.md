**Project Overview**

This project demonstrates how to fetch, process, and load data from the RandomUser API into a SQL Server database using two different approaches: C# and SQL Server Integration Services (SSIS). The goal is to showcase the same logic for processing the data in both environments. The project includes the necessary SQL schema for creating a database and table to store the fetched data.

**Key Features**

***Dual Execution Platforms:*** The same JSON data processing logic can be executed in both a C# environment and within an SSIS package.

***RandomUser API:*** The RandomUser API provides randomly generated user data in JSON format, which is then processed and inserted into the database.

***Database Integration:*** The project includes SQL scripts for creating a table to store the processed data in SQL Server.


**Description of the RandomUser API**

The RandomUser API is a free API that generates random user profiles. Each profile consists of a variety of fields that include personal information, contact details, and geographical data. These data points are returned in a structured JSON format and are used in this project for data processing and insertion into SQL Server.

The key data fields in the RandomUser API response include:

***Personal Information:*** Name, gender, username, email, phone number, date of birth, and nationality.

***Address Information:*** Street address, city, state, country, postcode.

***Location:*** Latitude and longitude coordinates.

***Pictures:*** Profile image links (large, medium, and thumbnail).

***Timezone:*** Timezone offset and description.

This project uses these fields to populate a table in SQL Server with user data retrieved from the API.


**Code Overview**

The project code is designed to process the JSON response from the RandomUser API and insert the relevant data into a SQL Server database. There are two primary execution paths for running the code:

***C# Execution:*** A standalone C# application that fetches the JSON data, processes it, and inserts the data into the database.

***SSIS Execution:*** A Script Task within an SSIS package that performs the same logic of fetching and processing the JSON data.


**C# Execution Flow**

The C# script in the project follows this flow:

***Fetch Data:*** A GET request is sent to the RandomUser API to fetch random user data in JSON format.

***Deserialize JSON:*** The JSON response is deserialized into C# objects using the Newtonsoft.Json library.

***Data Transformation:*** Relevant fields are extracted, and transformations (such as parsing dates and handling nested objects) are applied.

***Insert into Database:*** The processed data is inserted into the RandomUsers table in SQL Server using SQL commands or an ORM like Entity Framework.


**SSIS Execution Flow**

The SSIS version follows a similar structure but is embedded within a Script Task:

***Add Newtonsoft.Json:*** Before running the SSIS package, the Newtonsoft.Json library must be added to the Global Assembly Cache (GAC).

***Script Task:*** The C# code is copied into an SSIS Script Task, where it is executed within the SSIS package.

***Run SSIS Package:*** The SSIS package fetches the data from the RandomUser API, processes it, and loads it into SQL Server.


**Loading Data into SQL Server**

After processing the JSON data, the next step is to load it into SQL Server. This project includes an SQL schema that defines the structure of the RandomUsers table.

**SQL Schema**

The schema to create the RandomUsers table is provided below. This table will store the data fetched from the RandomUser API.

**Database Setup**

1. Open SQL Server Management Studio (SSMS).

2. Connect to your SQL Server instance.

3. Create a new database or select an existing one.

4. Execute the above script to create the RandomUsers table.

5. After the table is created, you can use SQL queries to verify the structure:


**Running the Code in C#**

To run the project in C#:

1. Open the C# project in Visual Studio.

2. Make sure the Newtonsoft.Json package is installed via NuGet.

3. Run the application. It will fetch data from the RandomUser API, process it, and insert it into the SQL Server RandomUsers table.


**Steps to Execute in C#:**

The code will use HttpClient to send a GET request to the RandomUser API.

The response is deserialized using JsonConvert.DeserializeObject<T>.

A connection is made to SQL Server using SqlConnection.

The data is inserted into the database using SQL INSERT statements.


**Running the Code in SSIS**

***1. To run the project in SSIS, follow these steps:***

Add the Newtonsoft.Json Assembly to SSIS:

Locate the path to Newtonsoft.Json.dll on your system.

Open the Developer Command Prompt for Visual Studio.

Run the following command to add it to the Global Assembly Cache (GAC): gacutil -i 'path_to_newtonsoft_json.dll'

***2. Set Up the SSIS Package:***

Open SQL Server Data Tools and create a new SSIS package.

Add a Script Task to the control flow.

In the Script Task editor, set the language to C#.

Paste the C# code into the editor, modifying it if necessary to match your SSIS environment.

***3.Run the SSIS Package:***

Execute the SSIS package. The Script Task will fetch the data from the RandomUser API, process it, and load it into the RandomUsers table in SQL Server.


**Conclusion**

This project showcases how to integrate and process data from the RandomUser API using both C# and SSIS. It demonstrates the versatility of working with external data sources and integrating them into SQL Server. Whether you're working in a standalone C# application or within an SSIS package, this project provides a clear example of how to manage and transform API data for use in a relational database.











