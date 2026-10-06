-- PharmacyDB Medicine Inventory and Expiry Tracker

IF DB_ID('PharmacyDB') IS NULL
BEGIN
    CREATE DATABASE PharmacyDB;
END;
GO

USE PharmacyDB;
GO

IF OBJECT_ID('dbo.Medicine', 'U') IS NOT NULL
    DROP TABLE dbo.Medicine;
GO

CREATE TABLE dbo.Medicine
(
    MedicineID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineName NVARCHAR(100) NOT NULL,
    Stock INT NOT NULL,
    ExpiryDate DATE NOT NULL
);
GO

INSERT INTO dbo.Medicine (MedicineName, Stock, ExpiryDate)
VALUES
    ('Paracetamol', 50, '2025-06-30'),
    ('Amoxicillin', 30, '2024-12-31'),
    ('Cetirizine', 40, '2026-03-15'),
    ('Ibuprofen', 25, '2024-11-30'),
    ('Azithromycin', 20, '2025-09-30');
GO

-- Find stock expiring before 2025
SELECT MedicineID, MedicineName, Stock, ExpiryDate
FROM dbo.Medicine
WHERE ExpiryDate < '2025-01-01'
ORDER BY ExpiryDate;
GO

-- Update Paracetamol stock to 80
UPDATE dbo.Medicine
SET Stock = 80
WHERE MedicineName = 'Paracetamol';
GO

-- List everything by expiry date
SELECT MedicineID, MedicineName, Stock, ExpiryDate
FROM dbo.Medicine
ORDER BY ExpiryDate;
GO

-- Verification
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Medicine
    WHERE MedicineName = 'Paracetamol'
      AND Stock = 80
)
    THROW 50001, 'Test failed: Paracetamol stock is not 80.', 1;

PRINT 'ALL PHARMACY TESTS PASSED';
GO
