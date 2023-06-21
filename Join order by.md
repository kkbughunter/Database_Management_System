
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
