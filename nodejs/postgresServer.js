const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const cors = require('cors');

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
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).send({ success: false, message: 'Username and password are required' });
    }

    try {
        // Check if the username already exists
        const checkQuery = 'SELECT COUNT(*) FROM users WHERE username = $1';
        const checkResult = await pool.query(checkQuery, [username]);

        if (checkResult.rows[0].count > 0) {
            return res.status(409).send({ success: false, message: 'Username already exists' });
        }

        // Insert the new user into the database (password will be hashed by the database trigger)
        const insertQuery = 'INSERT INTO users (username, password) VALUES ($1, $2)';
        await pool.query(insertQuery, [username, password]);

        res.status(201).send({ success: true, message: 'User registered successfully' });
    } catch (err) {
        console.error('Error querying the database', err);
        res.status(500).send({ success: false, message: 'Server error' });
    }
});

// Route to verify login
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Fetch the user details and compare using the `crypt` function
        const query = `
            SELECT 1
            FROM users
            WHERE username = $1 AND password = crypt($2, password)
        `;
        const result = await pool.query(query, [username, password]);

        if (result.rows.length > 0) {
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
