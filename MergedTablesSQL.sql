-- Create Airport table first
CREATE TABLE Airport
(
  AirportID INT PRIMARY KEY,
  Name VARCHAR NOT NULL,
  City VARCHAR NOT NULL
);

-- Create Gate table which references Airport
CREATE TABLE Gate
(
  GateID INT PRIMARY KEY,
  GateNumber VARCHAR(3) NOT NULL,
  Status GATE_STATUS NOT NULL,
  TerminalName CHAR(1) NOT NULL,
  AirportID INT NOT NULL,
  FOREIGN KEY (AirportID) REFERENCES Airport(AirportID),
  CHECK (TerminalName BETWEEN 'A' AND 'Z')
);

-- Create Weather table which references Airport
CREATE TABLE Weather
(
  WeatherID INT PRIMARY KEY,
  Conditions WEATHER_CONDITION NOT NULL,
  UpdateTime DATE NOT NULL,
  AirportID INT NOT NULL,
  FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);

-- Create Aircraft table
CREATE TABLE Aircraft
(
  AircraftID INT PRIMARY KEY,
  AircraftType AIRCRAFT_TYPE NOT NULL,
  CurrentStatus AIRCRAFT_STATUS NOT NULL
);

-- Create Flight table which references Airport, Gate, and Aircraft
CREATE TABLE Flight
(
  FlightNumber INT PRIMARY KEY,
  DepartureTime TIMESTAMP NOT NULL,
  ArrivalTime TIMESTAMP NOT NULL,
  AircraftID INT NOT NULL,
  Capacity INT NOT NULL,
  FlightStatus FLIGHT_STATUS NOT NULL,
  DepartureAirportID INT NOT NULL,
  DepartureGateID INT NOT NULL,
  ArrivalAirportID INT NOT NULL,
  ArrivalGateID INT NOT NULL,
  FOREIGN KEY (DepartureAirportID) REFERENCES Airport(AirportID),
  FOREIGN KEY (DepartureGateID) REFERENCES Gate(GateID),
  FOREIGN KEY (ArrivalAirportID) REFERENCES Airport(AirportID),
  FOREIGN KEY (ArrivalGateID) REFERENCES Gate(GateID),
  FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);

-- Create Seat table which references Flight
CREATE TABLE Seat
(
  FlightNumber INT NOT NULL,
  SeatNumber VARCHAR(3) NOT NULL,
  PRIMARY KEY (FlightNumber, SeatNumber),
  FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber),
  CONSTRAINT chk_seat_number CHECK (SeatNumber ~ '^[0-9][0-9][A|B|C|D|E|F|G|H|J|K]$')
);

-- Create Passenger table
CREATE TABLE Passenger
(
  PassengerID INT PRIMARY KEY,
  Name VARCHAR NOT NULL,
  ContactInfo VARCHAR NOT NULL
);

-- Create Ticket table which references Flight, Seat, and Passenger
CREATE TABLE Ticket
(
  TicketNumber INT PRIMARY KEY,
  Status VARCHAR NOT NULL,
  Class VARCHAR NOT NULL,
  Price FLOAT NOT NULL,
  FlightNumber INT NOT NULL,
  SeatNumber VARCHAR(3),
  PassengerID INT NOT NULL,
  FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber),
  FOREIGN KEY (FlightNumber, SeatNumber) REFERENCES Seat(FlightNumber, SeatNumber),
  FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);

-- Create Package table
CREATE TABLE Package
(
  PackageID INT PRIMARY KEY,
  PackageName VARCHAR NOT NULL,
  Price FLOAT NOT NULL,
  StartDate DATE NOT NULL,
  CarModel VARCHAR NOT NULL,
  ReturnDate DATE NOT NULL
);

-- Create Crew table which references Flight
CREATE TABLE Crew
(
  CrewID INT PRIMARY KEY,
  CrewType CREW_TYPE NOT NULL,
  MemberName VARCHAR NOT NULL,
  FlightNumber INT,
  FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

-- Create CodeShare table which references Flight
CREATE TABLE CodeShare
(
  CodeShareID INT PRIMARY KEY,
  FlightNumber INT,
  MarketingAirline VARCHAR NOT NULL,
  Restrictions VARCHAR NOT NULL,
  FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber)
);

-- Create Booking table which references Ticket, Package, and Passenger
CREATE TABLE Booking
(
  BookingID INT PRIMARY KEY,
  PassengerID INT,
  Status BOOKING_STATUS NOT NULL,
  Cost FLOAT NOT NULL,
  TicketNumber INT,
  BookingDate DATE NOT NULL,
  PackageID INT,
  FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber),
  FOREIGN KEY (PackageID) REFERENCES Package(PackageID),
  FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);