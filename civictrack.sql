-- SQL script to create the citizen_complaints table
-- This table stores complaints submitted by citizens, including their location and an optional photo.
CREATE DATABASE CivicTrackDB;
USE CivicTrackDB;
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    phone_number CHAR(10) NOT NULL UNIQUE,
    otp_code CHAR(6),
    otp_expires_at TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Complaints (
    complaint_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    problem_description TEXT NOT NULL,
    address_landmark TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'Active', -- values: Active, Resolved
    submitted_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    resolved_at TIMESTAMP
);

CREATE TABLE ComplaintImages (
    image_id SERIAL PRIMARY KEY,
    complaint_id INT NOT NULL,
    image LONGBLOB NOT NULL,
    caption VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Locations (
    location_id SERIAL PRIMARY KEY,
    complaint_id INT NOT NULL,
    location VARCHAR(255), -- stores "latitude,longitude"
    address_landmark TEXT
);

