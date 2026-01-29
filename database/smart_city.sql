CREATE DATABASE smart_city;
USE smart_city;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role ENUM('citizen','admin') DEFAULT 'citizen'
);

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    department_id INT,
    area_id INT,
    title VARCHAR(200),
    description TEXT,
    urgency ENUM('Low','Medium','High'),
    status ENUM('Pending','In Progress','Resolved') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- VIEW: Area-wise complaints
CREATE VIEW area_complaints AS
SELECT areas.name AS area, COUNT(complaints.id) AS total
FROM complaints
JOIN areas ON complaints.area_id = areas.id
GROUP BY areas.name;

-- TRIGGER: Auto mark old complaints
DELIMITER //
CREATE TRIGGER auto_escalate
BEFORE UPDATE ON complaints
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(DAY, OLD.created_at, NOW()) > 7 AND OLD.status != 'Resolved' THEN
        SET NEW.status = 'In Progress';
    END IF;
END;
//
DELIMITER ;
