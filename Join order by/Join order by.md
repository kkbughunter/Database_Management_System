## Use Assignment 1 Table [Query](https://github.com/KKBUGHUNTER/Database_Management_System/blob/main/Assignment_01/Assignment_01_sql_query.sql)
1. Calculate the total number of reservations for each boat:
```sql
SELECT boat_id, COUNT(*) AS ReservationCount FROM Reservation GROUP BY boat_id;
```

2. Find the tourists who have made reservations:
```sql
SELECT * FROM tourists INNER JOIN Reservation ON tourists.tourists_id = Reservation.tourists_id;
```

3. Retrieve the sailors and tourists who have made reservations together:
```sql
SELECT sailors.sailors_name, tourists.tourists_name
FROM sailors
INNER JOIN Reservation ON sailors.sailors_id = Reservation.sailors_id
INNER JOIN tourists ON Reservation.tourists_id = tourists.tourists_id;
```

4. Retrieve the details of sailors who have made reservations:
```sql
SELECT s.*
FROM sailors s
JOIN Reservation r ON s.sailors_id = r.sailors_id;
```

5. Find the boats reserved by tourists with a specific address:
```sql
SELECT b.*
FROM boat b
JOIN Reservation r ON b.boat_id = r.boat_id
JOIN tourists t ON r.tourists_id = t.tourists_id
WHERE t.tourists_address = 'Specific Address';
```

6. Get the sailors who have made reservations for a specific boat type:
```sql
SELECT s.*
FROM sailors s
JOIN Reservation r ON s.sailors_id = r.sailors_id
JOIN boat b ON r.boat_id = b.boat_id
WHERE b.boat_type = 'Specific Boat Type';
```

7. Retrieve the tourists who have made reservations along with the boat details:
```sql
SELECT t.*, b.*
FROM tourists t
JOIN Reservation r ON t.tourists_id = r.tourists_id
JOIN boat b ON r.boat_id = b.boat_id;
```

8. Find the sailors and tourists who have made reservations for the same boat:
```sql
SELECT s.*, t.*
FROM sailors s
JOIN Reservation r ON s.sailors_id = r.sailors_id
JOIN tourists t ON r.tourists_id = t.tourists_id
WHERE r.boat_id = 'Specific Boat ID';
```

## Use Assignment 3 Table [Query](https://github.com/KKBUGHUNTER/Database_Management_System/blob/main/Assignment_03/Assignment_03_sql_query.sql)
1. Find the count of cars per continent:
```sql
SELECT c.Continent, COUNT(*) AS CarCount
FROM CAR_MAKERS cm
JOIN COUNTRIES co ON cm.Country = co.CountryId
JOIN CONTINENTS c ON co.Continent = c.ContId
GROUP BY c.Continent;
```

2. Calculate the average MPG (Miles Per Gallon) for each car maker:
```sql
SELECT cm.Maker, AVG(cd.MPG) AS AvgMPG
FROM CAR_MAKERS cm
JOIN CAR_NAMES cn ON cm.makerId = cn.makerId
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY cm.Maker;
```

3. Determine the total weight and average horsepower for each car model:
```sql
SELECT md.Model, SUM(cd.Weights) AS TotalWeight, AVG(cd.Horsepower) AS AvgHorsepower
FROM MODEL_DETAILS md
JOIN CAR_NAMES cn ON md.ModelId = cn.Model
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY md.Model;
```

4. Get the count of cars produced by each country:
```sql
SELECT co.CountryName, COUNT(*) AS CarCount
FROM CAR_MAKERS cm
JOIN COUNTRIES co ON cm.Country = co.CountryId
GROUP BY co.CountryName;
```

5. Calculate the average MPG (Miles Per Gallon) and total weight of cars for each continent and country:
```sql
SELECT c.Continent, co.CountryName, AVG(cd.MPG) AS AvgMPG, SUM(cd.Weights) AS TotalWeight
FROM CAR_MAKERS cm
JOIN COUNTRIES co ON cm.Country = co.CountryId
JOIN CONTINENTS c ON co.Continent = c.ContId
JOIN CAR_NAMES cn ON cm.makerId = cn.makerId
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY c.Continent, co.CountryName;
```

6. Find the car maker with the highest number of models:
```sql
SELECT cm.Maker, COUNT(md.ModelId) AS ModelCount
FROM CAR_MAKERS cm
JOIN MODEL_DETAILS md ON cm.makerId = md.maker
GROUP BY cm.Maker
HAVING COUNT(md.ModelId) = (SELECT MAX(ModelCount) FROM (SELECT COUNT(ModelId) AS ModelCount FROM MODEL_DETAILS GROUP BY maker));
```

7. Calculate the average horsepower and cylinders for each unique car model and maker combination:
```sql
SELECT cm.Maker, md.Model, AVG(cd.Horsepower) AS AvgHorsepower, AVG(cd.Cylinders) AS AvgCylinders
FROM CAR_MAKERS cm
JOIN MODEL_DETAILS md ON cm.makerId = md.maker
JOIN CAR_NAMES cn ON md.ModelId = cn.Model
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY cm.Maker, md.Model;
```

8. Find the average MPG (Miles Per Gallon) and total count of cars for each unique combination of continent, country, and car maker:
```sql
SELECT c.Continent, co.CountryName, cm.Maker, AVG(cd.MPG) AS AvgMPG, COUNT(*) AS CarCount
FROM CONTINENTS c
JOIN COUNTRIES co ON c.ContId = co.Continent
JOIN CAR_MAKERS cm ON co.CountryId = cm.Country
JOIN CAR_NAMES cn ON cm.makerId = cn.makerId
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY c.Continent, co.CountryName, cm.Maker;
```

9. Calculate the maximum and minimum number of cylinders for each car model:
```sql
SELECT md.Model, MAX(cd.Cylinders) AS MaxCylinders, MIN(cd.Cylinders) AS MinCylinders
FROM MODEL_DETAILS md
JOIN CAR_NAMES cn ON md.ModelId = cn.Model
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY md.Model;
```

10. Find the average acceleration and total count of cars for each unique combination of continent, country, and car model:
```sql
SELECT c.Continent, co.CountryName, md.Model, AVG(cd.Accelerate) AS AvgAcceleration, COUNT(*) AS CarCount
FROM CONTINENTS c
JOIN COUNTRIES co ON c.ContId = co.Continent
JOIN CAR_MAKERS cm ON co.CountryId = cm.Country
JOIN MODEL_DETAILS md ON cm.makerId = md.maker
JOIN CAR_NAMES cn ON md.ModelId = cn.Model
JOIN CAR_DETAILS cd ON cn.makerId = cd.CarId
GROUP BY c.Continent, co.CountryName, md.Model;
```
