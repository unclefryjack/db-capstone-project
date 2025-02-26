USE LittleLemonDB;

INSERT INTO menu VALUES
(1, "Shrimp Ceviche", "Starters", 8.00),
(2, "Conch Ceviche", "Starters", 7.50),
(3, "Pork Salpicon", "Starters", 10),
(4, "Chicken Salipcon", "Starters", 9),
(5, "Stuffed Jack", "Starters", 6),
(6, "Rice & Beans", "Main Course", 10),
(7, "Black Dinner", "Main Course", 12),
(8, "Boil Up", "Main Course", 11),
(9, "Escabeche", "Main Course", 8),
(10, "Hudut", "Main Course", 11.50),
(11, "Bread Pudding", "Dessert", 5),
(12, "Coconut Tart", "Dessert", 4),
(13, "Powder Buns", "Dessert", 4.50),
(14, "Potato Pound", "Dessert", 5),
(15, "Tropical Fruit Bowl", "Dessert", 8);
INSERT INTO `customer details` VALUES
(1, "Javan", "Jones", "229-678-4988", "javanjones@hotmail.com"),
(2, "Sole", "Acosta", "229-678-4987", "solemacosta@hotmail.com"),
(3, "Chrystel", "Young", "229-628-4988", "youngchrystel@hotmail.com"),
(4, "Mikaylin", "Hyde", "228-678-4988", "kyhyde@hotmail.com"),
(5, "Gwenmaria", "Bradshaw", "229-678-4988", "gwenmaria@hotmail.com"),
(6, "Aijhelon", "Ysaguirre", "229-678-4918", "ajiysa@hotmail.com"),
(7, "Lukas", "Simpson", "219-678-4988", "lukesimpson@hotmail.com"),
(8, "Adamaris", "Guerrero", "229-638-4948", "mariss@hotmail.com"),
(9, "Yves", "St. Barrow", "229-698-4918", "yvesbar@hotmail.com"),
(10, "Joely", "Martinez", "229-671-4911", "jamart@hotmail.com");

INSERT INTO Bookings VALUES 
(1, "2025-02-01",1,1),
(2, "2025-02-02", 2,3),
(3, "2025-02-03",3,5),
(4, "2025-02-04",4,7),
(5, "2025-02-05",5,9);

INSERT INTO `staff information` VALUES 
(1, "Elizabeth", "BloodHeart", 35000.00),
(2, "Lamar", "Rhodes", 32000.00),
(3, "Kenneth", "Bacon", 34200.00),
(4, "Synthia", "Coleman", 37000.00),
(5, "Jade", "Majorret", 33600.00),
(6, "Tyler-Kennedy", "Smith-Lewis", 30900.00);

INSERT INTO Orders VALUES 
(1,"2025-02-02 13:45:15", 2, 8.00, 1, 12, 1),
(2,"2025-02-04 14:26:11", 1, 10.00, 2, 6, 3),
(3,"2025-02-06 21:30:00", 3, 18.00, 3, 5, 5),
(4,"2025-02-08 17:15:12", 2, 16.00, 4, 1, 7),
(5,"2025-02-09 19:57:25", 1, 11.50, 5, 10, 9);

INSERT INTO `Order Delivery Status` VALUES
(1, "2025-02-02 14:00:00", "Delivered", 1),
(2, "2025-02-04 15:00:00", "Delivered", 2),
(3, "2025-02-06 22:00:00", "On The Way", 3),
(4, "2025-02-08 18:00:00", "Delivered", 4),
(5, "2025-02-09 20:00:00", "On The Way", 5);






SELECT * FROM OrdersView;

SELECT c.CustomerID, concat(c.Customer_FN, " ", c.Customer_LN) AS FullName, o.OrderID,
o.TotalCost, m.ItemName, m.ItemType
FROM `customer details` c
INNER JOIN
Orders o ON c.CustomerID = o.FK_CustomerID
INNER JOIN
Menu m on m.MenuID = o.MenuID
WHERE o.TotalCost <20
ORDER BY o.TotalCost ASC;

SELECT ItemType
FROM Menu
WHERE MenuID = ANY (SELECT MENUID FROM ORDERS WHERE Quantity <2);

#CREATE PROCEDURE GetMaxQuantity()
#SELECT max(Quantity) FROM Orders

CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM
"SELECT OrderID, Quantity, TotalCost AS Cost
FROM Orders WHERE FK_CustomerID = ?";

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

#DELIMITER //

CREATE PROCEDURE CancelOrder (IN Order_ID INT)
BEGIN
DELETE FROM ORDERS WHERE OrderID = Order_ID;
SELECT CONCAT("OrderID", Order_ID, " has been successfully cancelled!") AS RESULT;
END//
DELIMITER ;

call CancelOrder(5);