CREATE PROCEDURE GetAppointmentsByEmployee
    @EmployeeID INT
AS
BEGIN
    SELECT * 
    FROM Appointment
    WHERE EmployeeID = @EmployeeID;
END;