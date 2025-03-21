USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name='Real_Estates')
    DROP DATABASE Real_Estates
GO

CREATE DATABASE Real_Estates
GO 

USE Real_Estates
GO

CREATE TABLE Office (
    OfficeNo INT PRIMARY KEY,
    City NVARCHAR(50)
);

CREATE TABLE Employee (
    EmpCode INT PRIMARY KEY,
    Name NVARCHAR(50),
    DayOfBirth DATE,
    Address NVARCHAR(200),
    OfficeNo INT,
    FOREIGN KEY (OfficeNo) REFERENCES Office(OfficeNo)
);

CREATE TABLE Owner (
    OwnerCode INT PRIMARY KEY,
    Name NVARCHAR(50),
    Address NVARCHAR(200),
    Phone VARCHAR(15)
);

CREATE TABLE RealEstate (
    RealEstateCode INT PRIMARY KEY,
    LocationNo VARCHAR(20),
    Street NVARCHAR(200),
    City NVARCHAR(50),
    Type NVARCHAR(50),
    OfficeNo INT,
    FOREIGN KEY (OfficeNo) REFERENCES Office(OfficeNo)
);

CREATE TABLE Manages (
    EmpCode INT,
    OfficeNo INT,
    StartDate DATE,
    PRIMARY KEY (EmpCode, OfficeNo),
    FOREIGN KEY (EmpCode) REFERENCES Employee(EmpCode),
    FOREIGN KEY (OfficeNo) REFERENCES Office(OfficeNo)
);

CREATE TABLE Ownership (
    OwnerCode INT,
    RealEstateCode INT,
    Percentage INT CHECK (Percentage > 0 AND Percentage <= 100),
    PRIMARY KEY (OwnerCode, RealEstateCode),
    FOREIGN KEY (OwnerCode) REFERENCES Owner(OwnerCode) ON DELETE CASCADE,
    FOREIGN KEY (RealEstateCode) REFERENCES RealEstate(RealEstateCode) ON DELETE CASCADE
);

INSERT INTO Office (OfficeNo, City) VALUES 
(1, N'Hà Nội'),
(2, N'Hồ Chí Minh'),
(3, N'Đà Nẵng'),
(4, N'Nha Trang'),
(5, N'Hải Phòng');

-- Insert data for Employee table with more employees and varied distribution
INSERT INTO Employee (EmpCode, Name, DayOfBirth, Address, OfficeNo) VALUES 
-- Hà Nội office (8 employees)
(101, N'Nguyễn Văn An', '1985-05-10', N'Hà Nội', 1),
(102, N'Trần Thị Bình', '1990-08-15', N'Hà Nội', 1),
(103, N'Lê Minh Cường', '1988-04-20', N'Hà Nội', 1),
(104, N'Phạm Thị Dung', '1992-11-05', N'Hà Nội', 1),
(105, N'Hoàng Văn Em', '1987-01-30', N'Hà Nội', 1),
(106, N'Đỗ Thị Phương', '1991-07-12', N'Hà Nội', 1),
(107, N'Vũ Văn Giang', '1989-09-25', N'Hà Nội', 1),
(108, N'Mai Thị Hương', '1993-03-18', N'Hà Nội', 1),

-- Hồ Chí Minh office (12 employees)
(201, N'Đặng Văn Ích', '1986-06-08', N'Hồ Chí Minh', 2),
(202, N'Ngô Thị Kim', '1994-12-27', N'Hồ Chí Minh', 2),
(203, N'Bùi Văn Long', '1988-10-15', N'Hồ Chí Minh', 2),
(204, N'Lý Thị Mỹ', '1991-03-22', N'Hồ Chí Minh', 2),
(205, N'Trịnh Văn Nam', '1987-05-18', N'Hồ Chí Minh', 2),
(206, N'Hồ Thị Oanh', '1993-09-30', N'Hồ Chí Minh', 2),
(207, N'Đinh Văn Phúc', '1989-11-05', N'Hồ Chí Minh', 2),
(208, N'Tạ Thị Quỳnh', '1992-04-17', N'Hồ Chí Minh', 2),
(209, N'Lưu Văn Sơn', '1986-08-29', N'Hồ Chí Minh', 2),
(210, N'Dương Thị Tâm', '1990-01-12', N'Hồ Chí Minh', 2),
(211, N'Cao Văn Uy', '1995-06-21', N'Hồ Chí Minh', 2),
(212, N'Đoàn Thị Vân', '1988-12-09', N'Hồ Chí Minh', 2),

-- Đà Nẵng office (5 employees)
(301, N'Trương Văn Xuân', '1987-07-14', N'Đà Nẵng', 3),
(302, N'Mạc Thị Yến', '1992-02-28', N'Đà Nẵng', 3),
(303, N'Hà Văn Zung', '1989-04-16', N'Đà Nẵng', 3),
(304, N'Phan Thị Ánh', '1993-08-31', N'Đà Nẵng', 3),
(305, N'Tống Văn Bảo', '1986-05-25', N'Đà Nẵng', 3),

-- Nha Trang office (3 employees)
(401, N'Lương Thị Châu', '1991-06-19', N'Nha Trang', 4),
(402, N'Thái Văn Đạt', '1988-09-23', N'Nha Trang', 4),
(403, N'Lại Thị Em', '1994-01-07', N'Nha Trang', 4),

