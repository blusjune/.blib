#!/bin/sh
##.bdx.0120.n.gfp_github_push.sh
##_ver=20130407_214020


echo "#>> update gighub source tree (add-commit-push)";

rm -f .tstamp.*;
touch .tstamp.$(tstamp);

git add -A
git commit -a
git push -u


