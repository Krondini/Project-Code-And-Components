#!/bin/bash

export PGPASSWORD='XIAOxiao1998!'

echo "Configuring database"

dropdb -U postgres projects
createdb -U postgres projects


psql -U postgres projects < ./bin/sql/account.sql

echo "finished"