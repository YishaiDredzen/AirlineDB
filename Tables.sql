CREATE TABLE Passenger (
    PassengerID SERIAL PRIMARY KEY,
    Name VARCHAR NOT NULL,
    ContactInfo VARCHAR NOT NULL
);

CREATE TABLE Flight (
    FlightNumber SERIAL PRIMARY KEY,
    DepartureLocation VARCHAR NOT NULL,
    ArrivalLocation VARCHAR NOT NULL,
    DepartureTime TIMESTAMP NOT NULL,
    ArrivalTime TIMESTAMP NOT NULL,
    Capacity INT NOT NULL
);

CREATE TABLE Seat (
    FlightNumber INT,
    SeatNumber VARCHAR(3) NOT NULL,
    PRIMARY KEY (FlightNumber, SeatNumber),
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber),
    CONSTRAINT chk_seat_number CHECK (SeatNumber ~ '^[0-5][0-9][A|B|C|D|F|G|H|J|K]$')
);

CREATE TABLE Ticket (
    TicketNumber SERIAL PRIMARY KEY,
    FlightNumber INT,
    SeatNumber VARCHAR(3),
    Price FLOAT,
    Status ticket_status,
    Class ticket_class,
    PassengerID INT,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber),
    FOREIGN KEY (FlightNumber, SeatNumber) REFERENCES Seat(FlightNumber, SeatNumber),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    PassengerID INT,
    BookingDate DATE,
    Status booking_status,
    Cost FLOAT,
    TicketNumber INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber)
);

CREATE TABLE Package (
    PackageID SERIAL PRIMARY KEY,
    PackageName VARCHAR NOT NULL,
    Price FLOAT NOT NULL,
    StartDate DATE NOT NULL,
    CarModel VARCHAR NOT NULL,
    ReturnDate DATE NOT NULL
);


CREATE TABLE CodeShare (
    CodeShareID SERIAL PRIMARY KEY,
    FlightNumber INT,
    MarketingAirline VARCHAR NOT NULL,
    Restrictions VARCHAR NOT NULL,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

ALTER SEQUENCE flight_flightnumber_seq START WITH 1000;
ALTER SEQUENCE ticket_ticketnumber_seq START WITH 100;