IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customer_Data')
BEGIN
    CREATE TABLE Customer_Data (
        CustomerID INTEGER PRIMARY KEY,
        Name VARCHAR(255),
        Title VARCHAR(255),
        PhoneNumber VARCHAR(255),
        Email VARCHAR(255)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee_Data')
BEGIN
    CREATE TABLE Employee_Data (
        EmployeeID INTEGER PRIMARY KEY,
        Name VARCHAR(255),
        IDNumber VARCHAR(255),
        Phone VARCHAR(255),
        Email VARCHAR(255)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pets')
BEGIN
    CREATE TABLE Pets (
        PetID INTEGER PRIMARY KEY,
        CustomerID INTEGER,
        Name VARCHAR(255),
        Breed VARCHAR(255),
        Size VARCHAR(255),
        Age INTEGER,
        FOREIGN KEY (CustomerID) REFERENCES Customer_Data(CustomerID)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Appointment')
BEGIN
    CREATE TABLE Appointment (
        AppointmentID INTEGER PRIMARY KEY,
        CustomerID INTEGER,
        PetID INTEGER,
        EmployeeID INTEGER,
        DateTime DATETIME,
        ServiceID INTEGER,
        FOREIGN KEY (CustomerID) REFERENCES Customer_Data(CustomerID),
        FOREIGN KEY (PetID) REFERENCES Pets(PetID),
        FOREIGN KEY (EmployeeID) REFERENCES Employee_Data(EmployeeID)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Payments')
BEGIN
    CREATE TABLE Payments (
        PaymentID INTEGER PRIMARY KEY,
        AppointmentID INTEGER,
        Amount DECIMAL,
        DateIssued DATE,
        Status VARCHAR(255),
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Types_of_Service')
BEGIN
    CREATE TABLE Types_of_Service (
        ServiceID INTEGER PRIMARY KEY,
        Price DECIMAL,
        ServiceType VARCHAR(255),
        Duration DECIMAL
    );
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Appointment_Services')
BEGIN
    CREATE TABLE Appointment_Services (
        AppointmentID INTEGER,
        ServiceID INTEGER,
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
        FOREIGN KEY (ServiceID) REFERENCES Types_of_Service(ServiceID)
    );
END;
