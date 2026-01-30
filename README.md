# 🏙️ Smart City Complaint Analyzer

A **full-stack web application** that enables citizens to register civic complaints and helps city authorities analyze, track, and manage issues efficiently using **SQL-driven insights**.

This project focuses on **real-world problem solving**, backend logic, and database analytics rather than simple CRUD operations.

---

## 🚀 Features

### 👤 Citizen Module
- User registration & login
- Submit complaints with title, description, area, department, and urgency
- Track complaint status

### 🏛️ Admin Module
- View all complaints in a dashboard
- Monitor complaint status (Pending / In Progress / Resolved)
- Analyze area-wise complaint trends
- Identify frequently reported issues

### 🧠 Database Intelligence
- Area-wise complaint aggregation (SQL VIEW)
- Structured relational database design
- Ready for SLA & escalation extensions

---

## 🛠️ Tech Stack

**Frontend**
- HTML5
- CSS3
- JavaScript (Fetch API)

**Backend**
- PHP (Core PHP, no framework)

**Database**
- MySQL
- phpMyAdmin

**Tools**
- XAMPP (Apache + MySQL)
- Git & GitHub

---

## 📁 Project Structure

```
smart-city-complaint-analyzer/
├── frontend/
│ ├── index.html # Login page
│ ├── complaint.html # Complaint submission
│ ├── admin.html # Admin dashboard
│ ├── style.css # Styling
│ └── app.js # Frontend logic
│
├── backend/
│ ├── db.php
│ ├── register.php
│ ├── login.php
│ ├── submit_complaint.php
│ └── get_complaints.php
│
├── database/
│ └── smart_city.sql # Database schema
│
└── README.md
```

---

## ⚙️ How to Run Locally

### 1️⃣ Prerequisites
- Install **XAMPP**
- Start **Apache** and **MySQL**

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/soham-patil-tech/smart-city-complaint-analyzer.git
```
### 3️⃣ Move Project
```
C:\xampp\htdocs\
```
### 4️⃣ Import Database
```
Open http://localhost/phpmyadmin
Create database: smart_city
Import database/smart_city.sql
```
### 5️⃣ Add Test User 
```
INSERT INTO users (name, email, password, role)
VALUES ('Test User', 'test@gmail.com', '1234', 'citizen');
```
### 6️⃣ Run the App
```
Login:
http://localhost/smart-city-complaint-analyzer/frontend/index.html
Submit Complaint
View Admin Dashboard
```
### 🧪 Sample SQL Analytics
```
SELECT areas.name AS area, COUNT(complaints.id) AS total_complaints
FROM complaints
JOIN areas ON complaints.area_id = areas.id
GROUP BY areas.name;
```
Author: Soham Patil

