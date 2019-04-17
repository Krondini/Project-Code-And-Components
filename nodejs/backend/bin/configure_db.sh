#!/bin/bash

export PGPASSWORD='Change this to your postgres password'

echo "Configuring database"

dropdb -U postgres projects
createdb -U postgres projects


psql -U postgres projects < ./bin/sql/account.sql

echo "finished"