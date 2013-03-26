#!/bin/sh
##_ver=20130108_153645


_tstamp="$(tstamp)";
mysqldump -p -u root wikidb > wikidb-${_tstamp};
