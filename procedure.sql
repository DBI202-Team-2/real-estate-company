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