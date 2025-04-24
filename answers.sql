--Question 1
SELECT
  pd.OrderID,
  pd.CustomerName,
  jt.product AS Product
FROM ProductDetail AS pd
JOIN JSON_TABLE(
  CONCAT(
    '["',
    REPLACE(pd.Products, ', ', '","'),
    '"]'
  ),
  '$[*]' COLUMNS (
    product VARCHAR(255) PATH '$'
  )
) AS jt;

---

--Question 2

CREATE TABLE Orders (
  OrderID INT        NOT NULL,
  CustomerName VARCHAR(100) NOT NULL,
  PRIMARY KEY (OrderID)
);


CREATE TABLE OrderItems (
  OrderID   INT        NOT NULL,
  Product   VARCHAR(255) NOT NULL,
  Quantity  INT        NOT NULL,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails;


INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails;
---