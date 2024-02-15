import pytest
import pyodbc

# Database connection parameters
DB_SERVER = "localhost"
DB_NAME = "sql1"
DB_USER = "admin"
DB_PASSWORD = "1234"

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

def test_db_connection(db_connection):
    # Test the database connection
    assert db_connection is not None

def test_fetch_data_from_table(db_connection):
    # Test fetching data from a table in the database
    cursor = db_connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM your_table_name")
    row_count = cursor.fetchone()[0]
    assert row_count > 0

    # Additional assertions or tests can be added here

    cursor.close()

if __name__ == "__main__":
    pytest.main()
