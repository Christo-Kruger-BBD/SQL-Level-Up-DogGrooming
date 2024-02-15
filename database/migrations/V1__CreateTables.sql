-- Drop constraints
IF OBJECT_ID('Pets_Customer_Data_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Pets DROP CONSTRAINT Pets_Customer_Data_FK01
END
GO

IF OBJECT_ID('Appointment_Customer_Data_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointment DROP CONSTRAINT Appointment_Customer_Data_FK01
END
GO

IF OBJECT_ID('Appointment_Pets_FK02', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointment DROP CONSTRAINT Appointment_Pets_FK02
END
GO

IF OBJECT_ID('Appointment_Empleyee_Data_FK03', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointment DROP CONSTRAINT Appointment_Empleyee_Data_FK03
END
GO

IF OBJECT_ID('Appointment_Services_Appointment_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointment_Services DROP CONSTRAINT Appointment_Services_Appointment_FK01
END
GO

IF OBJECT_ID('Payments_Appointment_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Payments DROP CONSTRAINT Payments_Appointment_FK01
END
GO

--DROP TABLES
IF OBJECT_ID('Pets', 'U') IS NOT NULL
BEGIN
  DROP TABLE Pets
END
GO

IF OBJECT_ID('Customer_Data', 'U') IS NOT NULL
BEGIN
  DROP TABLE Customer_Data
END
GO

IF OBJECT_ID('Employee_Data', 'U') IS NOT NULL
BEGIN
  DROP TABLE Employee_Data
END
GO

IF OBJECT_ID('Appointment', 'U') IS NOT NULL
BEGIN
  DROP TABLE Appointment
END
GO

IF OBJECT_ID('Payments', 'U') IS NOT NULL
BEGIN
  DROP TABLE Payments
END
GO

IF OBJECT_ID('Types_of_Service', 'U') IS NOT NULL
BEGIN
  DROP TABLE Types_of_Service
END
GO

IF OBJECT_ID('Appointment_Services', 'U') IS NOT NULL
BEGIN
  DROP TABLE Appointment_Services
END
GO


-- Create tables
CREATE TABLE Customer_Data (
    CustomerID INTEGER PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    Title VARCHAR(255),
    PhoneNumber VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE Employee_Data (
    EmployeeID INTEGER PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    IDNumber VARCHAR(255),
    Phone VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE Pets (
    PetID INTEGER PRIMARY KEY IDENTITY(1,1),
    CustomerID INTEGER, --FK
    Name VARCHAR(255),
    Breed VARCHAR(255),
    Size VARCHAR(255),
    Age INTEGER,
	FOREIGN KEY (CustomerID) REFERENCES Customer_Data(CustomerID)
);

CREATE TABLE Appointment (
    AppointmentID INTEGER PRIMARY KEY IDENTITY(1,1),
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
    PaymentID INTEGER PRIMARY KEY IDENTITY(1,1),
    AppointmentID INTEGER, --FK
    Amount DECIMAL,
    DateIssued DATE,
    Status VARCHAR(255),
	FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Types_of_Service (
    ServiceID INTEGER PRIMARY KEY IDENTITY(1,1),
    Price DECIMAL,
    ServiceType VARCHAR(255),
    Duration DECIMAL
);

CREATE TABLE Appointment_Services (
    AppointmentServiceID INTEGER PRIMARY KEY IDENTITY(1,1),
    AppointmentID INTEGER, --FK
    ServiceID INTEGER, --FK
	FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
	FOREIGN KEY (ServiceID) REFERENCES Types_of_Service(ServiceID)
);

GO

--ATTACH CONSTRAINTS
ALTER TABLE [Pets] ADD CONSTRAINT Pets_Customer_Data_FK01 FOREIGN KEY ([CustomerID]) REFERENCES [Customer_Data] ([CustomerID])
GO

ALTER TABLE [Appointment] ADD CONSTRAINT Appointment_Customer_Data_FK01 FOREIGN KEY ([CustomerID]) REFERENCES [Customer_Data] ([CustomerID])
GO

ALTER TABLE [Appointment] ADD CONSTRAINT Appointment_Pets_FK02 FOREIGN KEY ([PetID]) REFERENCES [Pets] ([PetID])
GO

ALTER TABLE [Appointment] ADD CONSTRAINT Appointment_Empleyee_Data_FK03 FOREIGN KEY ([EmployeeID]) REFERENCES [Employee_Data] ([EmployeeID])
GO

ALTER TABLE [Appointment_Services] ADD CONSTRAINT Appointment_Services_Appointment_FK01 FOREIGN KEY ([AppointmentID]) REFERENCES [Appointment] ([AppointmentID])
GO

ALTER TABLE [Payments] ADD CONSTRAINT Payments_Appointment_FK01 FOREIGN KEY ([AppointmentID]) REFERENCES [Appointment] ([AppointmentID])
GO