--Create a function that retrieves the full address of a real estate property by RealEstateCode (@RealEstateCode INT).
CREATE FUNCTION GetRealEstateFullAddress (@RealEstateCode INT)
RETURNS NVARCHAR(500)
AS
BEGIN
    DECLARE @FullAddress NVARCHAR(500)

    SELECT @FullAddress = CONCAT(Street, ', ', City)
    FROM RealEstate
    WHERE RealEstateCode = @RealEstateCode

    RETURN @FullAddress
END;

SELECT dbo.GetRealEstateFullAddress(302) AS FullAddress;

DROP FUNCTION GetTopManagingOffice

--Create a function that finds the office that manages the highest number of properties (No parameter required).
CREATE FUNCTION GetTopManagingOffice()
RETURNS @Result TABLE (
    OfficeNo INT,
    City NVARCHAR(50),
    RealEstateCount INT
)
AS
BEGIN
    INSERT INTO @Result
    SELECT TOP 1 WITH TIES 
		o.OfficeNo, 
		o.City, 
		COUNT(r.RealEstateCode) AS RealEstateCount
    FROM Office o
    JOIN RealEstate r ON o.OfficeNo = r.OfficeNo
    GROUP BY o.OfficeNo, o.City
    ORDER BY RealEstateCount DESC;

    RETURN;
END;