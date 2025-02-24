import mysql.connector

# Establish connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="LittleLemon"
)

cursor = conn.cursor()

# Fetch all orders
cursor.execute("SELECT * FROM Orders")
orders = cursor.fetchall()

# Display results
for order in orders:
    print(order)

# Close connection
cursor.close()
conn.close()
