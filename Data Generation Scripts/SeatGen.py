import csv

# Read flight numbers from flights.csv
flights = set()
with open('flights.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flights.add(int(row['FlightNumber']))

# Read flight numbers and seat numbers from tickets.csv
ticket_seats = {}
with open('tickets.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        flight_number = int(row['FlightNumber'])
        seat_number = row['SeatNumber']
        # Zero-pad single-digit row numbers in the seat number
        if len(seat_number) == 2:
            seat_number = '0' + seat_number
        if flight_number in flights:
            if flight_number not in ticket_seats:
                ticket_seats[flight_number] = set()
            ticket_seats[flight_number].add(seat_number)

# Write seat table data to seats.csv
with open('seats.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['FlightNumber', 'SeatNumber'])
    for flight_number, seats in ticket_seats.items():
        for seat_number in seats:
            writer.writerow([flight_number, seat_number])

print("Seats data generated and saved to seats.csv.")
