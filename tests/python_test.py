import pytest
import pyodbc
import os

# Database connection parameters
DB_SERVER = "127.0.0.1"
DB_NAME = "tempdb"
DB_USER = "sa"
DB_PASSWORD = r"yourStrong(%)Password"

@pytest.fixture(scope="module")
def db_connection():
    # Establish a connection to the database
    conn = pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={DB_SERVER};"
        f"DATABASE={DB_NAME};"
        f"UID={DB_USER};"
        f"PWD={DB_PASSWORD};"
    )
    yield conn
    # Close the connection after all tests are done
    conn.close()

@pytest.fixture(scope="module", autouse=True)
def populate_database(db_connection):
    # Get the directory of the current file
    current_dir = os.path.dirname(os.path.abspath(__file__))
    # Path to the SQL file to populate the database
    sql_file_path = os.path.join(current_dir, "../database/migrations/V1__CreateTables.sql")
    
    # Open and read the SQL file
    with open(sql_file_path, "r") as sql_file:
        sql_script = sql_file.read()
    
    # Cursor to execute SQL queries
    cursor = db_connection.cursor()
    # Execute the SQL script to populate the database
    cursor.execute(sql_script)
    # Commit the changes
    db_connection.commit()
    # Close the cursor
    cursor.close()

def test_database_connection(db_connection):
    # Check if the connection is alive
    assert db_connection is not None, "Database connection is not established"

def test_number_of_tables(db_connection):
    # Cursor to execute SQL queries
    cursor = db_connection.cursor()

    # Execute query to count the number of tables
    cursor.execute("SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'")

    # Get the count of tables
    num_tables = cursor.fetchone()[0]

    # Check if there are 7 tables
    assert num_tables == 7, f"Expected 7 tables, but found {num_tables} tables"

    # Close the cursor
    cursor.close()

if __name__ == "__main__":
    pytest.main()