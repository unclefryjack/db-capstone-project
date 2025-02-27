use LittleLemonDB;

DELIMITER //
CREATE PROCEDURE CheckBooking(IN Bookingdate DATE,table_number INT)
BEGIN
DECLARE table_status varchar (50);
SELECT CASE
WHEN COUNT(*) > 0 THEN "Table is already booked!"
ELSE "Table is Available"
END INTO table_status
FROM Bookings
WHERE Date = Bookingdate AND TableNumber = table_number;

SELECT table_status AS Status ;

END //

DELIMITER ;

Call CheckBooking ("2025-02-08", 3);

Use LittleLemonDB;

DELIMITER //
CREATE PROCEDURE AddValidBooking (IN bdate DATE, IN tnumber INT)
BEGIN
DECLARE table_count INT;

START TRANSACTION;
SELECT COUNT(*) INTO table_count
FROM Bookings
WHERE Date = bdate AND TableNumber = tnumber;

IF table_count >0 THEN 
ROLLBACK;
SELECT CONCAT ('Booking Failed: Table ', tnumber, ' is already booked on ', bdate) AS Status;
ELSE
INSERT INTO Bookings (BookingID, Date, TableNumber, FK2_CustomerID)
VALUES (bid, bdate, tnumber, cus_id);

COMMIT;
SELECT CONCAT ('Booking Successful for Table ', tnumber, ' on ', bdate) AS STATUS;
END IF;
END //

DELIMITER ;
CALL AddValidBooking ('2025-02-01', 1);

DELIMITER //

CREATE PROCEDURE AddBooking (IN bID INT, IN cID INT, IN bdate DATE, IN tnumber INT)

BEGIN 

INSERT INTO Bookings (BookingID, Date, TableNumber, FK2_CustomerID) VALUES
(bID, bdate, tnumber, cID);

SELECT CONCAT ('Booking added successfully with with Booking ID ', bID) AS STATUS;
END //

DELIMITER ;

CALL AddBooking (6, 4, '2025-02-27', 5);

DELIMITER //

CREATE PROCEDURE UpdateBooking (IN bID INT, IN new_bdate DATE)

BEGIN 

UPDATE Bookings
SET Date = new_bdate
WHERE BookingID = bID;

SELECT CONCAT ('Booking ID ', bID, ' has been updated to ', new_bdate) AS Status;
END //

DELIMITER ;

CALL UpdateBooking (1, '2025-02-03');

DELIMITER //

CREATE PROCEDURE CancelBooking (IN bID INT)

BEGIN

DELETE FROM Bookings
WHERE BookingID = bID;

SELECT CONCAT ('Booking ID ', bID, ' has been cancelled successfully!') AS Status;


END //

DELIMITER ;
CALL CancelBooking (6);
