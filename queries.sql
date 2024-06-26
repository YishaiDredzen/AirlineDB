--Query 1
SELECT f.FlightNumber, f.DepartureLocation, f.ArrivalLocation, f.DepartureTime, f.ArrivalTime, f.Capacity - COUNT(t.TicketNumber) AS AvailableSeats
FROM Flight f
LEFT JOIN Ticket t ON f.FlightNumber = t.FlightNumber
WHERE f.DepartureLocation = 'New York, USA'
GROUP BY f.FlightNumber;

--Query 2
SELECT FlightNumber, AVG(Price) AS AvgBusinessPrice
FROM Ticket
WHERE Class = 'Business'
GROUP BY FlightNumber
ORDER BY AvgBusinessPrice DESC;

--Query 3
SELECT p.Name, p.ContactInfo
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID
JOIN Ticket t ON b.TicketNumber = t.TicketNumber
JOIN Flight f ON t.FlightNumber = f.FlightNumber
WHERE f.ArrivalLocation = 'London, UK';

--Query 4
SELECT p.PassengerID, p.Name, SUM(b.Cost) AS TotalCost
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID
WHERE b.Status = 'Complete'
GROUP BY p.PassengerID
ORDER BY TotalCost DESC;

--Query 5
WITH DeletedBookings AS (
    DELETE FROM Booking
    WHERE Status = 'Cancelled'
    RETURNING *
)
SELECT COUNT(*) AS DeletedRows FROM DeletedBookings;

--Query 6
DELETE FROM Package 
WHERE CarModel = 'Chevrolet Corvette' 
  AND ReturnDate < CURRENT_DATE - INTERVAL '100 days';


--Query 7
UPDATE Ticket
SET Status = 'CheckedIn'
WHERE FlightNumber IN (
    SELECT FlightNumber
    FROM Flight
    WHERE DepartureTime::date = '2024-07-01'
);

--Query 8
UPDATE Ticket
SET SeatNumber = '12A'
WHERE TicketNumber = 1
AND EXISTS (
    SELECT 1
    FROM Seat
    WHERE FlightNumber = (SELECT FlightNumber FROM Ticket WHERE TicketNumber = 1)
    AND SeatNumber = '12A'
)
AND NOT EXISTS (
    SELECT 1
    FROM Ticket
    WHERE FlightNumber = (SELECT FlightNumber FROM Ticket WHERE TicketNumber = 1)
    AND SeatNumber = '12A');