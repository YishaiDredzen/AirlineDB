import csv
import random
from faker import Faker
from datetime import datetime, timedelta

# Initialize Faker to generate fake data
fake = Faker()

# Load data from CSV files
flights = {}
tickets = {}
bookings = []

# Read Flights.csv
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flights[int(row['FlightNumber'])] = datetime.strptime(row['ArrivalTime'], '%Y-%m-%d %H:%M:%S')

# Read Tickets.csv
with open('tickets.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        tickets[int(row['TicketNumber'])] = int(row['FlightNumber'])

# Read Bookings.csv
with open('bookings.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        bookings.append({
            'BookingID': int(row['BookingID']),
            'PassengerID': int(row['PassengerID']),
            'BookingDate': datetime.strptime(row['BookingDate'], '%Y-%m-%d'),
            'TicketNumber': int(row['TicketNumber'])
        })

# Define the number of packages to generate
num_packages = 1000

# Lists of car models categorized into Luxury, Classic, Family, and Premium
luxury_cars = [
    'BMW 7 Series', 'Mercedes-Benz S-Class', 'Audi A8', 'Lexus LS', 'Jaguar XJ'
]
classic_cars = [
    'Ford Mustang', 'Chevrolet Camaro', 'Dodge Charger', 'Porsche 911', 'Chevrolet Corvette'
]
family_cars = [
    'Toyota Camry', 'Honda Accord', 'Ford Fusion', 'Chevrolet Malibu', 'Nissan Altima'
]
premium_cars = [
    'Tesla Model S', 'BMW 5 Series', 'Audi A6', 'Mercedes-Benz E-Class', 'Volvo S90'
]

# Function to calculate cost based on category, duration, and car model
def calculate_cost(category, days):
    if category == 'Classic':
        base_cost = random.uniform(45, 70)
    elif category == 'Premium':
        base_cost = random.uniform(60, 90)
    elif category == 'Luxury':
        base_cost = random.uniform(75, 120)
    else:  # Family
        base_cost = random.uniform(60, 100)

    # Apply discount based on duration
    if days > 10:
        discount = 0.15
    elif days > 5:
        discount = 0.10
    else:
        discount = 0.05

    cost_per_day = base_cost * (1 - discount)
    total_cost = cost_per_day * days
    return round(total_cost, 2)

# Generate Package data
packages = []
for package_id in range(1, num_packages + 1):
    # Select a random booking to associate with this package
    booking = random.choice(bookings)
    ticket_number = booking['TicketNumber']
    flight_number = tickets[ticket_number]
    arrival_time = flights[flight_number]

    # Ensure the package start date is after the arrival time
    start_date = arrival_time + timedelta(days=random.randint(1, 5))  # Start date 1 to 5 days after arrival
    return_date = start_date + timedelta(days=random.randint(3, 30))  # Return date 3 to 30 days after start date

    # Determine duration of the package
    duration = (return_date - start_date).days

    # Randomly choose a car category and model
    car_category = random.choice(['Luxury', 'Classic', 'Family', 'Premium'])
    if car_category == 'Luxury':
        car_model = random.choice(luxury_cars)
    elif car_category == 'Classic':
        car_model = random.choice(classic_cars)
    elif car_category == 'Family':
        car_model = random.choice(family_cars)
    else:
        car_model = random.choice(premium_cars)

    # Calculate the cost based on the category and duration
    price = calculate_cost(car_category, duration)

    package = [package_id, car_category + ' Cars', price, start_date.strftime('%Y-%m-%d'), car_model, return_date.strftime('%Y-%m-%d')]
    packages.append(package)

# Write Package data to packages.csv
with open('packages.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['PackageID', 'PackageName', 'Price', 'StartDate', 'CarModel', 'ReturnDate'])
    writer.writerows(packages)

print("packages.csv generated successfully.")
