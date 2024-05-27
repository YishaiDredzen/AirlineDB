import csv
from faker import Faker

# Initialize Faker
fake = Faker()

# Read PassengerIDs from tickets.csv
passenger_ids = set()
with open('tickets.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        passenger_ids.add(int(row['PassengerID']))

# Generate passenger data
passengers = []
for passenger_id in passenger_ids:
    name = fake.name()
    phone_number = fake.phone_number()
    passengers.append([passenger_id, name, phone_number])

# Write passenger data to passengers.csv
with open('passengers.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['PassengerID', 'Name', 'PhoneNumber'])
    writer.writerows(passengers)

print("passengers.csv generated successfully.")
