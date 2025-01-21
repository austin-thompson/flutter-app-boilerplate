const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const cors = require('cors');
const bcrypt = require('bcrypt'); // For password hashing

const app = express();
const port = 3000;

// PostgreSQL connection setup
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: '89393989', // Replace with your actual database password
    port: 5432,
});

app.use(cors());
app.use(bodyParser.json());

// Route to register a new user
app.post('/register', async (req, res) => {
    const { username, password, firstName = 'DefaultFirstName', lastName = 'DefaultLastName', location = 'DefaultLocation' } = req.body;

    if (!username || !password) {
        return res.status(400).send({ 
            success: false, 
            message: 'Username and password are required' 
        });
    }

    try {
        // Check if the username already exists
        const checkQuery = 'SELECT COUNT(*) FROM Users WHERE Username = $1';
        const checkResult = await pool.query(checkQuery, [username]);

        if (parseInt(checkResult.rows[0].count, 10) > 0) {
            return res.status(409).send({ success: false, message: 'Username already exists' });
        }

        // Hash the password before storing it
        const saltRounds = 10; // Adjust based on desired security and performance
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Insert the new user into the Users table
        const userInsertQuery = `
            INSERT INTO Users (Username, Password)
            VALUES ($1, $2)
            RETURNING UserId
        `;
        const userResult = await pool.query(userInsertQuery, [username, hashedPassword]);

        // Retrieve the newly created UserId
        const userId = userResult.rows[0].userid;

        // Insert default UserInformation for the new user
        const infoInsertQuery = `
            INSERT INTO UserInformation (UserId, FirstName, LastName, Location)
            VALUES ($1, $2, $3, $4)
        `;
        await pool.query(infoInsertQuery, [userId, firstName, lastName, location]);

        res.status(201).send({ success: true, message: 'User registered successfully' });
    } catch (err) {
        console.error('Error querying the database', err);
        res.status(500).send({ success: false, message: 'Server error' });
    }
});

// Route to verify login
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).send({ success: false, message: 'Username and password are required' });
    }

    try {
        // Fetch the user's hashed password from the database
        const query = 'SELECT Password FROM Users WHERE Username = $1';
        const result = await pool.query(query, [username]);

        if (result.rows.length === 0) {
            return res.status(401).send({ success: false, message: 'Invalid credentials' });
        }

        const hashedPassword = result.rows[0].password;

        // Compare the provided password with the hashed password
        const isMatch = await bcrypt.compare(password, hashedPassword);

        if (isMatch) {
            res.status(200).send({ success: true, message: 'Login successful' });
        } else {
            res.status(401).send({ success: false, message: 'Invalid credentials' });
        }
    } catch (err) {
        console.error('Error querying the database', err);
        res.status(500).send({ success: false, message: 'Server error' });
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
