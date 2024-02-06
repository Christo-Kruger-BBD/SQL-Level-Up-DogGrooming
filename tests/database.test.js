const mysql = require("mysql");

// Function to create a MySQL connection pool
function createPool() {
  return mysql.createPool({
    connectionLimit: 10,
    host: "localhost",
    user: "root",
    password: "password",
    database: "test_db",
  });
}

// Test suite for MySQL database interactions
describe("MySQL Database Tests", () => {
  let pool;

  beforeAll(() => {
    // Create a connection pool before running tests
    pool = createPool();
  });

  afterAll((done) => {
    // Close the connection pool after all tests are finished
    pool.end(done);
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
});
