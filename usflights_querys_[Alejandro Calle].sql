-- Primera consulta
SELECT COUNT(flightID) AS "Total Fligths" 
FROM usairlineflights.flights;

-- Segona consulta
SELECT Origin AS "Departure Airport Code", AVG(DepDelay) As "Average Departure Delay (min)", AVG(ArrDelay) AS "Average Arrival Delay (min)" 
FROM usairlineflights.flights 
GROUP BY Origin;

-- Tercera consulta
SELECT Origin AS "Departure Airport Code", colYear AS "Year", colMonth AS "Month", AVG(ArrDelay) AS "Average Arrival Delay (min)" 
FROM usairlineflights.flights 
GROUP BY colMonth, colYear, Origin 
ORDER BY Origin, colYear, colMonth;

-- Quarta consulta
SELECT City, colYear AS "Year", colMonth AS "Month", AVG(ArrDelay) AS "Average Arrival Delay (min)" 
FROM usairlineflights.flights 
LEFT OUTER JOIN usairlineflights.usairports 
ON usairlineflights.flights.Origin = usairlineflights.usairports.IATA 
GROUP BY colMonth, colYear, City 
ORDER BY City, colYear, colMonth;

-- Cinquena consulta
SELECT `Description` AS "Flight Company", COUNT(Cancelled) AS "Cancelled Flights" 
FROM usairlineflights.flights 
LEFT JOIN usairlineflights.carriers 
ON usairlineflights.flights.UniqueCarrier = usairlineflights.carriers.CarrierCode
WHERE CancellationCode = 'A' OR CancellationCode = 'NA'
GROUP BY `Description`
ORDER BY COUNT(Cancelled) DESC;

-- Sisena consulta
SELECT FlightID AS "Flight ID" -- , SUM(Distance) AS "Flight Distance (miles)" 
FROM usairlineflights.flights 
GROUP BY FlightID
ORDER BY SUM(Distance) DESC 
LIMIT 10;

-- Setena consulta
SELECT `Description` AS "Flight Company", AVG(DepDelay) AS "Average Departure Delay (min)" , AVG(ArrDelay) AS "Average Arrival Delay (min)"
FROM usairlineflights.flights
LEFT JOIN usairlineflights.carriers
ON usairlineflights.flights.UniqueCarrier = usairlineflights.carriers.CarrierCode
WHERE 
	(SELECT AVG(ArrDelay) FROM usairlineflights.flights
    WHERE usairlineflights.flights.UniqueCarrier = usairlineflights.carriers.CarrierCode) > 10.0
GROUP BY `Description`
ORDER BY AVG(ArrDelay) DESC;