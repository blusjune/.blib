#!/bin/sh
#_ver=20130617_213715;

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
echo "#>> drop and re-create wikidb_radiohead ...";
echo "drop database wikidb_radiohead; create database wikidb_radiohead;" | mysql -p -u root;
echo "#>> import wikidb_radiohead from $_sql_wikidb ...";
mysql -p -u root wikidb_radiohead < tmp/$_sql_wikidb;
