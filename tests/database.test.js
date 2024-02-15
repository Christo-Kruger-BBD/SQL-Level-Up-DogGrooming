const mssql = require("mssql");
const AWS = require('aws-sdk');
const fs = require("fs");
const path = require("path");

const SECONDS = 1000;
jest.setTimeout(1.5 * SECONDS);

const dbName = process.env.FW_NAME;
console.log("IM HEREEEEEE!!!!");
console.log("dbName ", dbName);

// Create AWS Secrets Manager client
const secretsManager = new AWS.SecretsManager({
  region: 'eu-west-1'
});

// Function to retrieve secrets from AWS Secrets Manager
async function getSecrets() {
  try {
    const data = await secretsManager.getSecretValue({ SecretId: 'dbcreds' }).promise();
    return JSON.parse(data.SecretString);
  } catch (error) {
    console.error("Error retrieving secrets:", error);
    throw error;
  }
}

// Test suite for MSSQL database interactions
describe("MSSQL Database Tests", () => {

  let pool;
  let request;

  beforeAll(async (done) => {
    // Retrieve secrets from AWS Secrets Manager
    const secrets = await getSecrets();
    const { username, password } = secrets;

    // Create a MSSQL connection pool with retrieved secrets
    const config = {
      user: username,
      password: password,
      server: 'localhost',
      database: dbName,
      options: {
        trustServerCertificate: true,
      },
    };

    pool = await mssql.connect(config);
    request = pool.request();

    // Execute SQL script
    executeSqlScript("../database/migrations/V20240208__Init_Setup.sql", done);
  });

  it("should connect to the MSSQL database", () => {
    // Test connection to the database
    expect(pool.connected).toBeTruthy();
  });

  // Other test cases...

  afterAll(async () => {
    // Close the connection pool after all tests are finished
    await pool.close();
  });
});

function executeSqlScript(sqlScriptPath, done) {
  let sqlScriptFilePath = path.join(__dirname, sqlScriptPath);

  // Read SQL script file
  fs.readFile(sqlScriptFilePath, "utf8", async (err, sqlScript) => {
    if (err) throw err;

    // Execute SQL script
    try {
      const result = await pool.query(sqlScript);
      done();
    } catch (error) {
      console.error("Error executing SQL script:", error);
      throw error;
    }
  });
}
