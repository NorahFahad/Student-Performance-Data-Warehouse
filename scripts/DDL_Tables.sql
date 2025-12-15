USE DataWarehouse;
GO


-- DIMENSION TABLES
CREATE TABLE Dim_Student (
    student_key INT PRIMARY KEY IDENTITY(1,1),
    student_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    gender  VARCHAR(10),
    date_of_birth DATE,
    age INT,
    enrollment_date DATE,
    status VARCHAR(20),
    major VARCHAR(100),
    gpa DECIMAL(3,2)
);

CREATE TABLE Dim_Course (
    course_key INT PRIMARY KEY IDENTITY(1,1),
    course_id VARCHAR(20) UNIQUE NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    credits INT,
    instructor_name VARCHAR(100),
    semester VARCHAR(20),
    academic_year INT
);

CREATE TABLE Dim_Date (
    date_key INT PRIMARY KEY,
    full_date DATE UNIQUE NOT NULL,
    day_name VARCHAR(10),
    month_name VARCHAR(10),
    month_num INT,
    quarter INT,
    year INT,
    is_weekend BIT,
    semester VARCHAR(20)
);

CREATE TABLE Dim_Assessment (
    assessment_key INT PRIMARY KEY IDENTITY(1,1),
    assessment_type VARCHAR(50) NOT NULL,
    weight_percentage DECIMAL(5,2)
);


-- FACT TABLES
CREATE TABLE Fact_Performance (
    performance_id BIGINT PRIMARY KEY IDENTITY(1,1),
    student_key INT NOT NULL,
    course_key INT NOT NULL,
    date_key INT NOT NULL,
    assessment_key INT NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    max_score DECIMAL(5,2) NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    grade_letter VARCHAR(2),
    FOREIGN KEY (student_key) REFERENCES Dim_Student(student_key),
    FOREIGN KEY (course_key) REFERENCES Dim_Course(course_key),
    FOREIGN KEY (date_key) REFERENCES Dim_Date(date_key),
    FOREIGN KEY (assessment_key) REFERENCES Dim_Assessment(assessment_key)
);


CREATE TABLE Fact_Attendance (
    attendance_id BIGINT PRIMARY KEY IDENTITY(1,1),
    student_key INT NOT NULL,
    course_key INT NOT NULL,
    date_key INT NOT NULL,
    is_present BIT NOT NULL,
    is_late BIT NOT NULL,
    attendance_status VARCHAR(20),
    FOREIGN KEY (student_key) REFERENCES Dim_Student(student_key),
    FOREIGN KEY (course_key) REFERENCES Dim_Course(course_key),
    FOREIGN KEY (date_key) REFERENCES Dim_Date(date_key)
);


-- Indexes
CREATE INDEX idx_perf_student ON Fact_Performance(student_key);
CREATE INDEX idx_perf_course ON Fact_Performance(course_key);
CREATE INDEX idx_attend_student ON Fact_Attendance(student_key);
CREATE INDEX idx_attend_course ON Fact_Attendance(course_key);



ALTER TABLE Dim_Student
ADD college VARCHAR(100),
    department VARCHAR(100);

CREATE INDEX idx_student_college ON Dim_Student(college);
CREATE INDEX idx_student_department ON Dim_Student(department);
