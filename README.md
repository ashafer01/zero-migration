# zero-migration

The simplest possible database schema migration tool.

Depends on only very basic and standard SQL syntax and concepts. This should work across
most database engines. The tool itself needs only bash and a small subset of coreutils.
It presently clocks in under 50 lines in total.

## How does it work?

The first SQL file that is created sets up a one-column tracking table with a primary key.

Each additional SQL file is wrapped in a transaction, and the first line of that transaction
attempts to insert a static value into the tracking table. If the file has already been applied,
the primary key will cause an error and thus the rest of the transaction will be aborted.

As simple as it can get.

## Documentation

First I suggest adding `zero-migration` to your PATH. This can be accomplished by a variety
of means.

Then, set up a schema directory:

```bash
mkdir my_schema
cd my_schema
zero-migration init my_schema_tracking_table
```

This will create both `000.sql` and `001.sql`. As the output says, you can add your initial
schema definitions in 001.sql.

...

After this schema file gets pushed and distributed to multiple environments or end-users,
do not modify it to change the schema. Instead, add a new migration file:

```bash
zero-migration add
```

This will create a new file just like the initial `001.sql` for your modification.

## Applying

Your DBMS' existing CLI tool will handle the application for you. All you have to do is output
all of the schema files in order. zero-migration provides a subcommand for this, however it
is a wrapper for the bash one-liner `ls *.sql | sort | xargs cat`. **There is no need for end-users
to use the zero-migration tool to apply.** (You are also welome to redistribute and modify the tool
if preferred).

Example for Postgres; other DBMS CLI tools will differ slightly:

```bash
zero-migration apply | psql -U postgres "$db_name"
```

## Naming and Structural Requirements

* Migration filenames all begin with a sequence of digits, and end with `.sql`.
* The file that sorts first must contain the original tracking table statement as the first `CREATE TABLE`
  in the file. It's generally not recommended to modify this file, but adding additional SQL after the first
  line will not break anything.
* If you need to rename files to add more digits (> 999 migrations), *do not* modify the `INSERT`
  statements to match.
* Renaming such that the sort order changes will cause breakage.
