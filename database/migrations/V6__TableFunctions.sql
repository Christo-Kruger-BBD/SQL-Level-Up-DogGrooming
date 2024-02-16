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