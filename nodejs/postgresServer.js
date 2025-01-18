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
    password: '89393989',
    port: 5432,
});

app.use(cors());
app.use(bodyParser.json());

// Route to verify login
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const query = `
        SELECT COUNT(*)
        FROM users
        WHERE username = $1 AND password = $2;
        `;
        const result = await pool.query(query, [username, password]);

        if (result.rows[0].count > 0) {
            res.status(200).send({ success: true, message: 'Login successful' });
        } else {
            res.status(401).send({ success: false, message: 'Invalid credentials' });
        }
    } catch (err) {
        console.error('Error querying the database', err);
        res.status(500).send({ success: false, message: 'Server error' });
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
