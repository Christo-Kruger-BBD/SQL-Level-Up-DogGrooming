const mssql = require("mssql");
const fs = require("fs");
const path = require("path");

const SECONDS = 1000;
jest.setTimeout(1.5 * SECONDS);

const dbName = process.env.FW_NAME;
const dbUser = process.env.FW_USER;
const dbPassword = process.env.FW_PASS;

// Function to create a MSSQL connection pool
const config = {
  user: dbUser,
  password: dbPassword,
  server: 'localhost',
  database: dbName,
  options: {
    trustServerCertificate: true,
  },
};

// Test suite for MSSQL database interactions
describe("MSSQL Database Tests", () => {
  
  let request;
  beforeAll(async (done) => {
    // Create a connection pool before running tests
    const pool = await mssql.connect(config, function (err) {
      // Query to the database and get the records
    });

    executeSqlScript(
      "../database/migrations/V20240208__Init_Setup.sql",
      done
    );
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
    
    done();
  });
});

 function executeSqlScript(sqlScriptPath, done) {
  let sqlScriptFilePath = path.join(__dirname, sqlScriptPath);
  const config = {
    user: dbUser,
    password: dbPassword,
    server: dbHost,
    database: dbName,
    options: {
      trustServerCertificate: true,
    },
  };
  
  // Read SQL script file
  fs.readFile(sqlScriptFilePath, "utf8", async (err, sqlScript) => {
    if (err) throw err;

    await mssql.connect(config);

    const result = await mssql.query(sqlScript);

    new mssql.query(sqlScript, function (err, records) {
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
