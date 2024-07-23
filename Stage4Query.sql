--Shows flight details and aircraft information where the Boeing 737:
SELECT * FROM CrewFlightView WHERE AircraftType = 'Boeing 737';

--Inserts an aircraft into the aircraft table:
INSERT INTO Aircraft (AircraftID, AircraftType, CurrentStatus)
VALUES (1, 'Boeing 737', 'Parked');

--Updates the current status of aircraft ID 1 to 'In flight':
UPDATE Aircraft
SET CurrentStatus = 'In flight'
WHERE AircraftID = 1;

--Deletes an aircraft with specified ID:
DELETE FROM Aircraft WHERE AircraftID = 1;

--Shows the passenger, booking and flight details of confirmed bookings:
SELECT * FROM PassengerBookingView WHERE BookingStatus = 'Confirmed';

--Inserts a Booking for a passenger whose ID is 239599632 and other booking details:
INSERT INTO booking (BookingID, BookingDate, PassengerID, Status, Cost, TicketNumber)
VALUES (12345, '2024-07-24 12:00:00', 239599632, 'Confirmed', 100.00, 4001);

--Updates the booking status to 'Cancelled' with BookingID 3001:
UPDATE booking 
SET Status = 'Cancelled' 
WHERE BookingID = 3001;

--This statement deletes the booking with ID 3001:
DELETE FROM booking 
WHERE BookingID = 3001;

--Shows the number of flights each type of aircraft has flown:
SELECT AircraftType, COUNT(*) AS NumberOfFlights 
FROM CrewFlightView 
GROUP BY AircraftType;

--Shows the information in CrewFlightView for flights that departed after midnight on 23 July 2024:
SELECT * 
FROM CrewFlightView 
WHERE DepartureTime > '2024-07-23 00:00:00';

--Shows how many bookings each passenger has made based on their names:
SELECT PassengerName, COUNT(*) AS NumberOfBookings 
FROM PassengerBookingView 
GROUP BY PassengerName;

--Shows the passenger and flight details for flight number 1001:
SELECT * 
FROM PassengerBookingView 
WHERE FlightNumber = '1001';