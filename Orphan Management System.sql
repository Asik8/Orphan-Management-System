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

-- Inserting into Orphan
INSERT INTO Orphan (OrphanID, EstablishedDate, Name) VALUES
(1, '2005-04-15', 'Sunshine Orphanage'),
(2, '2010-08-20', 'Hope Haven'),
(3, '2015-02-10', 'Bright Future Orphanage');

-- Inserting into Child
INSERT INTO Child (ChildID, Name, DateOfBirth, Gender, OrphanID) VALUES
(1, 'Alice', '2015-05-12', 'Female', 1),
(2, 'Bob', '2014-03-25', 'Male', 1),
(3, 'Charlie', '2016-11-10', 'Male', 2),
(4, 'Daisy', '2017-06-15', 'Female', 2),
(5, 'Ella', '2018-04-20', 'Female', 3);

-- Inserting into Teacher
INSERT INTO Teacher (RoleID, Name, Subject, ContactNumber, Email, ChildID, OrphanID) VALUES
(1, 'Mr. Smith', 'Mathematics', '1234567890', 'smith@example.com', 1, 1),
(2, 'Ms. Johnson', 'Science', '9876543210', 'johnson@example.com', 2, 1),
(3, 'Mr. Adams', 'English', '4567891230', 'adams@example.com', 3, 2);

-- Inserting into Guardian
INSERT INTO Guardian (GuardianID, Name, RelationshipToChild, ContactNumber, Address, ChildID, OrphanID) VALUES
(1, 'Mrs. Green', 'Aunt', '5556667777', '123 Main St', 1, 1),
(2, 'Mr. Brown', 'Uncle', '4445556666', '456 Elm St', 2, 1),
(3, 'Mrs. White', 'Grandmother', '3334445555', '789 Oak Avenue', 4, 2);

-- Inserting into Employee
INSERT INTO Employee (EmployeeID, Name, Role, ContactNumber, Email, OrphanID, RoleID) VALUES
(1, 'Mr. Anderson', 'Manager', '1112223333', 'anderson@orphan.com', 1, 1),
(2, 'Ms. Wilson', 'Supervisor', '4445556666', 'wilson@orphan.com', 2, 2);

-- Inserting into Finance
INSERT INTO Finance (FinanceID, Amount, Date, OrphanID) VALUES
(1, 10000.00, '2023-01-15', 1),
(2, 15000.00, '2023-02-10', 2),
(3, 20000.00, '2023-03-20', 3);

-- Inserting into Donation
INSERT INTO Donation (DonationID, DonorName, Amount, Date, Purpose, FinanceID, OrphanID) VALUES
(1, 'John Doe', 5000.00, '2023-01-20', 'Education Support', 1, 1),
(2, 'Mary Smith', 7000.00, '2023-02-15', 'Healthcare Supplies', 2, 2);

-- Inserting into Scholarship
INSERT INTO Scholarships (ScholarshipID, Name, ChildID, OrphanID) VALUES
(1, 'Bright Minds Scholarship', 1, 1),
(2, 'Future Stars Scholarship', 3, 2);

-- Inserting into Education
INSERT INTO Education (EducationID, ChildID, Level, SchoolName, OrphanID) VALUES
(1, 1, 'Primary', 'Sunshine School', 1),
(2, 2, 'Secondary', 'Hope Haven Academy', 2);

-- Inserting into Health
INSERT INTO Health (HealthID, ChildID, HealthCheckupDate, Remarks, OrphanID) VALUES
(1, 1, '2023-04-15', 'Healthy', 1),
(2, 2, '2023-04-10', 'Slight Cold', 1),
(3, 5, '2023-05-20', 'Good Health', 3);

-- Inserting into Cost
INSERT INTO Cost (CostID, FinanceID, Category, Amount, Date) VALUES
(1, 1, 'Supplies', 3000.00, '2023-01-15'),
(2, 2, 'Maintenance', 4000.00, '2023-02-10');

-- Inserting into Adoption Records
INSERT INTO AdoptionRecords (AdoptionID, ChildID, DateOfAdoption, OrphanID) VALUES
(1, 2, '2022-06-15', 1),
(2, 5, '2021-08-12', 3);

-- Inserting into Events
INSERT INTO Events (EventID, Name, Date, Type, Location, OrphanID) VALUES
(1, 'Annual Charity', '2023-05-01', 'Fundraising', 'Main Hall', 1),
(2, 'Sports Day', '2023-06-10', 'Sports', 'Orphan Grounds', 2);

-- Inserting into Volunteer Management
INSERT INTO VolunteerManagement (VolunteerID, Name, ContactNumber, Role, EventID, OrphanID, ChildID) VALUES
(1, 'Sarah Brown', '5558889999', 'Organizer', 1, 1, 1),
(2, 'James Carter', '4445556666', 'Trainer', 2, 2, 2);

-- Inserting into Library
INSERT INTO Library (LibraryID, BookName, Author, Category, Availability, ChildID, OrphanID) VALUES
(1, 'Harry Potter', 'J.K. Rowling', 'Fiction', TRUE, 1, 1),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', TRUE, 2, 2);

-- Inserting into Child Performance
INSERT INTO ChildPerformance (PerformanceID, ChildID, AcademicScore, ExtracurricularScore, OverallGrade, EducationID, OrphanID) VALUES
(1, 1, 95.00, 88.00, 'A+', 1, 1),
(2, 2, 85.00, 91.00, 'A', 2, 1);

-- Insert sample data into Inventory table
INSERT INTO Inventory (InventoryID, ItemName, Quantity, Cost, SupplierName, OrphanID)
VALUES
    (1, 'Beds', 20, 5000.00, 'Supplier A', 1),
    (2, 'Books', 500, 1500.00, 'Supplier B', 1),
    (3, 'Toys', 150, 1200.00, 'Supplier C', 2),
    (4, 'Furniture', 10, 3000.00, 'Supplier D', 2),
    (5, 'Clothes', 100, 1000.00, 'Supplier E', 3),
    (6, 'Stationery', 1000, 500.00, 'Supplier F', 3),
    (7, 'Kitchen Supplies', 50, 2000.00, 'Supplier G', 1);
    
-- Inserting into Maintenance
INSERT INTO Maintenance (MaintenanceID, InventoryID, Issue, CostID, Amount, OrphanID) VALUES
(1, 1, 'Roof Repair Issue', 2, 500.00, 1);

-- Inserting into Security Staff
INSERT INTO SecurityStaff (StaffID, RoleID, Name, Shift, ContactNumber, SalaryID, OrphanID) VALUES
(1, 1, 'Michael Security', 'Day', '8000', NULL, 1);

-- Inserting into Visitors
INSERT INTO Visitors (VisitorID, Name, ContactNumber, Purpose, DateOfVisit, TimeIN, TimeOUT, OrphanID) VALUES
(1, 'Tom Visitor', '5551234567', 'Weekly Visit', '2023-09-10', '10:00', '14:00', 1);

-- Inserting into Training Programs
INSERT INTO TrainingPrograms (TrainingID, ProgramName, TrainerName, Date, Participants, OrphanID) VALUES
(1, 'Yoga Session', 'Coach Linda', '2023-09-01', 20, 1);



