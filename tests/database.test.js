const mssql = require("mssql");
const fs = require("fs");
const path = require("path");

const SECONDS = 1000;
jest.setTimeout(1.5 * SECONDS);

const dbHost = process.env.DB_SERVER_HOST_NAME;
const dbName = process.env.DB_NAME;
const dbUser = process.env.DB_USERNAME;
const dbPassword = process.env.DB_PASSWORD;

// Function to create a MSSQL connection pool
const config = {
  user: dbUser,
  password: dbPassword,
  server: dbHost,
  database: dbName,
  options: {
    trustServerCertificate: true,
  },
};

// Test suite for MSSQL database interactions
describe("MSSQL Database Tests", () => {
  
  let request;
  beforeAll((done) => {
    // Create a connection pool before running tests
    mssql.connect(config, function (err) {
      // Create Request object to perform
      // query operation
      request = new mssql.Request();

      // Query to the database and get the records
      executeSqlScript(
        "../database/migrations/V20240208__Init_Setup.sql",
        request,
        done
      );
    });
  });

  it("should connect to the MSSQL database", (done) => {
    // Test connection to the database
    expect(pool.connected).toBeTruthy();
    done();
  });

  it("should set itself up", (done) => {
    // Test connection to the database
    expect(pool.connected).toBeTruthy();
    done();
  });

  let tableNames = [
    "CustomerData",
    // Add more tables if needed
  ];

  tableNames.forEach((table) => {
    it(`should retrieve data from the MSSQL table ${table}`, (done) => {
      // Test retrieving data from the database
      pool.request().query(`SELECT * FROM ${table}`, (err, result) => {
        if (err) throw err;
        expect(result.recordset.length).toBeGreaterThan(0);
        done();
      });
    });
  });

  afterAll((done) => {
    // Close the connection pool after all tests are finished
    request.close();
    done();
  });
});

function executeSqlScript(sqlScriptPath, request, done) {
  let sqlScriptFilePath = path.join(__dirname, sqlScriptPath);

  // Read SQL script file
  fs.readFile(sqlScriptFilePath, "utf8", (err, sqlScript) => {
    if (err) throw err;

    request.query(sqlScript, function (err, records) {
      if (err) console.log(err);

      // Send records as a response
      // to browser
      res.send(records);

      done();
    });
  });
}

//   "Pets",
//   "Appointment",
//   "Payments",
//   "ServiceTypes",
//   "Employees",
//   "EmployeeAssignments",
// ];
