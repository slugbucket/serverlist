#!/bin/sh

sql_file="/tmp/packagelist.sql"
echo "INSERT INTO packages (name, description, created_at, updated_at) VALUES" > $sql_file

for pkg in \
"package-1" \
"package-2" \
"package-n"
do
  echo "creating SQL insert for package, ${pkg}"
  echo "(\"${pkg}\", \"Internal application package\", NOW(), NOW())," >> $sql_file
done
