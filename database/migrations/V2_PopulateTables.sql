-- Add mock data to the CustomerData table
INSERT INTO Customer_Data (CustomerID, Name, Title, PhoneNumber, Email)
VALUES 
    (1, 'John Doe', 'Mr.', '123-456-7890', 'john.doe@example.com'),
    (2, 'Jane Smith', 'Mrs.', '987-654-3210', 'jane.smith@example.com'),
    (3, 'Michael Johnson', 'Mr.', '555-123-4567', 'michael.johnson@example.com'),
    (4, 'Emily Brown', 'Miss', '555-987-6543', 'emily.brown@example.com'),
    (5, 'Alice Johnson', 'Ms.', '555-555-5555', 'alice.johnson@example.com');

-- Add mock data to the Pets table
INSERT INTO Pets (PetID, CustomerID, Name, Breed, Size, Age)
VALUES 
    (1, 1, 'Buddy', 'Labrador Retriever', 'Large', 3),
    (2, 1, 'Max', 'Golden Retriever', 'Large', 5),
    (3, 2, 'Bella', 'Poodle', 'Small', 2),
    (4, 2, 'Charlie', 'Beagle', 'Medium', 4),
    (5, 3, 'Daisy', 'Golden Retriever', 'Large', 6),
    (6, 4, 'Rocky', 'German Shepherd', 'Large', 4),
    (7, 5, 'Lucy', 'Pomeranian', 'Small', 3),
    (8, 5, 'Molly', 'Bulldog', 'Medium', 4),
    (9, 5, 'Oscar', 'Dachshund', 'Small', 2),
    (10, 5, 'Lola', 'Yorkshire Terrier', 'Small', 3);

-- Add mock data to the Types_of_Service table
INSERT INTO Types_of_Service (ServiceID, Price, ServiceType, Duration)
VALUES 
    (1, 50.00, 'Bath & Brush', 1.5),
    (2, 100.00, 'Haircut & Styling', 2.5),
    (3, 75.00, 'Nail Clipping', 1),
    (4, 120.00, 'Full Spa Day', 3);

-- Add mock data to the Employee_Data table
INSERT INTO Employee_Data (EmployeeID, Name, IDNumber, Phone, Email)
VALUES 
    (1, 'Michael Johnson', 'E123456', '555-123-4567', 'michael.johnson@example.com'),
    (2, 'Emily Brown', 'E987654', '555-987-6543', 'emily.brown@example.com'),
    (3, 'David Davis', 'E456789', '555-456-7890', 'david.davis@example.com'),
    (4, 'Jennifer Lee', 'E789123', '555-789-1234', 'jennifer.lee@example.com'),
    (5, 'Chris Wilson', 'E321654', '555-321-6540', 'chris.wilson@example.com');

	-- Add mock data to the Appointment table
INSERT INTO Appointment (AppointmentID, CustomerID, PetID, EmployeeID, DateTime, ServiceID)
VALUES 
    (1, 1, 1, 1, '2024-02-10 10:00:00', 1),
    (2, 2, 2, 2, '2024-02-11 11:00:00', 2),
    (3, 3, 5, 2, '2024-02-12 12:00:00', 3),
    (4, 4, 4, 1, '2024-02-13 13:00:00', 4),
    (5, 5, 7, 2, '2024-02-14 14:00:00', 1),
    (6, 5, 8, 1, '2024-02-15 15:00:00', 2),
    (7, 5, 9, 2, '2024-02-16 16:00:00', 3),
    (8, 5, 10, 1, '2024-02-17 17:00:00', 4);

	-- Add mock data to the Appointment_Services table
INSERT INTO Appointment_Services (AppointmentID, ServiceID)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 1),
    (6, 2),
    (7, 3),
    (8, 4);

-- Add mock data to the Payments table
INSERT INTO Payments (PaymentID, AppointmentID, Amount, DateIssued, Status)
VALUES 
    (1, 1, 50.00, '2024-02-10', 'Paid'),
    (2, 2, 100.00, '2024-02-11', 'Paid'),
    (3, 3, 75.00, '2024-02-12', 'Paid'),
    (4, 4, 120.00, '2024-02-13', 'Pending'),
    (5, 5, 50.00, '2024-02-14', 'Pending'),
    (6, 6, 100.00, '2024-02-15', 'Paid'),
    (7, 7, 75.00, '2024-02-16', 'Pending'),
    (8, 8, 120.00, '2024-02-17', 'Paid');