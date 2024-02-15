CREATE FUNCTION get_appointments_for_customer_function(@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT a.AppointmentID, a.DateTime, p.Name AS PetName, e.Name AS EmployeeName
    FROM Appointment a
    JOIN Pets p ON a.PetID = p.PetID
    JOIN Employee_Data e ON a.EmployeeID = e.EmployeeID
    WHERE a.CustomerID = @CustomerID
);
