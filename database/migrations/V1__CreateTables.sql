-- Create tables
CREATE TABLE Customer_Data (
    CustomerID INTEGER PRIMARY KEY,
    Name VARCHAR(255),
    Title VARCHAR(255),
    PhoneNumber VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE Employee_Data (
    EmployeeID INTEGER PRIMARY KEY,
    Name VARCHAR(255),
    IDNumber VARCHAR(255),
    Phone VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE Pets (
    PetID INTEGER PRIMARY KEY,
    CustomerID INTEGER, --FK
    Name VARCHAR(255),
    Breed VARCHAR(255),
    Size VARCHAR(255),
    Age INTEGER,
	FOREIGN KEY (CustomerID) REFERENCES Customer_Data(CustomerID)
);

CREATE TABLE Appointment (
    AppointmentID INTEGER PRIMARY KEY,
    CustomerID INTEGER, --FK
    PetID INTEGER, --FK
    EmployeeID INTEGER, --FK
    DateTime DATETIME,
    ServiceID INTEGER,
	FOREIGN KEY (CustomerID) REFERENCES Customer_Data(CustomerID),
	FOREIGN KEY (PetID) REFERENCES Pets(PetID),
	FOREIGN KEY (EmployeeID) REFERENCES Employee_Data(EmployeeID)
);

CREATE TABLE Payments (
    PaymentID INTEGER PRIMARY KEY,
    AppointmentID INTEGER, --FK
    Amount DECIMAL,
    DateIssued DATE,
    Status VARCHAR(255),
	FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Types_of_Service (
    ServiceID INTEGER PRIMARY KEY,
    Price DECIMAL,
    ServiceType VARCHAR(255),
    Duration DECIMAL
);

CREATE TABLE Appointment_Services (
    AppointmentID INTEGER, --FK
    ServiceID INTEGER, --FK
	FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
	FOREIGN KEY (ServiceID) REFERENCES Types_of_Service(ServiceID)
);

GO;