##.bdx.1020.n.gfpsub_wikini_enpack.sh
##gfp: gpgized file processing
##_ver=20121219_234356;
##_ver=20130511_103052; #initial use of 'if [ "#$_value" = "#y" ]; then'
##_ver=20130514_112017;
##_ver=20130628_025524; #return to no use of 'if [ "#$_value" = "#y" ]; then'
##_ver=20130701_015219; #introduce /tmp/.bdxcf.wikini.enpack first time




if [ -f /tmp/.bdxcf.wikini.enpack ]; then
	_conf_wikini__enpack="y"; # default: "n"
else
	_conf_wikini__enpack="n"; # default: "n"
fi
_conf_wikini__root="${HOME}/.blib/wiki/wikini";
_conf_wikini__target_db="wikidb_radiohead";
_conf_wikini__mediawiki_var_root="/var/lib/mediawiki";
_conf_wikini__script_file_to_update_db="mysql_wikidb_update.sh";




_execute_flag_1="y";
if [ "X$_conf_wikini__enpack" = "Xy" ]; then
#------------------------------------------------
	if [ ! -d ${HOME}/.blib ]; then
		echo "#>> '${HOME}/.blib' does not exist -- escape from this task";
		_execute_flag_1="n";
	fi
	if [ ! -d ${_conf_wikini__mediawiki_var_root} ]; then
		echo "#>> '${_conf_wikini__mediawiki_var_root}' does not exist -- escape from this task";
		_execute_flag_1="n";
	fi

	if [ ! -d $_conf_wikini__root ]; then
		mkdir -p $_conf_wikini__root;
	fi

	if [ "X$_execute_flag_1" = "Xy" ]; then
		(
		cd $_conf_wikini__root;
	
		_sql_dump_file="${_conf_wikini__target_db}.sql";
		_var_lib_mediawiki_images_tarball="var_lib_mediawiki_images.tgz";
		_sql_dump_dir="sql_dump";
		_wiki_images_dir="wiki_images";
		_tstamp="$(tstamp)";

		rm -f .tstamp.*;
		touch .tstamp.${_tstamp};
	
		echo "#>> execute mysqldump for '$_conf_wikini__target_db' -> $_sql_dump_file";
		if [ ! -d $_sql_dump_dir ]; then
			mkdir -p $_sql_dump_dir;
		else
			(cd $_sql_dump_dir; rm -f _sql_*;)
		fi
		(
			cd $_sql_dump_dir;
			mysqldump -p -u root $_conf_wikini__target_db > $_sql_dump_file;
			split -a 5 -l 10 -d $_sql_dump_file _sql_; sync; sleep 2; rm -f $_sql_dump_file;
		)
	
		echo "#>> enpack the uploaded $_conf_wikini__target_db images";
		if [ ! -d $_wiki_images_dir ]; then
			mkdir -p $_wiki_images_dir;
		else
			(cd $_wiki_images_dir; rm -f $_var_lib_mediawiki_images_tarball;)
		fi
		(cd $_conf_wikini__mediawiki_var_root; sudo tar cf - images) | gzip -c > ${_wiki_images_dir}/${_var_lib_mediawiki_images_tarball};

		echo "#>> create a script file to update mysql database '$_conf_wikini__target_db' with the latest version";
		cat > $_conf_wikini__script_file_to_update_db << EOF
#!/bin/sh
#_ver=$_tstamp;

if [ ! -d tmp ]; then
	if [ -d /x/t/share ]; then
		ln -s /x/t/share tmp;
	else
		mkdir tmp;
	fi
fi
_tstamp_file=\$(ls -1 .tstamp.* | sed -e 's/\.tstamp\.\(.*\)/\1/g');
_sql_wikidb="wikidb-\${_tstamp_file}.sql";
echo "#>> merging DB ...";
cat ${_sql_dump_dir}/_sql_* > tmp/\$_sql_wikidb;
echo "#>> drop and re-create $_conf_wikini__target_db ...";
echo "drop database $_conf_wikini__target_db; create database $_conf_wikini__target_db;" | mysql -p -u root;
echo "#>> import $_conf_wikini__target_db from \$_sql_wikidb ...";
mysql -p -u root $_conf_wikini__target_db < tmp/\$_sql_wikidb;
EOF
		chmod 755 $_conf_wikini__script_file_to_update_db;

		)
	fi
#------------------------------------------------
else
	echo "#>> NOT EXECUTED by conf";
fi




