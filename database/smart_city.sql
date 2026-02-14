/* ==============================
   SMART CITY COMPLAINT SYSTEM
   COMPLETE DATABASE SCRIPT
   ============================== */

CREATE DATABASE smart_city;
USE smart_city;

/* ---------- USERS TABLE ---------- */
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('citizen','admin','officer') DEFAULT 'citizen',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* ---------- DEPARTMENTS TABLE ---------- */
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

/* ---------- AREAS TABLE ---------- */
CREATE TABLE areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

/* ---------- COMPLAINTS TABLE ---------- */
CREATE TABLE complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    department_id INT NOT NULL,
    area_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    urgency ENUM('Low','Medium','High') DEFAULT 'Low',
    status ENUM('Pending','In Progress','Resolved','Closed') DEFAULT 'Pending',
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (area_id) REFERENCES areas(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id)
);

/* ---------- INDEXES FOR PERFORMANCE ---------- */
CREATE INDEX idx_complaint_status ON complaints(status);
CREATE INDEX idx_complaint_area ON complaints(area_id);
CREATE INDEX idx_complaint_department ON complaints(department_id);

/* ---------- VIEW: AREA & STATUS WISE REPORT ---------- */
CREATE VIEW area_complaint_report AS
SELECT 
    a.name AS area,
    c.status,
    COUNT(c.id) AS total_complaints
FROM complaints c
JOIN areas a ON c.area_id = a.id
GROUP BY a.name, c.status;

/* ---------- COMPLAINT HISTORY TABLE ---------- */
CREATE TABLE complaint_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT,
    old_status ENUM('Pending','In Progress','Resolved','Closed'),
    new_status ENUM('Pending','In Progress','Resolved','Closed'),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

/* ---------- TRIGGER: AUTO ESCALATE OLD COMPLAINTS ---------- */
DELIMITER //
CREATE TRIGGER auto_escalate_complaints
BEFORE UPDATE ON complaints
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(DAY, OLD.created_at, NOW()) > 7
       AND OLD.status = 'Pending' THEN
        SET NEW.status = 'In Progress';
    END IF;
END;
//
DELIMITER ;

/* ---------- TRIGGER: AUTO RESOLVE LOW URGENCY ---------- */
DELIMITER //
CREATE TRIGGER auto_resolve_low_urgency
BEFORE UPDATE ON complaints
FOR EACH ROW
BEGIN
    IF OLD.urgency = 'Low'
       AND TIMESTAMPDIFF(DAY, OLD.created_at, NOW()) > 15 THEN
        SET NEW.status = 'Resolved';
    END IF;
END;
//
DELIMITER ;

/* ---------- TRIGGER: LOG STATUS CHANGES ---------- */
DELIMITER //
CREATE TRIGGER log_complaint_status_change
AFTER UPDATE ON complaints
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO complaint_history
        (complaint_id, old_status, new_status)
        VALUES (OLD.id, OLD.status, NEW.status);
    END IF;
END;
//
DELIMITER ;
