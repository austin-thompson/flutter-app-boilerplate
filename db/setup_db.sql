-- Create the Users table
CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    Username VARCHAR(32) NOT NULL,
    Password VARCHAR(32) NOT NULL
);

-- Create the UserInformation table
CREATE TABLE UserInformation (
    UserId INT PRIMARY KEY,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    Location VARCHAR(32),
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

-- Insert sample data into Users
INSERT INTO Users (UserId, Username, Password) VALUES
(1, 'admin', 'admin'), 
(2, 'john_doe', 'password123'), 
(3, 'jane_doe', 'qwerty456');

-- Insert sample data into UserInformation
INSERT INTO UserInformation (UserId, FirstName, LastName, Location) VALUES
(1, 'Test', 'Test', 'Test'), 
(2, 'John', 'Doe', 'New York'), 
(3, 'Jane', 'Doe', 'San Francisco');
