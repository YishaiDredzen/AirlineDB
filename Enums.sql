CREATE TYPE ticket_class AS ENUM ('Economy', 'EconPlus', 'Business', 'First');
CREATE TYPE ticket_status AS ENUM ('Booked', 'Cancelled', 'CheckedIn', 'Boarded', 'InFlight', 'Landed', 'NoShow' );
CREATE TYPE booking_status AS ENUM ('Confirmed', 'Cancelled', 'Pending', 'Complete');
