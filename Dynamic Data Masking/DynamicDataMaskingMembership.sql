Use AdventureWorks
-- table with masked columns
CREATE TABLE Person.Membership (
    MemberID INT IDENTITY(1, 1) NOT NULL PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(100) MASKED WITH (FUNCTION = 'partial(1, "xxxxx", 1)') NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(12) MASKED WITH (FUNCTION = 'default()') NULL,
    Email VARCHAR(100) MASKED WITH (FUNCTION = 'email()') NOT NULL,
    DiscountCode SMALLINT MASKED WITH (FUNCTION = 'random(1, 100)') NULL
);

-- inserting sample data
INSERT INTO Person.Membership (FirstName, LastName, Phone, Email, DiscountCode)
VALUES
('Roberto', 'Tamburello', '555.123.4567', 'RTamburello@contoso.com', 10),
('Janice', 'Galvin', '555.123.4568', 'JGalvin@contoso.com.co', 5),
('Shakti', 'Menon', '555.123.4570', 'SMenon@contoso.net', 50),
('Zheng', 'Mu', '555.123.4569', 'ZMu@contoso.net', 40);
GO
