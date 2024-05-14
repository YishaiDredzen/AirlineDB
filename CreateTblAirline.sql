-- Create Table: 'Flight'
CREATE TABLE Flight (
    FlightNumber   SERIAL PRIMARY KEY,
    DepartureTime  TIMESTAMP NOT NULL,
    DepartureLocation VARCHAR NOT NULL,
    ArrivalTime    TIMESTAMP NOT NULL,
    ArrivalLocation VARCHAR NOT NULL,
    Capacity       INTEGER NOT NULL
);

-- Create Table: 'Package'
CREATE TABLE Package (
    PackageID      SERIAL PRIMARY KEY,
    PackageName    VARCHAR NOT NULL,
    BookingID      INTEGER NOT NULL,
    CarModel       VARCHAR NOT NULL,
    StartDate      DATE NOT NULL,
    ReturnDate     DATE NOT NULL,
    Price          DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE
);

-- Create Table: 'CodeShare'
CREATE TABLE CodeShare (
    CodeShareID    SERIAL PRIMARY KEY,
    FlightNumber   INTEGER NOT NULL,
    MarketingAirline VARCHAR NOT NULL,
    Restrictions   VARCHAR NOT NULL,
    FlightNumber1  INTEGER,
    FOREIGN KEY (FlightNumber1) REFERENCES Flight(FlightNumber) ON DELETE SET NULL
);

-- Create Table: 'Booking'
CREATE TABLE Booking (
    BookingID      SERIAL PRIMARY KEY,
    TicketNumber   INTEGER UNIQUE NOT NULL,
    PassengerID    INTEGER UNIQUE NOT NULL,
    BookingDate    DATE NOT NULL,
    Cost           DECIMAL(10, 2) NOT NULL,
    Status         VARCHAR NOT NULL,
    PackageID      INTEGER NOT NULL,
    FOREIGN KEY (PackageID) REFERENCES RentalPackage(PackageID) ON DELETE CASCADE
);

-- Create Table: 'Ticket'
CREATE TABLE Ticket (
    TicketNumber   SERIAL PRIMARY KEY,
    BookingID      INTEGER NOT NULL,
    FlightNumber   INTEGER NOT NULL,
    Status         VARCHAR NOT NULL,
    Class          VARCHAR NOT NULL,
    Price          DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber) ON DELETE SET NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE
);

-- Create Table: 'Passenger'
CREATE TABLE Passenger (
    PassengerID    SERIAL PRIMARY KEY,
    Name           VARCHAR NOT NULL,
    ContactInfo    VARCHAR NOT NULL,
    BookingID      INTEGER,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE SET NULL
);

-- Permissions for: 'public'
GRANT ALL PRIVILEGES ON TABLE Flight TO public;
GRANT ALL PRIVILEGES ON TABLE RentalPackage TO public;
GRANT ALL PRIVILEGES ON TABLE CodeShare TO public;
GRANT ALL PRIVILEGES ON TABLE Booking TO public;
GRANT ALL PRIVILEGES ON TABLE Ticket TO public;
GRANT ALL PRIVILEGES ON TABLE Passenger TO public;
