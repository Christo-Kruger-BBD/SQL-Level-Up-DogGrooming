CREATE VIEW appointment_details_view AS
SELECT 
    a.AppointmentID,
    a.DateTime AS AppointmentDateTime,
    c.Name AS CustomerName,
    p.Name AS PetName,
    e.Name AS EmployeeName,
    ts.ServiceType,
    ts.Price AS ServicePrice
FROM 
    Appointment a
JOIN 
    Customer_Data c ON a.CustomerID = c.CustomerID
JOIN 
    Pets p ON a.PetID = p.PetID
JOIN 
    Employee_Data e ON a.EmployeeID = e.EmployeeID
JOIN 
    Appointment_Services aps ON a.AppointmentID = aps.AppointmentID
JOIN 
    Types_of_Service ts ON aps.ServiceID = ts.ServiceID;

CREATE VIEW upcoming_appointments_view AS
SELECT 
    Appointment.AppointmentID,
    Appointment.CustomerID,
    Appointment.PetID,
    Appointment.EmployeeID,
    Appointment.DateTime,
    Appointment.ServiceID,
    Customer_Data.Name AS CustomerName,
    Pets.Name AS PetName,
    Employee_Data.Name AS EmployeeName,
    Types_of_Service.ServiceType
FROM 
    Appointment
JOIN 
    Customer_Data ON Appointment.CustomerID = Customer_Data.CustomerID
JOIN 
    Pets ON Appointment.PetID = Pets.PetID
JOIN 
    Employee_Data ON Appointment.EmployeeID = Employee_Data.EmployeeID
JOIN 
    Types_of_Service ON Appointment.ServiceID = Types_of_Service.ServiceID
WHERE 
    Appointment.DateTime > GETDATE();

CREATE VIEW employee_schedule_view AS
SELECT 
    Appointment.AppointmentID,
    Appointment.CustomerID,
    Appointment.PetID,
    Appointment.EmployeeID,
    Appointment.DateTime AS AppointmentDateTime,
    Appointment.ServiceID,
    Employee_Data.Name AS EmployeeName,
    Customer_Data.Name AS CustomerName,
    Pets.Name AS PetName,
    Types_of_Service.ServiceType
FROM 
    Appointment
JOIN 
    Employee_Data ON Appointment.EmployeeID = Employee_Data.EmployeeID
JOIN 
    Customer_Data ON Appointment.CustomerID = Customer_Data.CustomerID
JOIN 
    Pets ON Appointment.PetID = Pets.PetID
JOIN 
    Types_of_Service ON Appointment.ServiceID = Types_of_Service.ServiceID;