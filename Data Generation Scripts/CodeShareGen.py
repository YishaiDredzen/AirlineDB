import csv
import random
from faker import Faker

# Initialize Faker to generate fake data
fake = Faker()

# Load flight numbers from Flights.csv
flights = []
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flights.append(int(row['FlightNumber']))

# Define the number of code shares to generate per flight
min_codeshares_per_flight = 1
max_codeshares_per_flight = 3

# Define some common restrictions
restrictions_list = [
    'No carry-on baggage',
    'No checked baggage',
    'No meal service',
    'No seat selection',
    'Non-refundable',
    'No changes allowed'
]

# Generate CodeShare data
codeshares = []
code_share_id = 1
for flight_number in flights:
    num_codeshares = random.randint(min_codeshares_per_flight, max_codeshares_per_flight)
    for _ in range(num_codeshares):
        marketing_airline = fake.company()
        restrictions = random.choice(restrictions_list)
        codeshare = [
            code_share_id,
            flight_number,
            marketing_airline,
            restrictions
        ]
        codeshares.append(codeshare)
        code_share_id += 1

# Write CodeShare data to codeshares.csv
with open('codeshares.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['CodeShareID', 'FlightNumber', 'MarketingAirline', 'Restrictions'])
    writer.writerows(codeshares)

print("codeshares.csv generated successfully.")
