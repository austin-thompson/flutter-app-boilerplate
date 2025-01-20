# PostgreSQL Database Setup and User Management

This script sets up the PostgreSQL database schema for managing users with enhanced security features such as password hashing. It creates two main tables: `Users` for storing user credentials and `UserInformation` for additional user details. Additionally, triggers are implemented to automatically hash passwords and insert default user information when new users are added.

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

If you prefer a quicker setup, you can run the provided `setup_db.sql` script. It includes all necessary commands to configure your database, create tables, functions, and triggers, and insert sample data.

1. **Download or Copy `setup_db.sql`**: The `setup_db.sql` file is located in the `db/` subdirectory of the project.

2. **Run the Script**: Execute the script in your PostgreSQL client (e.g., psql, PgAdmin, etc.) by running:
   ```sql
   \i /path/to/project/db/setup_db.sql
   ```
   This will automatically set up the necessary database schema and sample data.

### Manual Setup

If you prefer to configure your database manually, follow the steps below.

#### 1. **Enable `pgcrypto` Extension**

The `pgcrypto` extension is required for password hashing functions like bcrypt. To enable it, run the following command:

```sql
-- Enable the pgcrypto extension for cryptographic functions
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

#### 2. **Create Tables**

You can manually create the `Users` and `UserInformation` tables by running the following commands:

```sql
-- Drop and recreate the Users table with enhanced security
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

#### 3. **Create Functions and Triggers**

The following SQL functions and triggers will automatically hash passwords before insertion and add default user information for new users.

```sql
-- Function to hash passwords before inserting into the Users table
CREATE OR REPLACE FUNCTION hash_password()
RETURNS TRIGGER AS $$
BEGIN
    NEW.Password = crypt(NEW.Password, gen_salt('bf')); -- Use bcrypt for password hashing
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to hash passwords before inserting into the Users table
CREATE TRIGGER before_user_insert
BEFORE INSERT ON Users
FOR EACH ROW
EXECUTE FUNCTION hash_password();

-- Function to insert default UserInformation after a new user is added
CREATE OR REPLACE FUNCTION add_default_user_information()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert default values into UserInformation
    INSERT INTO UserInformation (UserId, FirstName, LastName, Location)
    VALUES (NEW.UserId, 'DefaultFirstName', 'DefaultLastName', 'DefaultLocation');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to add default UserInformation after inserting into the Users table
CREATE TRIGGER after_user_insert
AFTER INSERT ON Users
FOR EACH ROW
EXECUTE FUNCTION add_default_user_information();
```

#### 4. **Insert Sample Data**

To add sample users with hashed passwords, run the following insert statement. The triggers will automatically hash the passwords and insert default user information.

```sql
-- Insert sample data into Users (passwords will be hashed, and default UserInformation will be added)
INSERT INTO Users (Username, Password) VALUES
('admin', 'admin'),
('john_doe', 'password123'),
('jane_doe', 'qwerty456');
```

#### 5. **Verify Data**

To check the contents of the `Users` and `UserInformation` tables after running the above commands, use the following queries:

```sql
-- Verify the data in the Users table
SELECT * FROM Users;

-- Verify the data in the UserInformation table
SELECT * FROM UserInformation;
```

## Notes:

- This setup requires the **latest version of PostgreSQL**. Make sure you have the correct version installed. However, future versions of PostgreSQL should still work with this script.
- The `pgcrypto` extension is necessary for bcrypt password hashing functionality.
- Default user information will be automatically populated with placeholder values (`DefaultFirstName`, `DefaultLastName`, `DefaultLocation`) when new users are created.

---

Let me know if you need any further assistance!
