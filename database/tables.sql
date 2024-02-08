CREATE TABLE CustomerData (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(255),
  Title VARCHAR(255),
  PhoneNumber VARCHAR(20),
  Email VARCHAR(255)
);

CREATE TABLE Pets (
  PetID INT PRIMARY KEY,
  CustomerID INT,
  Name VARCHAR(255),
  Breed VARCHAR(255),
  Size VARCHAR(255),
  Age INT,
  FOREIGN KEY (CustomerID) REFERENCES CustomerData(CustomerID)
);

CREATE TABLE Appointment (
  AppointmentID INT PRIMARY KEY,
  CustomerID INT,
  PetID INT,
  EmployeeID INT,
  DateTime DATETIME,
  ServiceID VARCHAR(255),
  FOREIGN KEY (CustomerID) REFERENCES CustomerData(CustomerID),
  FOREIGN KEY (PetID) REFERENCES Pets(PetID),
  // Uncomment the line below if EmployeeID is not nullable
  // FOREIGN KEY (EmployeeID) REFERENCES Employee_Data(EmployeeID)
);

CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY,
  AppointmentID INT,
  Amount DECIMAL(10, 2),
  DateIssued DATE,
  Status VARCHAR(255),
  FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Types_of_Service (
  ServiceID INT PRIMARY KEY,
  Price DECIMAL(10, 2),
  ServiceType VARCHAR(255),
  Duration DECIMAL(5, 2)
);

CREATE TABLE Appointment_Services (
  AppointmentID INT,
  ServiceID INT,
  PRIMARY KEY (AppointmentID, ServiceID),
  FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
  FOREIGN KEY (ServiceID) REFERENCES Types_of_Service(ServiceID)
);

CREATE TABLE Employee_Data (
  EmployeeID INT PRIMARY KEY,
  Name VARCHAR(255),
  IDNumber VARCHAR(255),
  Phone VARCHAR(20),
  Email VARCHAR(255)
);

-- Uncomment the line below if each appointment is assigned to one employee
-- ALTER TABLE Appointment ADD FOREIGN KEY (EmployeeID) REFERENCES Employee_Data(EmployeeID);
