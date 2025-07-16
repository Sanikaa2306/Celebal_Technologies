
--task 1:

-- Create the table and Inserting  the sample data
CREATE TABLE Projects (
    Task_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE
);

 
INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');

--query for task 1
WITH NumberedTasks AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY Start_Date) 
           - DATEDIFF(DAY, '2000-01-01', Start_Date) AS grp
    FROM Projects
),
GroupedProjects AS (
    SELECT 
        MIN(Start_Date) AS Project_Start,
        MAX(End_Date) AS Project_End,
        DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)) + 1 AS Duration
    FROM NumberedTasks
    GROUP BY grp
)
SELECT 
    Project_Start, 
    Project_End
FROM GroupedProjects
ORDER BY Duration ASC, Project_Start ASC;


--task 2:

-- Create Students table
CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Create Friends table
CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

-- Create Packages table
CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

-- Insert into Students
INSERT INTO Students (ID, Name) VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Insert into Friends
INSERT INTO Friends (ID, Friend_ID) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Insert into Packages
INSERT INTO Packages (ID, Salary) VALUES
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);

--query for task 2
SELECT S.Name
FROM Students S JOIN Friends F ON S.ID = F.ID JOIN Packages SP ON S.ID = SP.ID
JOIN Packages FP ON F.Friend_ID = FP.ID
WHERE FP.Salary > SP.Salary
ORDER BY FP.Salary;


--task 3:

--creating table functions and inserting values
CREATE TABLE Functions (
    X INT,
    Y INT
);

INSERT INTO Functions (X, Y) VALUES
(20, 20),
(20, 20),
(20, 21),
(23, 22),
(22, 23),
(21, 20);

--query for task 3
SELECT DISTINCT f1.X, f1.Y
FROM Functions f1 JOIN Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
ORDER BY f1.X;

--task 4:
--creating contest table
CREATE TABLE Contest (
    contest_id INT,
    hacker_id INT,
    name VARCHAR(255),
    PRIMARY KEY (contest_id)
);

INSERT INTO Contest (contest_id, hacker_id, name) VALUES
(66406, 17973, 'Rose'),
(66556, 79153, 'Angela'),
(94828, 80275, 'Frank');


--creating College1 table

CREATE TABLE College1 (
    college_id INT,
    contest_id INT,
    PRIMARY KEY (college_id, contest_id)
);

INSERT INTO College1 (college_id, contest_id) VALUES
(11219, 66406),
(32473, 66556),
(56685, 94828);

--creating Challenge table

CREATE TABLE Challenge (
    challenge_id INT,
    college_id INT,
    PRIMARY KEY (challenge_id)
);
INSERT INTO Challenge (challenge_id, college_id) VALUES
(18765, 11219),
(47127, 11219),
(60292, 32473),
(72974, 56685);

--creating View_Status table

CREATE TABLE View_Status (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
);

INSERT INTO View_Status (challenge_id, total_views, total_unique_views) VALUES
(47127, 26, 19),
(47127, 15, 14),
(18765, 43, 10),
(18765, 72, 13),
(75516, 35, 17),
(60292, 11, 10),
(72974, 41, 15),
(75516, 75, 11);


