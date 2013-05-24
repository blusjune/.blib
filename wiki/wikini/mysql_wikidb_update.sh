#!/bin/sh
#_ver=20130524_185559;

if [ ! -d tmp ]; then
	if [ -d /x/t/share ]; then
		ln -s /x/t/share tmp;
	else
		mkdir tmp;
	fi
fi
_tstamp_file=$(ls -1 .tstamp.* | sed -e 's/\.tstamp\.\(.*\)/\1/g');
_sql_wikidb="wikidb-${_tstamp_file}.sql";
echo "#>> merging DB ...";
cat sql_dump/_sql_* > tmp/$_sql_wikidb;
echo "#>> drop and re-create wikidb ...";
echo "drop database wikidb; create database wikidb;" | mysql -p -u root;
echo "#>> import wikidb from $_sql_wikidb ...";
mysql -p -u root wikidb < tmp/$_sql_wikidb;
