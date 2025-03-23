IF OBJECT_ID('AddEmployee', 'P') IS NOT NULL
    DROP PROCEDURE AddEmployee;
GO

IF OBJECT_ID('TotalPercentage', 'P') IS NOT NULL
    DROP PROCEDURE TotalPercentage;
GO

-- Create a stored procedure that inserts a new employee and assigns them to an office.
CREATE PROCEDURE AddEmployee
    @EmpCode INT,
    @Name NVARCHAR(50),
    @DayOfBirth DATE,
    @Address NVARCHAR(200),
    @OfficeNo INT
AS 
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Office o WHERE o.OfficeNo = @OfficeNo)
        BEGIN
            RAISERROR ('Office Does Not Exits', 16, 1);
            RETURN;
        END
        INSERT INTO Employee (EmpCode, Name, DayOfBirth, Address, OfficeNo) VALUES
        (@EmpCode, @Name, @DayOfBirth, @Address, @OfficeNo);
    END TRY
    BEGIN CATCH
        PRINT 'Error When Add Employee: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Create a stored procedure that returns the total percentage of ownership for a given owner 
CREATE PROCEDURE TotalPercentage
    @RealEstateCode INT
AS
BEGIN
    SELECT 
        SUM(Percentage) AS TotalPercentage
    FROM Ownership
	WHERE RealEstateCode = @RealEstateCode;
END
GO

SELECT * FROM Ownership

EXEC TotalPercentage 301

-- EXEC AddEmployee '1000', 'Hello', '2010-10-10', 'Ho Chi Minh', '1'
-- EXEC TotalPercentage '210'