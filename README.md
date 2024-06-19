# Airline Database - Ticketing Service
Fake Airline Database for Database Project 

As a class, we decided to create a database for an airline company. Each group has taken a different part of the database.
We took the booking and tickets part where passenger's (customer's) bookings are managed in the database. 
In addition to flights, we offer package deals where customer's can rent cars through our service.

### Creating the Database
To Create the tables and populate them, run the files in the following order:

1. First, run the **Enums.sql** script to create enums on local system
2. The Schema definition: **Tables.sql** and **Relations.sql**
3. For generating random data, run the scripts in Data Generation folder in the following order:
   * TicketGen.py
   * FlightGen.py
   * SeatGen.py
   * PassengerGen.py
   * BookingGen.py
   * PackageGen.py
   * CodeShareGen.py
   * Relations.py

  
Below is a screenshot of the ERD:

![AltText](ERD.jpg)


Below is a screenshot of the DSD:

![AltText](DSD.jpg)


A full documentation can be found in the Stage1 and Stage2 pdf files.
