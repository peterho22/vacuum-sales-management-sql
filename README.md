# Vacuum Company Manufacturing & Sales Database

## Overview
This project models a database for a vacuum manufacturing company. It tracks:
- **Vacuum models** and their specifications
- **Individual vacuum units** and manufacturing dates
- **Designers** responsible for vacuum models
- **Technicians** and **inspections**
- **Customers, orders, and customer service representatives**

The database supports querying for common business insights, such as:
- Most inspected technicians
- Vacuums that failed inspections
- Most popular vacuum models and associated sales representatives

---

## Features
- **Relational schema** with multiple foreign keys
- **Many-to-many relationships** (Vacuum ↔ Designer)
- **Supervisor hierarchy** for technicians
- **Sample data** for 10+ entries per table
- **Pre-written queries** for reporting

---

## How to Use
1. Open SQL Server Management Studio (SSMS) or similar SQL client.
2. Run the `vacuum-sales-management.sql` script to:
   - Drop existing tables (if any)
   - Create all tables
   - Insert sample data
   - Execute example queries

---

## Database Schema
- `Model`: Stores vacuum model details.
- `Vacuum`: Individual vacuum units tied to models.
- `Designer`: Employees responsible for design.
- `Vacuum_Designer`: Linking table for many-to-many relationships.
- `Technician`: Technicians with supervisor hierarchy.
- `Inspection`: QA inspection records for vacuums.
- `CustomerServiceRep`: Handles orders and customer interactions.
- `Customer`: End customers placing orders.
- `Order`: Links customer, vacuum, and CSR for purchases.

---

## Example Queries
- **List vacuum models and prices**
- **Count vacuums manufactured after 2010**
- **Identify technician with most inspections**
- **List failed inspections with details**
- **Determine most sold vacuum model and CSR(s)**
- **Display supervisor-to-technician mapping**

---

## Author
Peter Ho – (https://github.com/peterho22)
