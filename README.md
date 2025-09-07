

## 💊 Pharmacy Inventory Management System – SQL Project

📌 **Project Overview:**
This project models a complete **pharmacy inventory and order management system** using **relational database design** in SQL. It captures key business processes such as product inventory, customer orders, supplier stock management, and order processing by pharmacists.

---

## 🔧 Key Components

### 🧱 **Entities & Attributes:**

1. **Customer**
   Stores customer details such as ID, name, age, city, email, and phone number. Includes a check constraint to ensure age is positive.

2. **Products**
   Holds information about medicines: name, price, expiry date, type (e.g., tablet or syrup), and an optional description. Includes validation to ensure price is non-negative.

3. **Supplier**
   Maintains data about suppliers, including contact and city.

4. **Inventory**
   Tracks which products are supplied by which suppliers, along with stock quantity and last restock date. Links products and suppliers using foreign keys.

5. **Pharmacist**
   Stores contact information of pharmacists responsible for processing customer orders.

6. **Orders**
   Represents orders placed by customers and handled by pharmacists. Includes automatic timestamping for the order date.

7. **Order Details** (Junction Table)
   Implements the **many-to-many relationship** between **orders** and **products**. Stores the quantity of each product ordered.

8. **Order Summary** (View)
   A **virtual table** that combines order information, customer details, product names, quantities, prices, and total amounts — making it easy to analyze sales data without complex joins.

---

## 🔗 Relationship Overview:

* **One-to-Many:**

  * A customer can place multiple orders
  * A pharmacist can handle multiple orders
  * A supplier can supply multiple products

* **Many-to-Many:**

  * An order can contain multiple products, and a product can appear in multiple orders
  * Implemented using the **Order_Details** junction table

* **Optional Attributes:**
  Fields like email, phone number, and product descriptions are optional to allow flexibility.

* **Constraints Used:**

  * Primary Keys for entity uniqueness
  * Foreign Keys for relational integrity
  * Check constraints for data validation (e.g., age > 0, price ≥ 0)
  * Default values for timestamps

---

## 🧠 What I Learned:

* Designing normalized databases with clear entity relationships
* Managing many-to-many relationships using junction tables
* Using views to simplify reporting and data access
* Enforcing data integrity with SQL constraints
* Writing readable, scalable SQL structures

---

📈 **This database design is ideal for small pharmacy systems**, and it can be extended to include billing, prescription tracking, and supplier restocking alerts.

Let me know what you think, or feel free to reach out if you're working on similar SQL/database projects!



