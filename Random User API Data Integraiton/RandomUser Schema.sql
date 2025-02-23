-- Create the simplified table
CREATE TABLE RandomUsers (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Gender NVARCHAR(10),
    Title NVARCHAR(10),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Username NVARCHAR(50),
    DateOfBirth DATE,
    Age INT,
    RegisteredDate DATE,
    RegisteredAge INT,
    Phone NVARCHAR(20),
    Cell NVARCHAR(20),
    NationalID NVARCHAR(50),
    StreetNumber INT,
    StreetName NVARCHAR(100),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Country NVARCHAR(50),
    Postcode NVARCHAR(20),
    Latitude NVARCHAR(50),
    Longitude NVARCHAR(50),
    TimezoneOffset NVARCHAR(10),
    TimezoneDescription NVARCHAR(100),
    PictureLarge NVARCHAR(200),
    PictureMedium NVARCHAR(200),
    PictureThumbnail NVARCHAR(200),
    Nationality NVARCHAR(5)
);
GO







