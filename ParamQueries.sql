PREPARE available_flights_by_date (DATE) AS
SELECT f.FlightNumber, f.DepartureLocation, f.ArrivalLocation, f.DepartureTime, f.ArrivalTime, f.Capacity - COUNT(t.TicketNumber) AS AvailableSeats
FROM Flight f
LEFT JOIN Ticket t ON f.FlightNumber = t.FlightNumber
WHERE f.DepartureTime::date = $1
GROUP BY f.FlightNumber
HAVING f.Capacity - COUNT(t.TicketNumber) > 0;

EXECUTE available_flights_by_date('2024-07-01');



PREPARE update_ticket_status (ticket_status, int) AS
UPDATE Ticket
SET Status = $1
WHERE TicketNumber = $2
AND EXISTS (
    SELECT 1
    FROM Ticket
    WHERE TicketNumber = $2
);

EXECUTE update_ticket_status('Booked', 1234);



PREPARE delete_bookings_and_count (int) AS
WITH DeletedBookings AS (
    DELETE FROM Booking
    WHERE PassengerID = $1
    RETURNING *
)
SELECT COUNT(*) AS DeletedRows FROM DeletedBookings;

EXECUTE delete_bookings_and_count(123);


PREPARE total_cost_by_passenger_and_date_range (int, date, date) AS
SELECT PassengerID, SUM(Cost) AS TotalCost
FROM Booking
WHERE PassengerID = $1
AND BookingDate BETWEEN $2 AND $3
GROUP BY PassengerID;

EXECUTE total_cost_by_passenger_and_date_range(123, '2023-01-01', '2023-12-31');