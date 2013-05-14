#!/bin/sh
##.bdx.0110.n.gfp_mysqldump.sh
##gfp: gpgized file processing
##_ver=20121219_234356
##_ver=20130407_112750
##_ver=20130407_212836


_tstamp="$(tstamp)";


rm -f .tstamp.*;
touch .tstamp.${_tstamp};


_sql_wikidb="wikidb.sql";
echo "#>> [$(..ts)] mysql wikidb -> sql_dump/wikidb.sql";
mysqldump -p -u root wikidb > sql_dump/${_sql_wikidb};
(cd sql_dump; split -a 5 -l 10 -d $_sql_wikidb _sql_; sync; sleep 2; rm $_sql_wikidb;)


