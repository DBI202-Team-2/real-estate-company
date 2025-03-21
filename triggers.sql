CREATE TRIGGER trig_AfterInsertManager
ON Manages
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1 
		FROM inserted i
		JOIN Employee e ON i.EmpCode = e.EmpCode
		WHERE e.OfficeNo IS NULL OR i.OfficeNo <> e.OfficeNo
	)
	BEGIN
		RAISERROR ('The employee does not work at this office', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END;

	IF EXISTS (
		SELECT 1
		FROM inserted i
		JOIN Manages m ON i.OfficeNo = m.OfficeNo
	) 
	BEGIN
		RAISERROR ('There is already a manager at this office', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END

	INSERT INTO Manages
    SELECT EmpCode, OfficeNo, StartDate
    FROM inserted;
END;

CREATE TRIGGER tr_CheckOwnershipPercentage
ON Ownership
AFTER INSERT, UPDATE
AS
BEGIN
    -- Declare a variable to store real estate properties with total ownership exceeding 100%
    DECLARE @InvalidRealEstate TABLE (RealEstateCode VARCHAR(50))
    
    -- Insert into temporary table the real estate codes with total ownership exceeding 100%
    INSERT INTO @InvalidRealEstate
    SELECT O.RealEstateCode
    FROM Ownership O
    GROUP BY O.RealEstateCode
    HAVING SUM(O.Percentage) > 100
    
    -- Check if any real estate property exceeds 100%
    IF EXISTS (SELECT 1 FROM @InvalidRealEstate)
    BEGIN
        -- Create error message with list of real estate codes exceeding 100%
        DECLARE @ErrorMsg NVARCHAR(1000)
        SET @ErrorMsg = 'Error: Total ownership percentage exceeds 100%% for the following real estate properties: '
            + (SELECT STRING_AGG(RealEstateCode, ', ') FROM @InvalidRealEstate)
        
        -- Rollback transaction and display error message
        ROLLBACK TRANSACTION
        RAISERROR(@ErrorMsg, 16, 1)
        RETURN
    END
END;