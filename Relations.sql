CREATE TABLE PassengerBooking (
    PassengerID INT NOT NULL,
    BookingID INT NOT NULL,
    PRIMARY KEY (PassengerID, BookingID),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE BookingPackage (
    BookingID INT NOT NULL,
    PackageID INT NOT NULL,
    PRIMARY KEY (BookingID, PackageID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);