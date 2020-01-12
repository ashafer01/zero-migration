BEGIN;
INSERT INTO example_schema (applied) VALUES ('001');

-- Initial table setup

-- Encoded data blobs
CREATE TABLE app_data (
    id SERIAL PRIMARY KEY,
    source_url TEXT,
    data_b64 TEXT
);

-- Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL,
    given_name TEXT NOT NULL,
    family_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

COMMIT;
