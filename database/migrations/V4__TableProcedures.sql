-- Create Stored Procedure:
CREATE PROCEDURE add_new_appointment_procedure
	@AppointmentID INT,
    @CustomerID INT,
    @PetID INT,
    @EmployeeID INT,
    @DateTime DATETIME,
    @ServiceID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Customer_Data WHERE CustomerID = @CustomerID)
        AND EXISTS (SELECT 1 FROM Pets WHERE PetID = @PetID)
        AND EXISTS (SELECT 1 FROM Employee_Data WHERE EmployeeID = @EmployeeID)
        AND EXISTS (SELECT 1 FROM Types_of_Service WHERE ServiceID = @ServiceID)
    BEGIN
        INSERT INTO Appointment (AppointmentID, CustomerID, PetID, EmployeeID, DateTime, ServiceID)
        VALUES (@AppointmentID, @CustomerID, @PetID, @EmployeeID, @DateTime, @ServiceID);
        SELECT 'Appointment added successfully.' AS Status;
    END
    ELSE
    BEGIN
        SELECT 'Invalid input data. Please check the provided IDs.' AS Status;
    END
END;