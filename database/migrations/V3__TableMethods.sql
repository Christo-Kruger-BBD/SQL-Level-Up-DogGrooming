-- Create View:
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'appointment_details_view')
BEGIN
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
END;

-- Create Stored Procedure:
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'add_new_appointment_procedure')
BEGIN
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
END;

-- Create Scalar Function:
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[calculate_total_payment]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
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
END;

-- Create Table-Valued Function: GetAppointmentsForCustomerFunction
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[get_appointments_for_customer_function]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
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
END;
