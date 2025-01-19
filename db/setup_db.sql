-- Enable the pgcrypto extension for cryptographic functions
CREATE EXTENSION IF NOT EXISTS pgcrypto;

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

-- Insert sample data into Users (passwords will be hashed, and default UserInformation will be added)
INSERT INTO Users (Username, Password) VALUES
('admin', 'admin'), 
('john_doe', 'password123'), 
('jane_doe', 'qwerty456');

-- Verify the data in both tables
SELECT * FROM Users;
SELECT * FROM UserInformation;
