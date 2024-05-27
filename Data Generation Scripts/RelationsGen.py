import csv
import random

# Load data from CSV files
passengers = []
bookings = []
packages = []

# Read Passengers.csv
with open('passengers.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        passengers.append(int(row['PassengerID']))

# Read Bookings.csv
with open('bookings.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        bookings.append(int(row['BookingID']))

# Read Packages.csv
with open('packages.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        packages.append(int(row['PackageID']))

# Define the number of records to generate for each table
num_passenger_bookings = len(bookings)
num_booking_packages = len(bookings)

# Generate PassengerBooking data
passenger_bookings = []
for booking_id in bookings:
    passenger_id = random.choice(passengers)
    passenger_booking = [passenger_id, booking_id]
    passenger_bookings.append(passenger_booking)

# Generate BookingPackage data
booking_packages = []
for booking_id in bookings:
    if random.random() < 0.5:  # 50% chance of a booking having a package
        package_id = random.choice(packages)
        booking_package = [booking_id, package_id]
        booking_packages.append(booking_package)

# Write PassengerBooking data to passenger_bookings.csv
with open('passenger_bookings.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['PassengerID', 'BookingID'])
    writer.writerows(passenger_bookings)

print("passenger_bookings.csv generated successfully.")

# Write BookingPackage data to booking_packages.csv
with open('booking_packages.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['BookingID', 'PackageID'])
    writer.writerows(booking_packages)

print("booking_packages.csv generated successfully.")
