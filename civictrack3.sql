CREATE DATABASE civictrack ;
USE civictrack;
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(100) NOT NULL
);

CREATE TABLE issues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    region VARCHAR(100) NOT NULL,
    upvotes INT DEFAULT 0,
    days INT DEFAULT 0,
    status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending',
    employee_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE SET NULL
);
CREATE TABLE issue_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    image LONGBLOB NOT NULL,
    caption VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE
);
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    commenter_name VARCHAR(100) NOT NULL,
    comment TEXT NOT NULL,
    commented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE
);
CREATE TABLE upvotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    user_identifier VARCHAR(100) NOT NULL,
    upvoted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE,
    UNIQUE(issue_id, user_identifier)
);
CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE issue_regions (
    issue_id INT NOT NULL,
    region_id INT NOT NULL,
    PRIMARY KEY (issue_id, region_id),
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE CASCADE
);
CREATE TABLE issue_status_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    old_status ENUM('Pending', 'In Progress', 'Resolved') NOT NULL,
    new_status ENUM('Pending', 'In Progress', 'Resolved') NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE
);
CREATE TABLE employees_regions (
    employee_id INT NOT NULL,
    region_id INT NOT NULL,
    PRIMARY KEY (employee_id, region_id),
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE CASCADE
);
CREATE TABLE issue_assignment_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    old_employee_id INT,
    new_employee_id INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES issues(id) ON DELETE CASCADE,
    FOREIGN KEY (old_employee_id) REFERENCES employees(id) ON DELETE SET NULL,
    FOREIGN KEY (new_employee_id) REFERENCES employees(id) ON DELETE SET NULL
);
-- SQL script to create the citizen_complaints table
-- This table stores complaints submitted by citizens, including their location and an optional photo.

