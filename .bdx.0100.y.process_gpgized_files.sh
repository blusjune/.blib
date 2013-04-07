#!/bin/sh
##.bdx.0100.y.process_gpgized_files.sh
##_ver=20130407_213858


##gfp: gpgized file processing
_gfp_files=$(ls -1 .bdx.*.n.gfp_*.sh);
for _i in $_gfp_files; do
	. $_i;
done


