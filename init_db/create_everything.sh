#!/bin/bash

echo "Setup up databases"
sudo -u postgres psql -f database_user.sql

