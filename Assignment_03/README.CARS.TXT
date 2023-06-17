*****************************************************
CS6312                                B Senthil Kumar
DBMS Lab		  Computer Science Department
         		   SSN College of Engineering 				                  
*****************************************************
		   CARS DATASET
                   Version 1.0
                  July 14, 2017
*****************************************************
Sources:
         The Committee on Statistical Graphics of 
         the American  Statistical Association (ASA)  
         1983 Cars dataset
******************************************************

This file describes the contents of the CARS dataset
developed for the CS6312, DBMS Lab course at SSN CE.

The dataset is a normalized and slightly enhanced version
of the ASA's Committee on Statistical Graphics "cars" 
dataset offered in 1983 for the visualization competition.

The dataset describes the origins and different parameters
of 406 car models produced in the world between 1970 and 1982.
The dataset consists of the following files:

General Conventions.

 1. The datatype of the columns need to match the data given.
 2. First line of each file provides the names of
    columns. Second line may be empty, or may contain
    the first row of the data
 3. All string values are enclosed in single quotes (')

  - car-makers   : information about companies that produce cars
  - car-names    : information about specific cars (by name)
  - car-details  : operational parameters of the cars
  - continents   : list of continents
  - countries    : list of countries 
  - model-details : information about car models produced by car makers


The core of the dataset consists of four relations: car-makers, model-details,
car-names and car-details.  The first table identifies companies
that produce cars (e.g, "Ford Motor Company", "Toyota"), the second table
lists various models and identified their makers (e.g., "Ford" and "Mercury" 
produced by Ford, "Oldsmobile" and "Chevrolet" produced by GM). The third
table is the masterlist of 406 car makes considered in the database
(e.g., "ford torino" or "amc rebel set"). The fourth table contains information
about the operating parameters (see below for a full list) for each make.


Individual relations(tables) have the following definition:


**************************************************************************

car-makers

          Id : unique identifier of the car maker
       Maker : short nickname for the car maker
    FullName : full name of the car maker
     Country : Id of the home country of the maker (see countries.CountryId)


**************************************************************************

car-names

              Id : unique identifier of the car make
           Model : name of the car model (see model-list.Model)
 MakeDescription : description (name) of the car make


**************************************************************************

car-details

            Id : unique identifier of the car make (see car-names.Id)
           MPG : milage per gallon
     Cylinders : number of cylinders
        Edispl : engine displacement volume in cubic inches
    Horsepower : power of the engine in horsepowers
        Weight : weight of the car in lbs
    Accelerate : time to accelerate from 0 to 60mph in seconds
          Year : year the car was made


**************************************************************************


continents
 
        ContId : unique identifier of the continent
     Continent : name of the continent


**************************************************************************

countries

     CountryId : unique identifier of the country
   CountryName : name of the country
     Continent : unique identifier of the continent the country is on 
                 (see continents.ContId)


**************************************************************************

model-details

    ModelId : unique identifier of the car model
      Maker : maker of the car (see car-makers.Id)
      Model : name of the car model (unique)



**************************************************************************
**************************************************************************







