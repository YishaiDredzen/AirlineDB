INSERT INTO public.Airport (AirportID, Name, City)
SELECT Airport_ID, Name, City
FROM schedule_schema.Airport;




INSERT INTO public.Gate (GateID, GateNumber, Status, TerminalName, AirportID)
SELECT Gate_ID, Gate_Number, Status, Terminal_Name, Airport_ID
FROM schedule_schema.Gate;



INSERT INTO public.Aircraft (AircraftID, AircraftType, CurrentStatus)
SELECT Aircraft_ID, Aircraft_Type, Current_Status
FROM schedule_schema.Aircraft;



INSERT INTO Flight (
    FlightNumber,
    DepartureTime,
    ArrivalTime,
    AircraftID,
    Capacity,
    FlightStatus,
    DepartureAirportID,
    DepartureGateID,
    ArrivalAirportID,
    ArrivalGateID
)
SELECT
    fl.OldFlightNumber AS FlightNumber,
    airlinedb.DepartureTime,
    airlinedb.ArrivalTime,
    schedule.Aircraft_ID,
    airlinedb.Capacity,
    schedule.Flight_Status,
    schedule.Departure_Airport_ID,
    schedule.Departure_Gate_ID,
    schedule.Arrival_Airport_ID,
    schedule.Arrival_Gate_ID
FROM FlightLookup fl
JOIN airlinedb_schema.Flight airlinedb ON fl.OldFlightNumber = airlinedb.FlightNumber
JOIN schedule_schema.Flight schedule ON fl.NewFlightNumber = schedule.Flight_Number;




INSERT INTO FlightLookup (OldFlightNumber, NewFlightNumber)
SELECT old.FlightNumber AS OldFlightNumber, new.Flight_Number AS NewFlightNumber
FROM LATERAL (
    SELECT FlightNumber, ROW_NUMBER() OVER (ORDER BY FlightNumber) AS row_num
    FROM airlinedb_schema.Flight
) AS old
JOIN LATERAL (
    SELECT Flight_Number, ROW_NUMBER() OVER (ORDER BY Flight_Number) AS row_num
    FROM schedule_schema.Flight
) AS new
ON old.row_num = new.row_num;



INSERT INTO public.Seat (FlightNumber, SeatNumber)
SELECT FlightNumber, SeatNumber
FROM airlinedb_schema.Seat;



INSERT INTO public.Passenger (PassengerID, Name, ContactInfo)
SELECT PassengerID, Name, ContactInfo
FROM airlinedb_schema.Passenger;



INSERT INTO public.Ticket (TicketNumber, Status, Class, Price, FlightNumber, SeatNumber, PassengerID)
SELECT TicketNumber, Status, Class, Price, FlightNumber, SeatNumber, PassengerID
FROM airlinedb_schema.Ticket;



INSERT INTO public.Package (PackageID, PackageName, Price, StartDate, CarModel, ReturnDate)
SELECT PackageID, PackageName, Price, StartDate, CarModel, ReturnDate
FROM airlinedb_schema.Package;



INSERT INTO public.Crew (CrewID, CrewType, MemberName, FlightNumber)
SELECT 
    c.Crew_ID, 
    c.Crew_Type, 
    c.Member_Name, 
    fl.oldFlightNumber
FROM 
    schedule_schema.Crew c
JOIN 
    FlightLookup fl ON c.Flight_Number = fl.newFlightNumber;



INSERT INTO public.CodeShare (CodeShareID, FlightNumber, MarketingAirline, Restrictions)
SELECT
    cs.CodeShareID,
    cs.FlightNumber,
    cs.MarketingAirline,
    cs.Restrictions
FROM
    airlinedb_schema.CodeShare cs;



INSERT INTO public.Booking (BookingID, PassengerID, Status, Cost, TicketNumber, BookingDate)
SELECT
    b.BookingID,
    b.PassengerID,
    b.Status,
    b.Cost,
    b.TicketNumber,
    b.BookingDate
FROM
    airlinedb_schema.Booking b
WHERE
    b.Status IS NOT NULL
    AND b.Cost IS NOT NULL;