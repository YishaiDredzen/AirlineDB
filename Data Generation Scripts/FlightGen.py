import csv
import os
import random
from datetime import timedelta
from faker import Faker

# Faker instance
fake = Faker()

# Number of flights
num_flights = 2000

# Read real cities from CSV file
cities = []
with open('cities.csv', mode='r', newline='') as file:
    reader = csv.DictReader(file)
    for row in reader:
        cities.append(f"{row['City']}, {row['Country']}")

# Function to generate random datetime between two given datetime objects
def random_datetime(start_datetime, end_datetime):
    return start_datetime + timedelta(seconds=random.randint(0, int((end_datetime - start_datetime).total_seconds())))

# Generate flight data
flight_data = []
for flight_number in range(num_flights):
    departure_location = random.choice(cities)
    arrival_location = random.choice(cities)
    
    # Ensure departure and arrival locations are not the same
    while departure_location == arrival_location:
        arrival_location = random.choice(cities)
    
    # Generate random departure and arrival times
    departure_time = fake.date_time_between(start_date='-1y', end_date='+1y', tzinfo=None)
    arrival_time = departure_time + timedelta(hours=random.randint(1, 24))  # Arrival after departure
    
    # Calculate flight duration
    flight_duration = arrival_time - departure_time
    
    # Determine capacity based on flight duration
    if flight_duration <= timedelta(hours=5):
        capacity = 120  # Small plane
    else:
        capacity = 484  # Large plane

    flight_data.append([flight_number, departure_location, arrival_location, departure_time, arrival_time, capacity])

# Write flight data to a CSV file as 'flights.csv'
with open('flights.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['FlightNumber', 'DepartureLocation', 'ArrivalLocation', 'DepartureTime', 'ArrivalTime', 'Capacity'])
    writer.writerows(flight_data)

print("Flights data generated successfully.")
