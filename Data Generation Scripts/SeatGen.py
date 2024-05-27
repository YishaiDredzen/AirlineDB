import csv
import os

# Read flight data from flights.csv
flight_data = []
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flight_data.append(row)

# Generate seat data based on flight capacity
seat_data = []

seat_letters_2x2x2 = ['A', 'B', 'D', 'E', 'F', 'G']
seat_letters_3x3x3 = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'K']

for flight in flight_data:
    flight_number = flight['FlightNumber']
    capacity = int(flight['Capacity'])
    seat_counter = 0

    for row_number in range(1, 151):
        if seat_counter >= capacity:
            break
        if row_number <= 20:
            for letter in seat_letters_2x2x2:
                if seat_counter >= capacity:
                    break
                seat_number = f"{row_number}{letter}"
                seat_data.append([flight_number, seat_number])
                seat_counter += 1
        else:
            for letter in seat_letters_3x3x3:
                if seat_counter >= capacity:
                    break
                seat_number = f"{row_number}{letter}"
                seat_data.append([flight_number, seat_number])
                seat_counter += 1

# Write seat data to a CSV file as 'seats.csv' in the main directory
with open('seats.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['FlightNumber', 'SeatNumber'])
    writer.writerows(seat_data)

print("seats.csv generated successfully in the main directory.")
