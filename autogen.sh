#!/bin/sh
#
# bootstrap.sh - run from freshly cloned git repository to install
# missing autotools files (-i) along with any other 1 time setup.
#
# When ever configure.ac is modified, autoreconf needs to be reran to update
# configure script from template.  As long as this script only runs
# 'autoreconf -i', it can also be used as convience script for that case as
# well.
autoreconf -i
