const mysql = require('mysql');

// Function to create a MySQL connection pool
function createPool() {
  return mysql.createPool({
    connectionLimit: 10,
    host: "127.0.0.1",
    user: "user",
    password: "password",
    database: "pipelines",
  });
}

// Test suite for MySQL database interactions
describe("MySQL Database Tests", () => {
  let pool;

  beforeAll(() => {
    // Create a connection pool before running tests
    pool = createPool();

    // Get a connection from the pool
    pool.getConnection((err, connection) => {
      if (err) throw err;
      
      // Execute the SQL script
      executeSqlScript('../database/sample.sql', connection, () => {
        // Release the connection back to the pool
        connection.release();
        done();
      });
    });
  });


  it("should connect to the MySQL database", (done) => {
    // Test connection to the database
    pool.getConnection((err, connection) => {
      if (err) throw err;
      expect(connection).toBeDefined();
      connection.release();
      done();
    });
  });

  it("should set itself up", (done) => {
    // Test connection to the database
    pool.getConnection((err, connection) => {
      if (err) throw err;
      expect(connection).toBeDefined();
      connection.release();
      done();
    });
  });

  let tableNames = [
    "CustomerData",
    "Pets",
    "Appointment",
    "Payments",
    "ServiceTypes",
    "Employees",
    "EmployeeAssignments",
  ];
  tableNames.forEach((table) => {
    it("should retrieve data from the MySQL database", (done) => {
      // Test retrieving data from the database
      pool.query(`SELECT * FROM ${table}`, (err, results) => {
        if (err) throw err;
        expect(results.length).toBeGreaterThan(0);
        done();
      });
    });
  });

  afterAll((done) => {
    // Close the connection pool after all tests are finished
    pool.end(done);
  });
});


function executeSqlScript(sqlScriptPath, connection, done) {
  // Read SQL script file
  fs.readFile(sqlScriptPath, 'utf8', (err, sqlScript) => {
    if (err) throw err;
    
    // Execute SQL script
    connection.query(sqlScript, (err) => {
      if (err) throw err;
      done();
    });
  });
}