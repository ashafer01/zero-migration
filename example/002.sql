BEGIN;
INSERT INTO example_schema (applied) VALUES ('002');

-- Missed constraints in initial schema
ALTER TABLE users ADD CONSTRAINT username_unique UNIQUE (username);
ALTER TABLE app_data ALTER COLUMN source_url SET NOT NULL;
ALTER TABLE app_data ALTER COLUMN data_b64 SET NOT NULL;

COMMIT;
