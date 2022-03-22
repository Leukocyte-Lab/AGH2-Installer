#!/bin/bash

cat << EOF | runuser -u postgres -- psql -f -
CREATE ROLE $DB_USER WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
	PASSWORD '$DB_PASSWORD';

-- Create captain DB
CREATE DATABASE "captain-db" WITH 
  OWNER = $DB_USER
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c captain-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $DB_USER;

-- Create core DB
CREATE DATABASE "core-db" WITH 
  OWNER = $DB_USER
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c core-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $DB_USER;

-- Create exploitmgr DB
CREATE DATABASE "exploitmgr-db" WITH 
  OWNER = $DB_USER
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c exploitmgr-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $DB_USER;

-- Create template DB
CREATE DATABASE "template-db" WITH 
  OWNER = $DB_USER
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
\c template-db
CREATE EXTENSION IF NOT EXISTS pgroonga;
GRANT USAGE ON SCHEMA pgroonga TO $DB_USER;
EOF