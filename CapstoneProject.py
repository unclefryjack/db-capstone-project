import mysql.connector as connector
connection = connector.connect(user = "root", password = "@szaismyGod9", db = "LittleLemonDB")

cursor = connection.cursor()
show_tables_query = "SHOW tables;" 
cursor.execute(show_tables_query)

results = cursor.fetchall()

print("Tables in the database:")
for table in results:
    print(table[0])

totalcostquery = """

SELECT CONCAT (c.Customer_FN, ' ', c.Customer_LN) AS Full_Name, c.PhoneNumber, o.TotalCost
FROM `customer details` c
JOIN Orders o ON c.CustomerID = FK_CustomerID
WHERE o.TotalCost >60;
"""
cursor.execute(totalcostquery)
results2 = cursor.fetchall()

print("Customers with orders greater than $60:")
for row in results2:
    print(f"Name: {row[0]}, Contact: {row[1]}, Total Cost: ${row[2]}")
