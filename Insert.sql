
-- Query to find all real estate properties in New York
SELECT *
FROM 
    RealEstate
WHERE 
    City =	N'Nha Trang';


-- Count the number of employees in each office
SELECT 
    o.OfficeNo,
    o.City,
    COUNT(e.EmpCode) AS EmployeeCount
FROM 
    Office o
LEFT JOIN 
    Employee e ON o.OfficeNo = e.OfficeNo
GROUP BY 
    o.OfficeNo, o.City
ORDER BY 
    o.OfficeNo;

-- Find the owner(s) who own the most percentage of each real estate
SELECT 
    r.RealEstateCode,
    r.Street,
    r.City,
    r.Type,
    o.OwnerCode,
    ow.Name AS OwnerName,
    o.Percentage
FROM 
    Ownership o
JOIN 
    RealEstate r ON o.RealEstateCode = r.RealEstateCode
JOIN 
    Owner ow ON o.OwnerCode = ow.OwnerCode
JOIN 
    (SELECT RealEstateCode, MAX(Percentage) AS MaxPercentage
     FROM Ownership
     GROUP BY RealEstateCode) mp
ON 
    o.RealEstateCode = mp.RealEstateCode AND o.Percentage = mp.MaxPercentage
ORDER BY 
    r.RealEstateCode;

-- Find the employee who manages the office located in "Los Angeles"
SELECT 
    e.EmpCode,
    e.Name AS EmployeeName,
    o.OfficeNo,
    o.City,
    m.StartDate AS ManagementStartDate
FROM 
    Employee e
JOIN 
    Manages m ON e.EmpCode = m.EmpCode
JOIN 
    Office o ON m.OfficeNo = o.OfficeNo
WHERE 
    o.City = N'Hồ Chí Minh';

-- First find offices with more than 3 employees
SELECT 
    r.RealEstateCode,
    r.LocationNo,
    r.Street,
    r.City,
    r.Type,
    o.City AS OfficeCity,
    COUNT(e.EmpCode) AS EmployeeCount
FROM 
    RealEstate r
JOIN 
    Office o ON r.OfficeNo = o.OfficeNo
JOIN 
    Employee e ON o.OfficeNo = e.OfficeNo
GROUP BY
    r.RealEstateCode, r.LocationNo, r.Street, r.City, r.Type, o.City
HAVING
    COUNT(e.EmpCode) > 3
ORDER BY
    o.City, r.RealEstateCode;



