-- Create View:
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

