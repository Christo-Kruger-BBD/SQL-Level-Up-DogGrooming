-- Create Scalar Function:
CREATE FUNCTION calculate_total_payment
(
    @AppointmentID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2);
    SELECT @TotalAmount = SUM(ts.Price)
    FROM Appointment_Services aps
    JOIN Types_of_Service ts ON aps.ServiceID = ts.ServiceID
    WHERE aps.AppointmentID = @AppointmentID;
    RETURN @TotalAmount;
END;

GO

-- Create Table-Valued Function: GetAppointmentsForCustomerFunction
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

GO