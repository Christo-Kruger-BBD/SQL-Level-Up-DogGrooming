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