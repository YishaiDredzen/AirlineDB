import csv
import random
from faker import Faker
from datetime import datetime, timedelta

# Initialize Faker to generate fake data
fake = Faker()

# Read TicketNumbers, FlightNumbers, and PassengerIDs from tickets.csv
ticket_data = {}
ticket_count_per_flight = {}
with open('tickets.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        ticket_number = int(row['TicketNumber'])
        flight_number = int(row['FlightNumber'])
        passenger_id = row['PassengerID']  # PassengerID is already 9 digits
        ticket_data[ticket_number] = (flight_number, passenger_id)
        if flight_number in ticket_count_per_flight:
            ticket_count_per_flight[flight_number] += 1
        else:
            ticket_count_per_flight[flight_number] = 1

# Read Flight DepartureTimes and Capacities
flight_departure_times = {}
flight_capacity = {}
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flight_number = int(row['FlightNumber'])
        departure_time = datetime.strptime(row['DepartureTime'], '%Y-%m-%d %H:%M:%S')
        capacity = int(row['Capacity'])
        flight_departure_times[flight_number] = departure_time
        flight_capacity[flight_number] = capacity

# Generate Booking data
bookings = []
for booking_id in range(1, 200001):
    ticket_number = random.choice(list(ticket_data.keys()))
    flight_number, passenger_id = ticket_data[ticket_number]
    departure_time = flight_departure_times[flight_number]

    # Generate booking date before the earliest departure time
    booking_date = fake.date_time_between(start_date='-30d', end_date=departure_time.date()).date()

    # Determine status based on flight capacity
    status = random.choice(['Confirmed', 'Cancelled', 'Pending', 'Complete'])

    # Random cost between 50 and 1000, rounded to 2 decimal places
    cost = round(random.uniform(50, 1000), 2)

    booking = [booking_id, passenger_id, booking_date, status, cost, ticket_number]
    bookings.append(booking)

# Write Booking data to bookings.csv
with open('bookings.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['BookingID', 'PassengerID', 'BookingDate', 'Status', 'Cost', 'TicketNumber'])
    writer.writerows(bookings)

print("bookings.csv generated successfully.")