-- Hải Phòng office (7 employees)
(501, N'Châu Văn Phúc', '1987-11-30', N'Hải Phòng', 5),
(502, N'Huỳnh Thị Giáng', '1993-05-14', N'Hải Phòng', 5),
(503, N'Kiều Văn Hải', '1989-07-18', N'Hải Phòng', 5),
(504, N'Chu Thị Lan', '1992-10-22', N'Hải Phòng', 5),
(505, N'Diệp Văn Minh', '1986-03-26', N'Hải Phòng', 5),
(506, N'Quách Thị Nga', '1990-12-10', N'Hải Phòng', 5),
(507, N'Khúc Văn Oanh', '1995-02-14', N'Hải Phòng', 5);

-- Insert data for Owner table with simplified addresses
INSERT INTO Owner (OwnerCode, Name, Address, Phone) VALUES 
(201, N'Trần Văn Hùng', N'Hà Nội', '0912345678'),
(202, N'Nguyễn Thị Mai', N'Hà Nội', '0987654321'),
(203, N'Lê Minh Tuấn', N'Hồ Chí Minh', '0923456789'),
(204, N'Phạm Văn Nam', N'Hồ Chí Minh', '0976543210'),
(205, N'Hoàng Thị Quỳnh', N'Đà Nẵng', '0934567890'),
(206, N'Vũ Đình Sơn', N'Nha Trang', '0965432109'),
(207, N'Đỗ Văn Thịnh', N'Hải Phòng', '0945678901'),
(208, N'Đặng Thu Hương', N'Hà Nội', '0956789012'),
(209, N'Ngô Minh Đức', N'Hồ Chí Minh', '0967890123'),
(210, N'Lê Thị Hồng', N'Đà Nẵng', '0978901234');

-- Insert data for RealEstate table
INSERT INTO RealEstate (RealEstateCode, LocationNo, Street, City, Type, OfficeNo) VALUES 
(301, 'HN001', N'Láng Hạ', N'Hà Nội', N'Căn hộ chung cư', 1),
(302, 'HN002', N'Nguyễn Chí Thanh', N'Hà Nội', N'Nhà phố', 1),
(303, 'HN003', N'Liễu Giai', N'Hà Nội', N'Biệt thự', 1),
(304, 'HCM001', N'Nguyễn Văn Linh', N'Hồ Chí Minh', N'Căn hộ chung cư', 2),
(305, 'HCM002', N'Lê Văn Sỹ', N'Hồ Chí Minh', N'Nhà phố', 2),
(306, 'HCM003', N'Điện Biên Phủ', N'Hồ Chí Minh', N'Đất nền', 2),
(307, 'DN001', N'Ngô Quyền', N'Đà Nẵng', N'Căn hộ chung cư', 3),
(308, 'DN002', N'Phan Châu Trinh', N'Đà Nẵng', N'Biệt thự biển', 3),
(309, 'NT001', N'Trần Phú', N'Nha Trang', N'Condotel', 4),
(310, 'NT002', N'Phạm Văn Đồng', N'Nha Trang', N'Biệt thự biển', 4),
(311, 'HP001', N'Trần Nguyên Hãn', N'Hải Phòng', N'Căn hộ chung cư', 5),
(312, 'HP002', N'Lạch Tray', N'Hải Phòng', N'Shophouse', 5);

-- Insert data for Manages table (each office has one manager)
INSERT INTO Manages (EmpCode, OfficeNo, StartDate) VALUES 
(101, 1, '2020-01-15'), -- Nguyễn Văn An manages Hà Nội office
(201, 2, '2020-02-10'), -- Đặng Văn Ích manages Hồ Chí Minh office
(301, 3, '2020-03-05'), -- Trương Văn Xuân manages Đà Nẵng office
(401, 4, '2020-04-20'), -- Lương Thị Châu manages Nha Trang office
(501, 5, '2020-05-12'); -- Châu Văn Phúc manages Hải Phòng office

-- Insert data for Ownership table with percentage of ownership
INSERT INTO Ownership (OwnerCode, RealEstateCode, Percentage) VALUES
-- Trần Văn Hùng owns multiple properties
(201, 301, 100),  -- 100% ownership of property 301
(201, 302, 100),  -- 100% ownership of property 302
(201, 307, 50),   -- 50% ownership of property 307

-- Nguyễn Thị Mai owns multiple properties
(202, 303, 100),  -- 100% ownership of property 303
(202, 308, 100),  -- 100% ownership of property 308
(202, 307, 50),   -- 50% ownership of property 307 (shared with 201)

-- Lê Minh Tuấn owns multiple properties
(203, 304, 100),  -- 100% ownership of property 304
(203, 309, 70),   -- 70% ownership of property 309

-- Phạm Văn Nam owns multiple properties
(204, 305, 100),  -- 100% ownership of property 305
(204, 310, 60),   -- 60% ownership of property 310

-- Hoàng Thị Quỳnh owns multiple properties
(205, 306, 100),  -- 100% ownership of property 306
(205, 311, 80),   -- 80% ownership of property 311

-- Properties with multiple owners
(206, 312, 40),   -- 40% ownership of property 312
(207, 312, 35),   -- 35% ownership of property 312
(208, 312, 25),   -- 25% ownership of property 312

(208, 309, 30),   -- 30% ownership of property 309 (shared with 203)

(209, 310, 40),   -- 40% ownership of property 310 (shared with 204)

(210, 311, 20);   -- 20% ownership of property 311 (shared with 205)