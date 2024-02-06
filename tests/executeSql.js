export default function executeSqlScript(sqlScriptPath, connection, done) {
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