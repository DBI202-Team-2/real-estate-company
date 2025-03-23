DROP TRIGGER trig_AfterInsertManager;
GO;

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
GO;

SELECT * FROM Manages

INSERT Manages
VALUES (101, 1, '2024-08-12')

DROP TRIGGER tr_CheckOwnershipPercentage;
GO;

CREATE TRIGGER tr_CheckOwnershipPercentage
ON Ownership
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @InvalidRealEstate TABLE (RealEstateCode VARCHAR(50))

    INSERT INTO @InvalidRealEstate
    SELECT O.RealEstateCode
    FROM Ownership O
    GROUP BY O.RealEstateCode
    HAVING SUM(O.Percentage) > 100
    
    IF EXISTS (SELECT 1 FROM @InvalidRealEstate)
    BEGIN
        DECLARE @ErrorMsg NVARCHAR(1000)
        SET @ErrorMsg = 'Error: Total ownership percentage exceeds 100%% for the following real estate properties: '
            + (SELECT STRING_AGG(RealEstateCode, ', ') FROM @InvalidRealEstate)
        
        ROLLBACK TRANSACTION
        RAISERROR(@ErrorMsg, 16, 1)
        RETURN
    END
END;

SELECT * FROM Ownership

INSERT INTO Ownership
VALUES (202, 305, 10)

UPDATE Ownership
SET Percentage = 80
WHERE OwnerCode = 202 AND RealEstateCode = 307;