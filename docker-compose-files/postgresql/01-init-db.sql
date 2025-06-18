CREATE USER postgresql WITH PASSWORD 'StrongUniqueUserPassword1234';
CREATE DATABASE postgresql_db;
GRANT ALL PRIVILEGES ON DATABASE postgresql_db TO postgresql;
