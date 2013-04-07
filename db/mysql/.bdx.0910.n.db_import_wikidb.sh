#!/bin/sh
##.bdx.0910.n.db_import_wikidb.sh
##_ver=20130407_215713


_tstamp=$(ls -1 .tstamp.* | sed -e 's/\.tstamp\.\(.*\)/\1/g');
_sql_wikidb="wikidb-${_tstamp}.sql";
cat wikini/_sql_* > tmp/$_sql_wikidb;


