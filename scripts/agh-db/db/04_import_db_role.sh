db_role=agh
db_role_passWord=h7MzJyA8ULai

# 執行SQL建立ROLE及DATABASE
cat << EOF | sudo -u postgres psql -f -
CREATE ROLE $db_role WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
	PASSWORD '$db_role_passWord'; -- please replaced the password before execute

-- Create captain DB
CREATE DATABASE "capt-db" WITH 
  OWNER = $db_role
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c capt-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $db_role;

-- Create core DB
CREATE DATABASE "core-db" WITH 
  OWNER = $db_role
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c core-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $db_role;

-- Create expmgr DB
CREATE DATABASE "expmgr-db" WITH 
  OWNER = $db_role
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c expmgr-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $db_role;

-- Create template DB
CREATE DATABASE "template-db" WITH 
  OWNER = $db_role
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c template-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $db_role;
EOF
