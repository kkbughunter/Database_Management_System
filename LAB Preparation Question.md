d# Lab Questions
# Question 1  set of questions based on a hypothetical "Customers" table:
```sql
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city_id INT,
    CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)  REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    CONSTRAINT fk_category  FOREIGN KEY (category_id)  REFERENCES Categories(category_id)
);

CREATE TABLE OrderItems (
    order_id INT,
    product_id INT,
    quantity INT,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_product  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE Cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);
```
1. Inserting data into the Customers table:
```sql
INSERT INTO Customers (customer_id, customer_name, city_id)
VALUES (1, 'John Doe', 1);
INSERT INTO Customers (customer_id, customer_name, city_id)
VALUES (2, 'Jane Smith', 2);
INSERT INTO Customers (customer_id, customer_name, city_id)
VALUES (3, 'Michael Johnson', 3);
```
2. Inserting data into the Orders table:
```sql
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES (1, '2023-06-01', 1);
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES (2, '2023-06-10', 2);
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES (3, '2023-06-15', 3);
```
3. Inserting data into the Products table:
```sql
INSERT INTO Products (product_id, product_name, category_id)
VALUES (1, 'Widget A', 1);
INSERT INTO Products (product_id, product_name, category_id)
VALUES (2, 'Widget B', 1);
INSERT INTO Products (product_id, product_name, category_id)
VALUES (3, 'Gadget X', 2);
```
4. Inserting data into the OrderItems table:
```sql
INSERT INTO OrderItems (order_id, product_id, quantity)
VALUES (1, 1, 5);
INSERT INTO OrderItems (order_id, product_id, quantity)
VALUES (1, 2, 3);
INSERT INTO OrderItems (order_id, product_id, quantity)
VALUES (2, 3, 2);
```
5. Inserting data into the Categories table:
```sql
INSERT INTO Categories (category_id, category_name)
VALUES (1, 'Widgets');
INSERT INTO Categories (category_id, category_name)
VALUES (2, 'Gadgets');
INSERT INTO Categories (category_id, category_name)
VALUES (3, 'Accessories');
```
6. Inserting data into the Cities table:
```sql
INSERT INTO Cities (city_id, city_name)
VALUES (1, 'New York');
INSERT INTO Cities (city_id, city_name)
VALUES (2, 'Los Angeles');
INSERT INTO Cities (city_id, city_name)
VALUES (3, 'Chicago');
```

Query Questions using JOIN:
1. Retrieve the order details (order ID, order date, customer name, city name) for all orders.
2. Get the product name and category name for each order item in the order with ID 123.
3. Retrieve the customer names along with their corresponding city names for customers who have placed orders.
4. Get the total quantity of each product sold along with its product name.
5. Retrieve the order IDs for all orders placed by customers from a specific city, let's say "New York."

Query Questions using Subquery:
1. Find the names of customers who have placed orders for products belonging to a specific category, let's say "Electronics."
2. Retrieve the order details (order ID, order date, customer name, city name) for orders that have the maximum quantity of a specific product, let's say product with ID 456.
3. Get the order IDs for orders where the total quantity of products ordered is greater than the average quantity of products ordered.
4. Retrieve the product names and categories for products that have been ordered by customers from a specific city, let's say "London."
5. Find the customer names who have placed at least two orders.

Query Questions using Triggers:
1. Create a trigger that automatically updates the order date to the current date whenever a new order is inserted.
2. Implement a trigger that checks the quantity of ordered items and raises an error if the quantity is zero or negative.

Query Questions using Procedures:
1. Create a procedure that accepts a customer ID as input and returns the total number of orders placed by that customer.
2. Write a procedure that takes an order ID as input and deletes the corresponding order along with its order items.

Question using ON DELETE CASCADE:
1. Explain how the ON DELETE CASCADE option works and provide an example scenario where it can be useful.

Query Questions using Views:
1. Create a view that displays the order details (order ID, order date, customer name, city name) for all orders.
2. Implement a view that shows the product names and categories for products that have been ordered by customers from a specific city, let's say "Paris."
3. Create a view that lists the total quantity of each product sold along with its product name.
4. Implement a view that shows the customer names along with their corresponding city names for customers who have placed orders.
5. Create a view that displays the order IDs for all orders placed by customers from a specific country, let's say "Germany."

# Question 2  set of questions based on a hypothetical "Students" table:

```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department_id INT,
    CONSTRAINT fk_department  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    department_id INT,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    grade INT,
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
```
1. Inserting data into the Students table:
```sql
INSERT INTO Students (student_id, student_name, department_id)
VALUES (1, 'John Doe', 1);
INSERT INTO Students (student_id, student_name, department_id)
VALUES (2, 'Jane Smith', 2);
INSERT INTO Students (student_id, student_name, department_id)
VALUES (3, 'Michael Johnson', 1);
```
2. Inserting data into the Courses table:
```sql
INSERT INTO Courses (course_id, course_name, department_id)
VALUES (1, 'Mathematics', 1);
INSERT INTO Courses (course_id, course_name, department_id)
VALUES (2, 'Physics', 2);
INSERT INTO Courses (course_id, course_name, department_id)
VALUES (3, 'Chemistry', 1);
```
3. Inserting data into the Enrollments table:
```sql
INSERT INTO Enrollments (student_id, course_id, grade)
VALUES (1, 1, 90);
INSERT INTO Enrollments (student_id, course_id, grade)
VALUES (1, 2, 85);
INSERT INTO Enrollments (student_id, course_id, grade)
VALUES (2, 3, 95);
```
4. Inserting data into the Departments table:
```sql
INSERT INTO Departments (department_id, department_name)
VALUES (1, 'Mathematics Department');
INSERT INTO Departments (department_id, department_name)
VALUES (2, 'Physics Department');
INSERT INTO Departments (department_id, department_name)
VALUES (3, 'Chemistry Department');
```

