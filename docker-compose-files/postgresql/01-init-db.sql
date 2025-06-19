-- Create a new user named 'postgresql' with the specified password. The user
-- will have the ability to connect to the database, but no other privileges yet
CREATE USER postgresql WITH PASSWORD 'StrongUniqueUserPassword1234';

-- Create a new database called 'postgresql_db'. This will be the database the
-- newly created user will interact with.
CREATE DATABASE postgresql_db;

-- Grant all privileges (e.g., SELECT, INSERT, UPDATE, DELETE, etc.)  on
-- the 'postgresql_db' database to the 'postgresql' user, allowing them
-- full control over the database.
GRANT ALL PRIVILEGES ON DATABASE postgresql_db TO postgresql;
