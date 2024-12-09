-- CREATE DATABASE Orphan;
USE Orphan;
-- drop database Orphan;
-- 1. Orphan
CREATE TABLE Orphan (
    OrphanID INT PRIMARY KEY,
    EstablishedDate DATE,
    Name VARCHAR(255)
);

-- 2. Child
CREATE TABLE Child (
    ChildID INT PRIMARY KEY,
    Name VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    OrphanID INT
);

-- 3. Teacher
CREATE TABLE Teacher (
    RoleID INT PRIMARY KEY,
    Name VARCHAR(255),
    Subject VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255),
    ChildID INT,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 4. Guardian
CREATE TABLE Guardian (
    GuardianID INT PRIMARY KEY,
    Name VARCHAR(255),
    RelationshipToChild VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT,
    ChildID INT,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 5. Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255),
    OrphanID INT,
    RoleID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID),
    FOREIGN KEY (RoleID) REFERENCES Teacher(RoleID)
);

-- 6. Finance
CREATE TABLE Finance (
    FinanceID INT PRIMARY KEY,
    Amount DECIMAL(10, 2),
    Date DATE,
    OrphanID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 7. Salary Management
CREATE TABLE SalaryManagement (
    SalaryID INT PRIMARY KEY,
    RoleID INT,
    SalaryAmount DECIMAL(10, 2),
    PaymentDate DATE,
    OrphanID INT,
    FinanceID INT,
    FOREIGN KEY (RoleID) REFERENCES Teacher(RoleID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID),
    FOREIGN KEY (FinanceID) REFERENCES Finance(FinanceID)
);

-- 8. Donation
CREATE TABLE Donation (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(255),
    Amount DECIMAL(10, 2),
    Date DATE,
    Purpose VARCHAR(255),
    FinanceID INT,
    OrphanID INT,
    FOREIGN KEY (FinanceID) REFERENCES Finance(FinanceID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 9. Education
CREATE TABLE Education (
    EducationID INT PRIMARY KEY,
    ChildID INT,
    Level VARCHAR(50),
    SchoolName VARCHAR(255),
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 10. Health
CREATE TABLE Health (
    HealthID INT PRIMARY KEY,
    ChildID INT,
    HealthCheckupDate DATE,
    Remarks VARCHAR(255),
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 11. Doctors
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(255),
    Specialization VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255),
    HealthID INT,
    ChildID INT,
    FOREIGN KEY (HealthID) REFERENCES Health(HealthID),
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
);

-- 12. Cost
CREATE TABLE Cost (
    CostID INT PRIMARY KEY,
    FinanceID INT,
    Category VARCHAR(255),
    Amount DECIMAL(10, 2),
    Date DATE,
    FOREIGN KEY (FinanceID) REFERENCES Finance(FinanceID)
);

-- 13. Alumni
CREATE TABLE Alumni (
    AlumniID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    YearOfGraduation YEAR,
    CurrentStatus VARCHAR(255),
    OrphanID INT,
    ChildID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID),
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
);

-- 14. Admission
CREATE TABLE Admission (
    AdmissionID INT PRIMARY KEY,
    ChildID INT,
    DateOfAdmission DATE,
    ClassEnrolled VARCHAR(50),
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 15. Events
CREATE TABLE Events (
    EventID INT PRIMARY KEY,
    Name VARCHAR(255),
    Date DATE,
    Type VARCHAR(50),
    Location VARCHAR(255),
    OrphanID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 16. Volunteer Management
CREATE TABLE VolunteerManagement (
    VolunteerID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    Role VARCHAR(255),
    EventID INT,
    OrphanID INT,
    ChildID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID),
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
);

-- 17. Inventory
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    Quantity INT,
    Cost DECIMAL(10, 2),
    SupplierName VARCHAR(255),
    OrphanID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);


-- 18. Maintenance
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    InventoryID INT,
    Issue TEXT,
    CostID INT,
    Amount DECIMAL(10, 2),
    OrphanID INT,
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
    FOREIGN KEY (CostID) REFERENCES Cost(CostID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);
-- drop table Maintenance;

-- 19. Security Staff
CREATE TABLE SecurityStaff (
    StaffID INT PRIMARY KEY,
    RoleID INT,
    Name VARCHAR(255),
    Shift VARCHAR(50),
    ContactNumber VARCHAR(20),
    SalaryID INT,
    OrphanID INT,
    FOREIGN KEY (RoleID) REFERENCES Teacher(RoleID),
    FOREIGN KEY (SalaryID) REFERENCES SalaryManagement(SalaryID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 20. Visitors
CREATE TABLE Visitors (
    VisitorID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactNumber VARCHAR(20),
    Purpose VARCHAR(255),
    DateOfVisit DATE,
    TimeIN TIME,
    TimeOUT TIME,
    OrphanID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 21. Training Programs
CREATE TABLE TrainingPrograms (
    TrainingID INT PRIMARY KEY,
    ProgramName VARCHAR(255),
    TrainerName VARCHAR(255),
    Date DATE,
    Participants INT,
    OrphanID INT,
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 22. Scholarships
CREATE TABLE Scholarships (
    ScholarshipID INT PRIMARY KEY,
    Name VARCHAR(255),
    ChildID INT,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 23. Library
CREATE TABLE Library (
    LibraryID INT PRIMARY KEY,
    BookName VARCHAR(255),
    Author VARCHAR(255),
    Category VARCHAR(255),
    Availability boolean,
    ChildID INT,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 24. Child Performance
CREATE TABLE ChildPerformance (
    PerformanceID INT PRIMARY KEY,
    ChildID INT,
    AcademicScore DECIMAL(5, 2),
    ExtracurricularScore DECIMAL(5, 2),
    OverallGrade VARCHAR(5),
    EducationID INT,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (EducationID) REFERENCES Education(EducationID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- 25. Adoption Records
CREATE TABLE AdoptionRecords (
    AdoptionID INT PRIMARY KEY,
    ChildID INT,
    DateOfAdoption DATE,
    OrphanID INT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    FOREIGN KEY (OrphanID) REFERENCES Orphan(OrphanID)
);

-- Inserting data into the Orphan table
INSERT INTO Orphan (OrphanID, EstablishedDate, Name) 
VALUES 
(1001, '2005-03-15', 'Hope Haven Orphanage'),
(1002, '2010-08-20', 'Sunshine Children Home'),
(1003, '1998-01-10', 'Bright Futures Orphanage'),
(1004, '2015-07-05', 'Little Angels Home'),
(1005, '2000-11-25', 'Safe Haven Orphanage');

-- Inserting data into the Child table
INSERT INTO Child (ChildID, Name, DateOfBirth, Gender, OrphanID)
VALUES
-- Data for OrphanID 1
(1, 'Alice Johnson', '2012-05-14', 'Female', 1001),
(2, 'Robert Smith', '2011-11-23', 'Male', 1001),
(3, 'Emily Davis', '2013-07-09', 'Female', 1001),
(4, 'Michael Brown', '2010-03-15', 'Male', 1001),
(5, 'Sophia Wilson', '2012-12-01', 'Female', 1001),
(6, 'James Martinez', '2011-06-18', 'Male', 1001),
(7, 'Isabella Garcia', '2014-09-25', 'Female', 1001),
(8, 'William Lee', '2009-04-10', 'Male', 1001),
(9, 'Mia Gonzalez', '2013-01-30', 'Female', 1001),
(10, 'Ethan Walker', '2012-08-05', 'Male', 1001),

-- Data for OrphanID 2
(11, 'Olivia Harris', '2012-10-11', 'Female', 1002),
(12, 'Alexander Clark', '2010-12-22', 'Male', 1002),
(13, 'Charlotte Lewis', '2011-07-17', 'Female', 1002),
(14, 'Benjamin Hall', '2013-05-04', 'Male', 1002),
(15, 'Ava Young', '2014-03-08', 'Female', 1002),
(16, 'Noah Allen', '2009-09-29', 'Male', 1002),
(17, 'Lily King', '2012-02-19', 'Female', 1002),
(18, 'Henry Wright', '2011-11-03', 'Male', 1002),
(19, 'Grace Scott', '2010-08-14', 'Female', 1002),
(20, 'Logan Adams', '2013-06-26', 'Male', 1002),

-- Data for OrphanID 3
(21, 'Ella Perez', '2012-04-20', 'Female', 1003),
(22, 'Daniel Baker', '2010-07-07', 'Male', 1003),
(23, 'Harper Rivera', '2011-10-10', 'Female', 1003),
(24, 'Jack Phillips', '2013-02-16', 'Male', 1003),
(25, 'Scarlett Evans', '2014-01-12', 'Female', 1003),
(26, 'Lucas Turner', '2009-03-05', 'Male', 1003),
(27, 'Hannah Parker', '2011-08-22', 'Female', 1003),
(28, 'Jackson Campbell', '2012-06-03', 'Male', 1003),
(29, 'Aubrey Ward', '2013-09-19', 'Female', 1003),
(30, 'Levi Cox', '2010-05-25', 'Male', 1003),

-- Data for OrphanID 4
(31, 'Victoria Roberts', '2011-01-14', 'Female', 1004),
(32, 'Sebastian Price', '2009-11-11', 'Male', 1004),
(33, 'Aria Rogers', '2010-03-22', 'Female', 1004),
(34, 'Elijah Stewart', '2013-12-07', 'Male', 1004),
(35, 'Zoe Ramirez', '2012-08-15', 'Female', 1004),
(36, 'Matthew Gray', '2011-04-18', 'Male', 1004),
(37, 'Savannah Lopez', '2013-06-10', 'Female', 1004),
(38, 'Nathan Brooks', '2009-02-28', 'Male', 1004),
(39, 'Avery Powell', '2014-09-05', 'Female', 1004),
(40, 'Julian Flores', '2012-10-20', 'Male', 1004),

-- Data for OrphanID 5
(41, 'Chloe Watson', '2010-11-15', 'Female', 1005),
(42, 'Liam Bennett', '2009-05-06', 'Male', 1005),
(43, 'Amelia Sanders', '2011-09-21', 'Female', 1005),
(44, 'Eli Ward', '2013-04-12', 'Male', 1005),
(45, 'Abigail James', '2012-03-17', 'Female', 1005),
(46, 'Owen Patterson', '2009-08-30', 'Male', 1005),
(47, 'Ella Ross', '2011-12-08', 'Female', 1005),
(48, 'Gabriel Peterson', '2014-07-16', 'Male', 1005),
(49, 'Sophie Murphy', '2010-06-04', 'Female', 1005),
(50, 'Carter Bell', '2012-02-25', 'Male', 1005);


-- Inserting data into the Teacher table
INSERT INTO Teacher (RoleID, Name, Subject, ContactNumber, Email, ChildID, OrphanID) 
VALUES 
-- Teachers for OrphanID 1001
(1, 'John Williams', 'Mathematics', '555-1010', 'john.williams@orphans.org', 1, 1001),
(2, 'Mary Johnson', 'English', '555-1020', 'mary.johnson@orphans.org', 2, 1001),
(3, 'David Brown', 'Science', '555-1030', 'david.brown@orphans.org', 3, 1001),
(4, 'Linda Smith', 'History', '555-1040', 'linda.smith@orphans.org', 4, 1001),

-- Teachers for OrphanID 1002
(5, 'Michael Jones', 'Mathematics', '555-2010', 'michael.jones@orphans.org', 11, 1002),
(6, 'Emily Davis', 'English', '555-2020', 'emily.davis@orphans.org', 12, 1002),
(7, 'William Taylor', 'Science', '555-2030', 'william.taylor@orphans.org', 13, 1002),
(8, 'Sarah Moore', 'History', '555-2040', 'sarah.moore@orphans.org', 14, 1002),

-- Teachers for OrphanID 1003
(9, 'James White', 'Mathematics', '555-3010', 'james.white@orphans.org', 21, 1003),
(10, 'Elizabeth Thomas', 'English', '555-3020', 'elizabeth.thomas@orphans.org', 22, 1003),
(11, 'Benjamin Harris', 'Science', '555-3030', 'benjamin.harris@orphans.org', 23, 1003),
(12, 'Susan Martin', 'History', '555-3040', 'susan.martin@orphans.org', 24, 1003),

-- Teachers for OrphanID 1004
(13, 'Christopher Lee', 'Mathematics', '555-4010', 'christopher.lee@orphans.org', 31, 1004),
(14, 'Emma Walker', 'English', '555-4020', 'emma.walker@orphans.org', 32, 1004),
(15, 'Andrew Hall', 'Science', '555-4030', 'andrew.hall@orphans.org', 33, 1004),
(16, 'Sophia Allen', 'History', '555-4040', 'sophia.allen@orphans.org', 34, 1004),

-- Teachers for OrphanID 1005
(17, 'Matthew Young', 'Mathematics', '555-5010', 'matthew.young@orphans.org', 41, 1005),
(18, 'Olivia King', 'English', '555-5020', 'olivia.king@orphans.org', 42, 1005),
(19, 'Joshua Scott', 'Science', '555-5030', 'joshua.scott@orphans.org', 43, 1005),
(20, 'Mia Wright', 'History', '555-5040', 'mia.wright@orphans.org', 44, 1005);
