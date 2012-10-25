#!/bin/sh

rm -f .tstamp.*;
touch .tstamp.$(tstamp);

git add -A
git commit -a
git push -u
