# PostgreSQL Database Setup and User Management

This script sets up the PostgreSQL database schema for managing users with enhanced security features such as password hashing.
It creates two main tables:

- `Users` for storing user credentials
- `UserInformation` for additional user details.

This project uses the **latest version of PostgreSQL** for its database setup, and the provided SQL script is compatible with the most recent releases.

## Prerequisite: Install PostgreSQL

Before proceeding with the setup, ensure that the **latest version of PostgreSQL** is installed on your system.

- [Download PostgreSQL](https://www.postgresql.org/download/)

### Installing PostgreSQL

1. Download the appropriate version for your operating system from the link above.
2. Follow the installation instructions provided on the PostgreSQL website for your OS.

---

## Setup Steps

### Simple Setup with `setup_db.sql`

If you prefer a quicker setup, you can run the provided `setup_db.sql` script. It includes all necessary commands to configure your database.

1. **Download or Copy `setup_db.sql`**: The `setup_db.sql` file is located in the `db/` subdirectory of the project.

2. **Run the Script**: Execute the script in your PostgreSQL client (e.g., psql, PgAdmin, etc.) by running:
   ```sql
   \i /path/to/project/db/setup_db.sql
   ```
   This will automatically set up the necessary database schema and sample data.

### Manual Setup

If you prefer to configure your database manually, follow the steps below.

#### 1. **Create Tables**

You can manually create the `Users` and `UserInformation` tables by running the following commands:

```sql
-- Drop and recreate the Users table
DROP TABLE IF EXISTS Users CASCADE;

CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    Username VARCHAR(32) NOT NULL UNIQUE,
    Password TEXT NOT NULL -- Store the hashed password as TEXT
);

-- Drop and recreate the UserInformation table
DROP TABLE IF EXISTS UserInformation;

CREATE TABLE UserInformation (
    UserId INT PRIMARY KEY,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    Location VARCHAR(32),
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);
```
