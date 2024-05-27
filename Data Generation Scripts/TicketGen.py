import csv
import random
from collections import defaultdict
from faker import Faker

fake = Faker()

# Read flight capacity from flights.csv
flight_capacity = {}
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flight_capacity[int(row['FlightNumber'])] = int(row['Capacity'])

# Function to generate random ticket status
def random_ticket_status():
    status = ['Booked', 'Cancelled', 'CheckedIn', 'Boarded', 'InFlight', 'Landed', 'NoShow']
    return random.choice(status)

# Function to generate random ticket class based on seat row
def random_ticket_class(seat_row):
    if seat_row <= 5:
        return 'First'
    elif 6 <= seat_row <= 20:
        return 'Business'
    elif 21 <= seat_row <= 25:
        return 'EconPlus'
    else:
        return 'Economy'

# Generate unique 9-digit Passenger IDs
def generate_unique_passenger_ids(num_ids):
    passenger_ids = set()
    while len(passenger_ids) < num_ids:
        passenger_id = random.randint(100000000, 999999999)
        passenger_ids.add(passenger_id)
    return list(passenger_ids)

num_passengers = 10000
unique_passenger_ids = generate_unique_passenger_ids(num_passengers)

# Generate 200,000 tickets
tickets = []
passenger_flight_map = defaultdict(set)  # To keep track of PassengerIDs associated with each flight
flight_ticket_count = defaultdict(int)  # To keep track of the number of tickets per flight

# Only 61 rows of seats
seat_rows = list(range(1, 62))
seat_letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K']

for ticket_number in range(1, 200001):
    flight_number = random.randint(1, 2000)  # Assuming there are 2000 flights
    seat_row = random.choice(seat_rows)
    seat_letter = random.choice(seat_letters)
    seat_number = f"{seat_row:02d}{seat_letter}"  # Pad seat row to 2 digits
    price = round(random.uniform(50, 1000), 2)  # Random price between 50 and 1000
    passenger_id = random.choice(unique_passenger_ids)  # Pick a random passenger ID
    
    # Ensure the same PassengerID does not appear in the same flight more than once
    if passenger_id in passenger_flight_map[flight_number]:
        continue
    
    # Determine ticket class based on seat row
    ticket_class = random_ticket_class(seat_row)
    
    # Check if the number of tickets exceeds the flight capacity
    if flight_ticket_count[flight_number] >= flight_capacity[flight_number]:
        status = 'Standby'
    else:
        status = random_ticket_status()
        flight_ticket_count[flight_number] += 1
    
    ticket = [ticket_number, flight_number, seat_number, price, status, ticket_class, passenger_id]
    tickets.append(ticket)
    
    # Update passenger_flight_map
    passenger_flight_map[flight_number].add(passenger_id)
    
    # Print the nth ticket that was just generated
    if ticket_number % 10000 == 0:
        print(ticket)

# Write ticket data to a CSV file
with open('tickets.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['TicketNumber', 'FlightNumber', 'SeatNumber', 'Price', 'Status', 'Class', 'PassengerID'])
    writer.writerows(tickets)

print("tickets.csv generated successfully.")
