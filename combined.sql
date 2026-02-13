-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:\Users\Lenovo\Downloads\Books.csv'
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'C:\Users\Lenovo\Downloads\Customers.csv'
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:\Users\Lenovo\Downloads\Orders.csv' 
CSV HEADER;


-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';

--2)Find books published after year 1950:
SELECT * FROM Books
WHERE published_year>1950;

--3)List all Customers from the Canada:
SELECT * FROM Customers
WHERE country='canada';

--4)show orders placed in november 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5)Retrive the total stock of books available:
  SELECT SUM(stock) AS total_stock
  FROM Books;

--6)find the details of the most expensive books:
SELECT * FROM Books 
ORDER BY price DESC
LIMIT 1;

--7)show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE quantity>1;

--8)retrive all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE total_amount>20;

--9)list all genres available in the books table:
SELECT DISTINCT genre FROM Books;

--10)find the book with lowest stock:
SELECT * FROM Books 
ORDER BY stock;

--11)calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM Orders

SELECT b.Genre, SUM(o.Quantity) AS total_book_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.genre;

 
-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS average_price
FROM Books
WHERE genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT customer_id,COUNT(order_id) AS ORDER_COUNT
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >=2;


-- 4) Find the most frequently ordered book:
SELECT book_id,COUNT(order_id) AS ORDER_COUNT
FROM Orders
GROUP BY book_id
ORDER BY ORDER_COUNT DESC LIMIT 1;


 -- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC 
LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author,SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN Books b ON b.book_id=o.book_id
GROUP BY b.author;

 
-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city,total_amount
FROM Customers c
JOIN Orders o ON c.customer_id=o.customer_id
WHERE total_amount >=30;

 
-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM  Orders o
JOIN  Customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC LIMIT 1;


  





 