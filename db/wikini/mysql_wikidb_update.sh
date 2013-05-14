#!/bin/sh
ln -s /x/t/share tmp;
_tstamp=$(ls -1 .tstamp.* | sed -e 's/\.tstamp\.\(.*\)/\1/g');
_sql_wikidb="wikidb-${_tstamp}.sql";
cat sql_dump/_sql_* > tmp/$_sql_wikidb;
echo "drop database wikidb; create database wikidb;" | mysql -p -u root;
mysql -p -u root wikidb < tmp/$_sql_wikidb;
