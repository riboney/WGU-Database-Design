CREATE TABLE coffee_shop (
  shop_id INT AUTO_INCREMENT PRIMARY KEY,
  shop_name VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2)
);

CREATE TABLE supplier (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  company_name VARCHAR(50),
  country VARCHAR(30),
  sales_contact_name VARCHAR(60),
  email VARCHAR(50)
);

CREATE TABLE coffee (
  coffee_id INT AUTO_INCREMENT PRIMARY KEY,
  shop_id INT,
  supplier_id INT,
  coffee_name VARCHAR(30),
  price_per_pound DECIMAL(5,2),
  FOREIGN KEY (shop_id)
    REFERENCES coffee_shop (shop_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY (supplier_id)
    REFERENCES supplier (supplier_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE employee (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  hire_date DATE,
  job_title VARCHAR(30) DEFAULT 'Employee',
  shop_id INT,
  FOREIGN KEY (shop_id)
    REFERENCES coffee_shop (shop_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

INSERT INTO coffee_shop 
  (shop_name, city, state)
VALUES 
  ('Krusty Krabs', 'Bikini Bottom', 'HI'),
  ('Central Perk', 'Manhattan', 'NY'),
  ('The Three Broomsticks', 'Hogsmeade', 'WA');

INSERT INTO supplier
  (company_name, country, sales_contact_name, email)
VALUES
  ('Westrock Coffee Company', 'USA', 'Jason Munez', 'jasonm@yahoo.com'),
  ('King Coffee Supplier', 'Brazil', 'Bob Saget', 'bobs@yahoo.com'),
  ('Zap Coffee Inc', 'Colombia', 'Bill Burr', 'billb@yahoo.com');

INSERT INTO coffee
  (shop_id, supplier_id, coffee_name, price_per_pound)
VALUES
  (
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'Krusty Krabs'
    ),
    (
      SELECT supplier_id
      FROM supplier
      WHERE company_name = 'King Coffee Supplier'
    ),
    'Brazilian Santos',
    00044.45
  ),
  (
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'Central Perk'
    ),
    (
      SELECT supplier_id
      FROM supplier
      WHERE company_name = 'Zap Coffee Inc'
    ),
    'Colombian Supremo',
    00059.10
  ),
  (
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'The Three Broomsticks'
    ),
    (
      SELECT supplier_id
      FROM supplier
      WHERE company_name = 'Westrock Coffee Company'
    ),
    'Organic Mexican',
    00038.70
  );

INSERT INTO employee
  (first_name, last_name, hire_date, job_title, shop_id)
VALUES
  (
    'Spongebob', 'Squarepants', '21/12/01', 'Coffee Barista', 
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'Krusty Krabs'
    )
  ),
  (
    'Rachel', 'Green', '07/05/22', 'Manager', 
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'Central Perk'
    )
  ),
  (
    'Ronald', 'Weasely', '11/03/14', 'Coffee Barista', 
    (
      SELECT shop_id
      FROM coffee_shop
      WHERE shop_name = 'The Three Broomsticks'
    )
  );

-- CREATE VIEW employee_view
-- AS
-- SELECT CONCAT(first_name, " ", last_name) AS employee_full_name
-- FROM employee;

CREATE VIEW employee_view AS
SELECT 
  employee_id, 
  CONCAT(first_name, " ", last_name) AS employee_full_name, 
  hire_date, 
  job_title, 
  shop_id
FROM employee e;

SELECT *
FROM employee_view;

CREATE INDEX coffee_name 
ON coffee(coffee_name);

SHOW INDEXES 
FROM coffee;

SELECT *
FROM employee
WHERE hire_date > '10-01-01';

SELECT *
FROM coffee c
  INNER JOIN supplier s
    ON c.supplier_id = s.supplier_id
  INNER JOIN coffee_shop cs
    ON c.shop_id = cs.shop_id;