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