--creating Submission_Status table
CREATE TABLE Submission_Status (
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

INSERT INTO Submission_Status (challenge_id, total_submissions, total_accepted_submissions) VALUES
(75516, 34, 12),
(47127, 27, 10),
(47127, 56, 18),
(75516, 74, 12),
(75516, 83, 8),
(72974, 66, 24),
(72974, 82, 14),
(47127, 28, 11);


--query for task 4
SELECT c.contest_id, c.hacker_id, c.name,
       SUM(ss.total_submissions) AS total_submissions,
       SUM(ss.total_accepted_submissions) AS total_accepted_submissions,
       SUM(vs.total_views) AS total_views,
       SUM(vs.total_unique_views) AS total_unique_views
FROM Contest c
JOIN College1 col ON c.contest_id = col.contest_id
JOIN Challenge ch ON col.college_id = ch.college_id
LEFT JOIN Submission_Status ss ON ch.challenge_id = ss.challenge_id
LEFT JOIN View_Status vs ON ch.challenge_id = vs.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING SUM(ss.total_submissions) IS NOT NULL AND
       SUM(ss.total_accepted_submissions) IS NOT NULL AND
       SUM(vs.total_views) IS NOT NULL AND
       SUM(vs.total_unique_views) IS NOT NULL;


--task 5:

-- Create Hackers Table
CREATE TABLE Hackers (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO Hackers (hacker_id, name) VALUES
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

-- Create Submissions Table
CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    score INT,
    FOREIGN KEY (hacker_id) REFERENCES Hackers(hacker_id)
);

INSERT INTO Submissions (submission_date, submission_id, hacker_id, score) VALUES
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 42769, 79722, 25),
('2016-03-02', 44364, 79722, 60),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 45),
('2016-03-05', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-06', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);


--query for task 5
WITH DailySubmissions AS (
    SELECT submission_date,hacker_id,COUNT(*) AS submission_count
    FROM Submissions
    WHERE submission_date BETWEEN '2016-03-01' AND '2016-03-15'
    GROUP BY submission_date,hacker_id
),

MaxSubmissions AS (
    SELECT submission_date,hacker_id,submission_count,
        RANK() OVER (PARTITION BY submission_date ORDER BY submission_count DESC, hacker_id ASC) AS rank
    FROM DailySubmissions
)

SELECT submission_date,COUNT(DISTINCT hacker_id) AS total_hackers,hacker_id,
    (SELECT name FROM Hackers WHERE hacker_id = m.hacker_id) AS name
FROM
    MaxSubmissions m
WHERE
    rank = 1
GROUP BY
    submission_date,
    hacker_id
ORDER BY
    submission_date;


--task 6:
CREATE TABLE STATION (
    ID int ,
    CITY VARCHAR(21),
    STATE VARCHAR(2),
    LAT_N float,
    LONG_W float
);

INSERT INTO STATION (ID, CITY, STATE, LAT_N, LONG_W) VALUES
(1, 'CityA', 'CA', 34.0522, -118.2437),
(2, 'CityB', 'NY', 40.7128, -74.0060),
(3, 'CityC', 'TX', 29.7604, -95.3698);


--query for task 6
SELECT 
    MIN(LAT_N) AS Min_Latitude,
    MIN(LONG_W) AS Min_Longitude,
    MAX(LONG_W) AS Max_Longitude
FROM 
    STATION;

WITH StationValues AS (
    SELECT 
        MIN(LAT_N) AS Min_Latitude,
        MIN(LONG_W) AS Min_Longitude,
        MAX(LONG_W) AS Max_Longitude
    FROM 
        STATION
)
SELECT 
    (ABS(a - b) + ABS(Min_Latitude - Min_Longitude) ) AS Manhattan_Distance
FROM 
    StationValues,
    (SELECT Min_Latitude AS a, Max_Longitude AS b FROM StationValues) AS Point1,
    (SELECT Min_Longitude AS c, Max_Longitude AS d FROM StationValues) AS Point2;

--task 7:

--query for task 7
WITH Numbers AS (
    SELECT TOP (1000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master..spt_values
),
Primes AS (
    SELECT n
    FROM Numbers
    WHERE n > 1
    AND NOT EXISTS (
        SELECT 1
        FROM Numbers n2
        WHERE n2.n < n AND n % n2.n = 0
    )
)
SELECT STRING_AGG(n, '&') AS PrimeNumbers
FROM Primes;

--task 8:

CREATE TABLE OCCUPATIONS (
    Name VARCHAR(50),
    Occupation VARCHAR(50)
);
INSERT INTO OCCUPATIONS (Name, Occupation) VALUES
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashely', 'Professor'),
('Ketty', 'Professor'),
('Chisteen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');


--query for task 8
SELECT 
    CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
    CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
    CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
    CASE WHEN Occupation = 'Actor' THEN Name END AS Actor
FROM 
    OCCUPATIONS
ORDER BY 
    Occupation, Name;


--task 9:
--creating BST table and inserting values to BST table
CREATE TABLE BST (
    N INT,
    P INT
);

INSERT INTO BST (N, P) VALUES
(1, 2),
(3, 2),
(6, 8),
(9, 8),
(2, 5),
(5, NULL);

--query for task 9
SELECT N,
    CASE 
        WHEN P IS NULL THEN 'Root' 
        WHEN N NOT IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf' -- Node is leaf if it's not a parent of any node
        ELSE 'Inner' 
    END AS NodeType
FROM BST
ORDER BY N; 


--task 10:

-- Create the Company Table
CREATE TABLE Company (
    company_code VARCHAR(10) PRIMARY KEY,
    founder VARCHAR(50)
);

-- Create the Lead_Manager Table
CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(10) PRIMARY KEY,
    company_code VARCHAR(10),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

-- Create the Senior_Manager Table
CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(10) PRIMARY KEY,
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

-- Create the Manager Table
CREATE TABLE Manager3 (
    manager_code VARCHAR(10) PRIMARY KEY,
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10),
    FOREIGN KEY (senior_manager_code) REFERENCES Senior_Manager(senior_manager_code),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

-- Create the Employee Table
CREATE TABLE Employee3 (
    employee_code VARCHAR(10) PRIMARY KEY,
    manager_code VARCHAR(10),
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10),
    FOREIGN KEY (manager_code) REFERENCES Manager3(manager_code),
    FOREIGN KEY (senior_manager_code) REFERENCES Senior_Manager(senior_manager_code),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

-- Insert Data into Company Table
INSERT INTO Company (company_code, founder)
VALUES 
    ('C1', 'Monika'), 
    ('C2', 'Samantha');

-- Insert Data into Lead_Manager Table
INSERT INTO Lead_Manager (lead_manager_code, company_code)
VALUES 
    ('LM1', 'C1'), 
    ('LM2', 'C2');

-- Insert Data into Senior_Manager Table
INSERT INTO Senior_Manager (senior_manager_code, lead_manager_code, company_code)
VALUES 
    ('SM1', 'LM1', 'C1'), 
    ('SM2', 'LM1', 'C1'), 
    ('SM3', 'LM2', 'C2');

-- Insert Data into Manager Table
INSERT INTO Manager3 (manager_code, senior_manager_code, lead_manager_code, company_code)
VALUES 
    ('M1', 'SM1', 'LM1', 'C1'),
    ('M2', 'SM3', 'LM2', 'C2'),
    ('M3', 'SM3', 'LM2', 'C2');

-- Insert Data into Employee Table
INSERT INTO Employee3 (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code)
VALUES 
    ('E1', 'M1', 'SM1', 'LM1', 'C1'), 
    ('E2', 'M1', 'SM1', 'LM1', 'C1'), 
    ('E3', 'M2', 'SM3', 'LM2', 'C2'), 
    ('E4', 'M3', 'SM3', 'LM2', 'C2');


--query for task 10
SELECT 
    C.company_code,
    C.founder,
    COUNT(DISTINCT LM.lead_manager_code) AS total_lead_managers,
    COUNT(DISTINCT SM.senior_manager_code) AS total_senior_managers,
    COUNT(DISTINCT M.manager_code) AS total_managers,
    COUNT(DISTINCT E.employee_code) AS total_employees
FROM 
    Company C
LEFT JOIN 
    Lead_Manager LM ON C.company_code = LM.company_code
LEFT JOIN 
    Senior_Manager SM ON LM.lead_manager_code = SM.lead_manager_code AND C.company_code = SM.company_code
LEFT JOIN 
    Manager3 M ON SM.senior_manager_code = M.senior_manager_code AND C.company_code = M.company_code
LEFT JOIN 
    Employee3 E ON M.manager_code = E.manager_code AND C.company_code = E.company_code
GROUP BY 
    C.company_code, C.founder
ORDER BY 
    C.company_code;



--task 11:
-- Create Students Table
CREATE TABLE Students3 (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Create Friends Table
CREATE TABLE Friends3 (
    ID INT PRIMARY KEY,
    Friend_ID INT,
    FOREIGN KEY (Friend_ID) REFERENCES Students(ID)
);

-- Create Packages Table
CREATE TABLE Packages3 (
    ID INT PRIMARY KEY,
    Salary FLOAT
);

-- Insert data into Students Table
INSERT INTO Students3 (ID, Name) VALUES 
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Insert data into Friends Table
INSERT INTO Friends3 (ID, Friend_ID) VALUES 
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Insert data into Packages Table
INSERT INTO Packages3 (ID, Salary) VALUES 
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);


--query for task 11
SELECT s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages p1 ON f.Friend_ID = p1.ID
JOIN Packages p2 ON s.ID = p2.ID
WHERE p1.Salary > p2.Salary
ORDER BY p1.Salary;


--task 12-18:
CREATE TABLE JobFamilyCost (
    JobFamily VARCHAR(50),
    Country VARCHAR(20),
    Cost DECIMAL(18, 2)
);

CREATE TABLE BusinessUnit (
    BUName VARCHAR(50),
    Month DATE,
    Revenue DECIMAL(18, 2),
    Cost DECIMAL(18, 2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(18, 2),
    SubBand VARCHAR(50)
);

CREATE TABLE Headcount (
    SubBand VARCHAR(50),
    EmployeeCount INT
);

INSERT INTO JobFamilyCost (JobFamily, Country, Cost) VALUES
('Engineering', 'India', 200000),
('Engineering', 'International', 500000);

INSERT INTO BusinessUnit (BUName, Month, Revenue, Cost) VALUES
('BU1', '2023-01-01', 100000, 70000),
('BU1', '2023-02-01', 120000, 80000);

INSERT INTO Employees (EmployeeID, Name, Salary, SubBand) VALUES
(1, 'John Doe', 60000, 'A'),
(2, 'Jane Smith', 75000, 'B'),
(3, 'Alice Brown', 55000, 'A'),
(4, 'Mike Johnson', 50000, 'C'),
(5, 'Emma Davis', 80000, 'B');

INSERT INTO Headcount (SubBand, EmployeeCount) VALUES
('A', 2),
('B', 2),
('C', 1);


--query for task 12
SELECT 
    JobFamily,
    Country,
    (Cost * 100.0 / SUM(Cost) OVER()) AS Cost_Percentage
FROM 
    JobFamilyCost;


--query for task 13
SELECT 
    Month,
    (Cost / Revenue) AS Cost_Revenue_Ratio
FROM 
    BusinessUnit;

--query for task 14
SELECT 
    SubBand,
    EmployeeCount,
    (EmployeeCount * 100.0 / SUM(EmployeeCount) OVER()) AS Percentage_Headcount
FROM 
    Headcount;

--query for task 15
SELECT TOP 5 
    EmployeeID,
    Name,
    Salary
FROM 
    Employees
ORDER BY 
    Salary DESC;


--query for task 16
-- Assuming 'columnA' and 'columnB' are the columns to be swapped 
UPDATE SampleTable
SET 
    columnA = columnB,
    columnB = columnA;

--query for task 17
-- Creating a user
CREATE USER new_user FOR LOGIN new_login;

-- Granting DB_Owner permissions
ALTER ROLE db_owner ADD MEMBER new_user;

--query for task 18
SELECT 
    
    SUM(Salary * EmployeeCount) / SUM(EmployeeCount) AS Weighted_Avg_Cost
FROM 
    Employees E
JOIN 
    Headcount H ON E.SubBand = H.SubBand;


select * from employees;


--query for task 19
WITH ActualAverage AS (
    SELECT AVG(Salary) AS actual_avg
    FROM EMPLOYEES
),
MiscalculatedAverage AS (
    SELECT AVG(CAST(REPLACE(Salary, '0', '') AS DECIMAL)) AS miscalculated_avg
    FROM EMPLOYEES
)

SELECT CEIL(ActualAverage.actual_avg - MiscalculatedAverage.miscalculated_avg) AS error_amount
FROM ActualAverage, MiscalculatedAverage;


--task 20:

--query for task 20

INSERT INTO TargetTable (Column1, Column2, ...)  -- Specify columns
SELECT Column1, Column2, ...
FROM SourceTable;


CREATE TABLE EMPLOYEESS (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2)
);
INSERT INTO EMPLOYEESS (EmployeeID, Name, Salary) VALUES
(1, 'Alice', 5000.00),
(2, 'Bob', 6000.00),
(3, 'Charlie', 7000.00);

CREATE TABLE EMPLOYEES_COPY (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO EMPLOYEES_COPY (EmployeeID, Name, Salary)
SELECT EmployeeID, Name, Salary 
FROM EMPLOYEESS;


SELECT * FROM EMPLOYEESS;
SELECT * FROM EMPLOYEES_COPY;
