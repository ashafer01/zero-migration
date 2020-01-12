BEGIN;
INSERT INTO example_schema (applied) VALUES ('003');

-- Add data owner reference

ALTER TABLE app_data ADD COLUMN owner INT REFERENCES users ON DELETE CASCADE;

COMMIT;
