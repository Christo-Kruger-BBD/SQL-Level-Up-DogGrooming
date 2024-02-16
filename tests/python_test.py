import pytest
import pyodbc
import os

# Database connection parameters
DB_SERVER = "127.0.0.1"
DB_NAME = "tempdb"
DB_USER = "sa"
DB_PASSWORD = r"yourStrong(%)Password"

# Function to execute SQL script file
def execute_sql_script(conn, script_path):
    with open(script_path, 'r') as sql_file:
        sql_script = sql_file.read()
        cursor = conn.cursor()
        cursor.execute(sql_script)
        cursor.commit()
        cursor.close()

conn = None
@pytest.fixture(scope="session", autouse=True)
def setup_database():
    global conn
    # Establish a connection to the database
    conn = pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={DB_SERVER};"
        f"DATABASE={DB_NAME};"
        f"UID={DB_USER};"
        f"PWD={DB_PASSWORD};"
    )
    
    current_dir = os.path.dirname(os.path.abspath(__file__))
    migration_dir = os.path.join(current_dir, '../database/migrations')
    migration_files = sorted(file for file in os.listdir(migration_dir) if file.endswith('.sql'))
    
    for migration_file in migration_files:
        migration_file_path = os.path.join(migration_dir, migration_file)
        execute_sql_script(conn, migration_file_path)

    yield conn

    # Close the connection after all tests are done
    conn.close()

def test_number_of_tables(db_connection):

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V1__CreateTables.sql')
    execute_sql_script(conn, sql_script_path)

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

def test_data_in_all_tables(db_connection):
    # Cursor to execute SQL queries
    cursor = db_connection.cursor()

    tables = [
        'Customer_Data',
        'Employee_Data',
        'Pets',
        'Appointment',
        'Payments',
        'Types_of_Service',
        'Appointment_Services'
    ]

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V2__PopulateTables.sql')
    execute_sql_script(conn, sql_script_path)

    for table in tables:
        cursor = db_connection.cursor()

    # Execute query to count the number of tables
        cursor.execute("SELECT COUNT(*) FROM " +  table)

        # Get the count of tables
        num_tables = cursor.fetchone()[0]

        # Check if there are 7 tables
        assert num_tables > 0, f"Expected data in table {table}, but found none"

        # Close the cursor
        cursor.close()

def test_table_views(db_connection):
    # Cursor to execute SQL queries

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V3__TableViews.sql')
    execute_sql_script(conn, sql_script_path)

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V4__TableViews2.sql')
    execute_sql_script(conn, sql_script_path)

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V5__TableViews3.sql')
    execute_sql_script(conn, sql_script_path)

    views = [
        'appointment_details_view',
        'upcoming_appointments_view',
        'employee_schedule_view'
    ]

    for view in views:
        cursor = db_connection.cursor()
    # Execute query to count the number of tables
        cursor.execute("SELECT * FROM " +  view)

        # Get the count of tables
        num_tables = cursor.fetchone()[0]

        # Check if there are 7 tables
        assert num_tables > 0, f"Expected data in view {view}, but found none"

        cursor.close()

    print('VIEW TEST PASSED')

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V6__TableFunctions.sql')
    execute_sql_script(conn, sql_script_path)

    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_script_path = os.path.join(current_dir, '../database/migrations/V7__TableFunctions2.sql')
    execute_sql_script(conn, sql_script_path)

    funcs = {
        50: ['DECLARE @TotalPayment DECIMAL(10, 2); SET @TotalPayment = dbo.calculate_total_payment(1); SELECT @TotalPayment AS TotalPayment;'],
        'Michael Johnson': ['SELECT * FROM dbo.get_appointments_for_customer_function(1);']
    }

    for func in funcs:
        cursor = db_connection.cursor()

    # Execute query to count the number of tables
        for item in funcs[func]:
            cursor.execute(item)

        # Get the count of tables
        num_data = cursor.fetchone()[-1]
        print(num_data)
        # Check if there are 7 tables
        assert num_data == func, f"Expected data in func to be {func} but got {num_data}"
        cursor.close()

    print("FUNCS TEST PASSED")

    # Close the cursor
    


# @pytest.mark.order(5)
# def test_table_funcs(db_connection):
#     # Cursor to execute SQL queries
#     cursor = db_connection.cursor()

#     current_dir = os.path.dirname(os.path.abspath(__file__))
#     sql_script_path = os.path.join(current_dir, '../database/migrations/V6__TableFunctions.sql')
#     execute_sql_script(conn, sql_script_path)

#     current_dir = os.path.dirname(os.path.abspath(__file__))
#     sql_script_path = os.path.join(current_dir, '../database/migrations/V7__TableFunctions2.sql')
#     execute_sql_script(conn, sql_script_path)
    

#     funcs = [
#         'calculate_total_payment',
#         'get_appointments_for_customer_function'
#     ]

#     for func in funcs:

#     # Execute query to count the number of tables
#         cursor.execute("SELECT * FROM " +  func)

#         # Get the count of tables
#         num_data = cursor.fetchone()[0]

#         # Check if there are 7 tables
#         assert num_data > 0, f"Expected data in view {func}, but found none"

#     # Close the cursor
#     cursor.close()


if __name__ == "__main__":
    pytest.main()
