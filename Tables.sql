CREATE TABLE Passenger (
    PassengerID SERIAL PRIMARY KEY,
    Name VARCHAR NOT NULL,
    ContactInfo VARCHAR NOT NULL
);

CREATE TABLE Package (
    PackageID SERIAL PRIMARY KEY,
    PackageName VARCHAR NOT NULL,
    Price FLOAT NOT NULL,
    StartDate DATE NOT NULL,
    CarModel VARCHAR NOT NULL,
    ReturnDate DATE NOT NULL
);

CREATE TABLE Flight (
    FlightNumber SERIAL PRIMARY KEY,
    DepartureLocation VARCHAR NOT NULL,
    ArrivalLocation VARCHAR NOT NULL,
    DepartureTime TIMESTAMP NOT NULL,
    ArrivalTime TIMESTAMP NOT NULL,
    Capacity INT NOT NULL
);

CREATE TABLE CodeShare (
    CodeShareID SERIAL PRIMARY KEY,
    FlightNumber INT NOT NULL,
    MarketingAirline VARCHAR NOT NULL,
    Restrictions INT,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    PassengerID INT NOT NULL,
    BookingDate DATE NOT NULL,
    Status booking_status NOT NULL,
    Cost FLOAT NOT NULL,
    FlightNumber INT NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Seat (
    SeatID SERIAL PRIMARY KEY,
    FlightNumber INT NOT NULL,
    SeatNumber VARCHAR NOT NULL,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

CREATE TABLE Ticket (
    TicketNumber SERIAL PRIMARY KEY,
    BookingID INT NOT NULL,
    SeatID INT NOT NULL,
    Class ticket_class NOT NULL,
    Price FLOAT NOT NULL,
    Status ticket_status NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
);
