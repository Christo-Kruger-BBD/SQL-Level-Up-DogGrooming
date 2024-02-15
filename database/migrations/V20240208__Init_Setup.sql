--REMOVE CONSTRAINTS
IF OBJECT_ID('CustomerPets_Customers_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE CustomerPets DROP CONSTRAINT CustomerPets_Customers_FK01
END
GO

IF OBJECT_ID('CustomerPets_Pets_FK02', 'C') IS NOT NULL
BEGIN
  ALTER TABLE CustomerPets DROP CONSTRAINT CustomerPets_Pets_FK02
END
GO

IF OBJECT_ID('Appointments_Pets_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointments DROP CONSTRAINT Appointments_Pets_FK01
END
GO

IF OBJECT_ID('Appointments_Customers_FK02', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Appointments DROP CONSTRAINT Appointments_Customers_FK02
END
GO

IF OBJECT_ID('AppointmentServices_Services_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE AppointmentServices DROP CONSTRAINT AppointmentServices_Services_FK01
END
GO

IF OBJECT_ID('AppointmentServices_Services_FK02', 'C') IS NOT NULL
BEGIN
  ALTER TABLE AppointmentServices DROP CONSTRAINT AppointmentServices_Services_FK02
END
GO

IF OBJECT_ID('Payments_Appointments_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE Payments DROP CONSTRAINT Payments_Appointments_FK01
END
GO

IF OBJECT_ID('EmployeeAssignments_Appointments_FK01', 'C') IS NOT NULL
BEGIN
  ALTER TABLE EmployeeAssignments DROP CONSTRAINT EmployeeAssignments_Appointments_FK01
END
GO

IF OBJECT_ID('EmployeeAssignments_Appointments_FK02', 'C') IS NOT NULL
BEGIN
  ALTER TABLE EmployeeAssignments DROP CONSTRAINT EmployeeAssignments_Appointments_FK02
END
GO

--DROP TABLES
IF OBJECT_ID('Pets', 'U') IS NOT NULL
BEGIN
  DROP TABLE Pets
END
GO

IF OBJECT_ID('Customers', 'U') IS NOT NULL
BEGIN
  DROP TABLE Customers
END
GO

IF OBJECT_ID('CustomerPets', 'U') IS NOT NULL
BEGIN
  DROP TABLE CustomerPets
END
GO

IF OBJECT_ID('TypesOfService', 'U') IS NOT NULL
BEGIN
  DROP TABLE TypesOfService
END
GO

IF OBJECT_ID('AppointmentServices', 'U') IS NOT NULL
BEGIN
  DROP TABLE AppointmentServices
END
GO

IF OBJECT_ID('Appointments', 'U') IS NOT NULL
BEGIN
  DROP TABLE Appointments
END
GO

IF OBJECT_ID('Employees', 'U') IS NOT NULL
BEGIN
  DROP TABLE Employees
END
GO

IF OBJECT_ID('Payments', 'U') IS NOT NULL
BEGIN
  DROP TABLE Payments
END
GO

IF OBJECT_ID('EmployeeAssignments', 'U') IS NOT NULL
BEGIN
  DROP TABLE EmployeeAssignments
END
GO

--CREATE TABLES
CREATE TABLE [Pets]
(
  [PetID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [Name] VARCHAR(250) NOT NULL,
  [Breed] VARCHAR(50) NOT NULL,
  [Size] VARCHAR(50) NOT NULL,
  [Age] INTEGER NOT NULL
)
GO

CREATE TABLE [Customers]
(
  [CustomerID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [Name] VARCHAR(250) NOT NULL,
  [Title] VARCHAR(15) NOT NULL,
  [PhoneNumber] VARCHAR(50) NOT NULL,
  [Email] VARCHAR(250) NOT NULL
)
GO

CREATE TABLE [Types_Of_Service]
(
  [ServiceID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [Price] DECIMAL NOT NULL,
  [ServiceType] VARCHAR(50) NOT NULL,
  [Description] VARCHAR(50) NOT NULL,
  [Duration] DECIMAL
)
GO

CREATE TABLE [Appointment_Services]
(
  [ID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [AppointmentID] INTEGER NOT NULL,
  [ServiceID] INTEGER NOT NULL,
)
GO

CREATE TABLE [Appointments]
(
  [AppointmentID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [CustomerID] INTEGER NOT NULL,
  [ServiceID] INTEGER NOT NULL,
  [PetID] INTEGER NOT NULL,
  [EmployeeID] INTEGER NOT NULL,
  [DateTime] DATETIME NOT NULL,
)
GO

CREATE TABLE [Employees]
(
  [EmployeeID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [Name] VARCHAR(250) NOT NULL,
  [IDNumber] VARCHAR(50) NOT NULL,
  [PhoneNumber] VARCHAR(50) NOT NULL,
  [Email] VARCHAR(250) NOT NULL
)
GO

CREATE TABLE [Payments]
(
  [PaymentID] INTEGER PRIMARY KEY IDENTITY(1,1),
  [AppointmentID] INTEGER NOT NULL,
  [Amount] DECIMAL NOT NULL,
  [DateIssued] DATETIME NOT NULL,
  [Status] VARCHAR(50) NOT NULL,
)
GO

--ATTACH CONSTRAINTS
ALTER TABLE [Appointments] ADD CONSTRAINT Appointments_Pets_FK01 FOREIGN KEY ([PetID]) REFERENCES [Pets] ([PetID])
GO

ALTER TABLE [Appointments] ADD CONSTRAINT Appointments_Customers_FK02 FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID])
GO

ALTER TABLE [Appointment_Services] ADD CONSTRAINT AppointmentServices_Services_FK01 FOREIGN KEY ([ServiceID]) REFERENCES [Types_Of_Service] ([ServiceID])
GO

ALTER TABLE [Appointment_Services] ADD CONSTRAINT AppointmentServices_Appointments_FK02 FOREIGN KEY ([AppointmentID]) REFERENCES [Appointments] ([AppointmentID])
GO

ALTER TABLE [Payments] ADD CONSTRAINT Payments_Appointments_FK01 FOREIGN KEY ([AppointmentID]) REFERENCES [Appointments] ([AppointmentID])
GO

ALTER TABLE [Appointments] ADD CONSTRAINT Employees_Appointments_FK01 FOREIGN KEY ([EmployeeID]) REFERENCES [Employees] ([EmployeeID])
GO

