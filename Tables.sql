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
    SeatNumber VARCHAR(3) GENERATED ALWAYS AS (
        CONCAT(
            LPAD((FLOOR((ROW_NUMBER() OVER ()) - 1) % 60) + 1, 2, '0'),
            CASE
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 0 THEN 'A'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 1 THEN 'B'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 2 THEN 'C'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 3 THEN 'D'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 4 THEN 'F'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 5 THEN 'G'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 6 THEN 'H'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 7 THEN 'J'
                WHEN (FLOOR((ROW_NUMBER() OVER ()) - 1) / 60) = 8 THEN 'K'
            END
        )
    ) STORED,
    PRIMARY KEY (FlightNumber, SeatNumber),
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber),
    CONSTRAINT chk_seat_number CHECK (SeatNumber ~ '^[0-5][0-9][A|B|C|D|F|G|H|J|K]$')
);

CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    PassengerID INT,
    BookingDate DATE,
    Status VARCHAR,
    Cost FLOAT,
    TicketNumber INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber)
);

CREATE TABLE Ticket (
    TicketNumber SERIAL PRIMARY KEY,
    FlightNumber INT,
    Price FLOAT,
    Status VARCHAR,
    Class VARCHAR,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
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
