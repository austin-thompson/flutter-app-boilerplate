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

-- Insert sample data into Users (passwords must already be hashed by the server)
INSERT INTO Users (Username, Password) VALUES
('admin', '$2b$10$HhK7S8Gskdl3VXzMRoYkmObG1dcBGBxdNXKfx88b/JMwJsUytLtuK'), -- bcrypt hash of 'admin'
('john_doe', '$2b$10$qP8IVbQ93rv.B26nMhf8AOQ8OdQ/BtV/9OUrW7E0pkLbhmBtUmkPS'), -- bcrypt hash of 'password123'
('jane_doe', '$2b$10$dR2vnsjJW6FPx2SWguHxoelU68xgobFf/dtz6.rEbJEPscpt8VzMK'); -- bcrypt hash of 'qwerty456'

-- Insert sample data into UserInformation
INSERT INTO UserInformation (UserId, FirstName, LastName, Location) VALUES
(1, 'Admin', 'User', 'Admin Location'),
(2, 'John', 'Doe', 'New York'),
(3, 'Jane', 'Doe', 'San Francisco');

-- Verify the data in both tables
SELECT * FROM Users;
SELECT * FROM UserInformation;
