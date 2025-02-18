CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(100),
                       email VARCHAR(200),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- Add some sample data
INSERT INTO users (name, email) VALUES
                                    ('  Ajinkya', 'aj@example.com');