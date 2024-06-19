SELECT f.FlightNumber, f.DepartureLocation, f.ArrivalLocation, f.DepartureTime, f.ArrivalTime, f.Capacity - COUNT(t.TicketNumber) AS AvailableSeats
FROM Flight f
LEFT JOIN Ticket t ON f.FlightNumber = t.FlightNumber
WHERE f.DepartureLocation = 'New York, USA'
GROUP BY f.FlightNumber;


SELECT FlightNumber, AVG(Price) AS AvgBusinessPrice
FROM Ticket
WHERE Class = 'Business'
GROUP BY FlightNumber
ORDER BY AvgBusinessPrice DESC;


SELECT p.Name, p.ContactInfo
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID
JOIN Ticket t ON b.TicketNumber = t.TicketNumber
JOIN Flight f ON t.FlightNumber = f.FlightNumber
WHERE f.ArrivalLocation = 'London, UK';

SELECT p.PassengerID, p.Name, SUM(b.Cost) AS TotalCost
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID
WHERE b.Status = 'Complete'
GROUP BY p.PassengerID
ORDER BY TotalCost DESC;

WITH DeletedBookings AS (
    DELETE FROM Booking
    WHERE Status = 'Cancelled'
    RETURNING *
)
SELECT COUNT(*) AS DeletedRows FROM DeletedBookings;


DELETE FROM CodeShare WHERE FlightNumber = 1;
DELETE FROM Seat WHERE FlightNumber = 1;
WITH DeletedTickets AS (
    DELETE FROM Ticket WHERE FlightNumber = 1 RETURNING TicketNumber
)
DELETE FROM Booking WHERE TicketNumber IN (SELECT TicketNumber FROM DeletedTickets);
DELETE FROM Flight WHERE flightnumber = 1;





UPDATE Ticket
SET Status = 'CheckedIn'
WHERE FlightNumber IN (
    SELECT FlightNumber
    FROM Flight
    WHERE DepartureTime::date = '2024-07-01'
);


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