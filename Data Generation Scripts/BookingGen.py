import csv
import random
from faker import Faker
from datetime import datetime, timedelta

# Initialize Faker to generate fake data
fake = Faker()

# Read TicketNumbers and associated FlightNumbers from tickets.csv
ticket_flights = {}
with open('tickets.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        ticket_number = int(row['TicketNumber'])
        flight_number = int(row['FlightNumber'])
        ticket_flights[ticket_number] = flight_number

# Read Flight DepartureTimes
flight_departure_times = {}
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flight_number = int(row['FlightNumber'])
        departure_time = datetime.strptime(row['DepartureTime'], '%Y-%m-%d %H:%M:%S')
        flight_departure_times[flight_number] = departure_time

# Generate Booking data
bookings = []
for booking_id in range(1, 200001):
    ticket_number = random.choice(list(ticket_flights.keys()))
    flight_number = ticket_flights[ticket_number]
    departure_time = flight_departure_times[flight_number]
    
    # Generate booking date before the earliest departure time
    booking_date = fake.date_time_between(start_date='-30d', end_date=departure_time.date()).date()
    
    passenger_id = fake.random_int(1, 1000000)  # Generate random passenger ID
    status = random.choice(['Confirmed', 'Cancelled', 'Pending', 'Complete'])
    cost = round(random.uniform(50, 1000), 2)  # Random cost between 50 and 1000

    booking = [booking_id, passenger_id, booking_date, status, cost, ticket_number]
    bookings.append(booking)

# Write Booking data to bookings.csv
with open('bookings.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['BookingID', 'PassengerID', 'BookingDate', 'Status', 'Cost', 'TicketNumber'])
    writer.writerows(bookings)

print("bookings.csv generated successfully.")
