-- SQL script to create the citizen_complaints table
-- This table stores complaints submitted by citizens, including their location and an optional photo.
CREATE TABLE citizen_complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_name VARCHAR(50) NOT NULL,
    phone_number CHAR(10) NOT NULL,
    complaint_description TEXT NOT NULL,
    latitude DECIMAL(10,8) NOT NULL,   -- e.g. 22.719568
    longitude DECIMAL(11,8) NOT NULL,  -- e.g. 75.857727
    photo LONGBLOB,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