Query Questions using JOIN:
1. Retrieve the student details (student ID, student name, department name) for all students.
2. Get the course name and department name for each enrollment record.
3. Retrieve the student names along with their corresponding department names for students enrolled in a specific course, let's say "Mathematics."
4. Get the average grade for each student along with their student name.
5. Retrieve the course names for all courses offered by a specific department, let's say the department with ID 123.

Query Questions using Subquery:
1. Find the names of students who have enrolled in courses belonging to a specific department, let's say the department with ID 456.
2. Retrieve the student details (student ID, student name, department name) for students who have obtained the maximum grade in a specific course, let's say the course with ID 789.
3. Get the student IDs for students who have enrolled in courses where the average grade is higher than a specific value, let's say 80.
4. Retrieve the course names and departments for courses that have been enrolled in by students from a specific department, let's say the department with ID 789.
5. Find the student names who have enrolled in at least two courses.

Query Questions using Triggers:
1. Create a trigger that updates the average grade of a student whenever a new grade is inserted for that student.
2. Implement a trigger that checks the grade of an enrollment and raises an error if the grade is below the passing threshold.

Query Questions using Procedures:
1. Create a procedure that accepts a department ID as input and returns the total number of students enrolled in that department.
2. Write a procedure that takes a student ID as input and deletes the corresponding student along with their enrollment records.

Question using ON DELETE CASCADE:
1. Explain how the ON DELETE CASCADE option works and provide an example scenario where it can be useful.

Query Questions using Views:
1. Create a view that displays the student details (student ID, student name, department name) for all students.
2. Implement a view that shows the course names and departments for courses that have been enrolled in by students from a specific department, let's say the department with ID 456.
3. Create a view that lists the average grade for each student along with their student name.
4. Implement a view that shows the student names along with their corresponding department names for students who have enrolled in courses.
5. Create a view that displays the student IDs for all students enrolled in courses offered by a specific department, let's say the department with ID 789.

# Question 3  set of questions based on a hypothetical "Event Management" table:
```sql
CREATE TABLE Cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50)
);
CREATE TABLE Venues (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(50),
    city_id INT,
    CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);
CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50),
    event_date DATE,
    venue_id INT,
    CONSTRAINT fk_venue  FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);
CREATE TABLE Participants (
    participant_id INT PRIMARY KEY,
    participant_name VARCHAR(50),
    event_id INT,
    CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

INSERT INTO Cities (city_id, city_name)
VALUES (1, 'New York');
INSERT INTO Cities (city_id, city_name)
VALUES (2, 'Los Angeles');
INSERT INTO Cities (city_id, city_name)
VALUES (3, 'Chicago');

INSERT INTO Venues (venue_id, venue_name, city_id)
VALUES (1, 'Conference Center A', 1);
INSERT INTO Venues (venue_id, venue_name, city_id)
VALUES (2, 'Workshop Hall B', 2);
INSERT INTO Venues (venue_id, venue_name, city_id)
VALUES (3, 'Seminar Room C', 3);

INSERT INTO Events (event_id, event_name, event_date, venue_id)
VALUES (1, 'Conference A', '2023-Jul-15', 1);
INSERT INTO Events (event_id, event_name, event_date, venue_id)
VALUES (2, 'Workshop B', '2023-Aug-02', 2);
INSERT INTO Events (event_id, event_name, event_date, venue_id)
VALUES (3, 'Seminar C', '2023-Sep-10', 3);

INSERT INTO Participants (participant_id, participant_name, event_id)
VALUES (1, 'John Doe', 1);
INSERT INTO Participants (participant_id, participant_name, event_id)
VALUES (2, 'Jane Smith', 2);
INSERT INTO Participants (participant_id, participant_name, event_id)
VALUES (3, 'Michael Johnson', 1);
```


Query Questions using JOIN:
1. Retrieve the event details (event ID, event name, event date, venue name) for all events.
2. Get the participant names and their corresponding event names for each participant.
3. Retrieve the event names along with their corresponding venue names for events happening in a specific city, let's say "New York."
4. Get the total number of participants for each event along with their event names.
5. Retrieve the event IDs for all events happening at a specific venue, let's say the venue with ID 123.

Query Questions using Subquery:
1. Find the names of participants who have registered for events happening in a specific city, let's say "London."
2. Retrieve the event details (event ID, event name, event date, venue name) for events that have the maximum number of participants.
3. Get the event IDs for events where the total number of participants is greater than the average number of participants.
4. Retrieve the venue names and cities for venues hosting events registered by participants from a specific city, let's say "Paris."
5. Find the participant names who have registered for at least two events.

Query Questions using Triggers:
1. Create a trigger that automatically updates the event date to the current date whenever a new event is inserted.
2. Implement a trigger that checks the number of participants and raises an error if the event is already full.

Query Questions using Procedures:
1. Create a procedure that accepts an event ID as input and returns the total number of participants registered for that event.
2. Write a procedure that takes an event ID as input and deletes the corresponding event along with its participant records.

Question using ON DELETE CASCADE:
1. Explain how the ON DELETE CASCADE option works and provide an example scenario where it can be useful.

Query Questions using Views:
1. Create a view that displays the event details (event ID, event name, event date, venue name) for all events.
2. Implement a view that shows the venue names and cities for venues hosting events registered by participants from a specific city, let's say "Berlin."
3. Create a view that lists the total number of participants for each event along with their event names.
4. Implement a view that shows the participant names along with their corresponding event names for participants who have registered for events.
5. Create a view that displays the event IDs for all events happening in a specific country, let's say "Germany."
