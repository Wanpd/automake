#! /bin/sh
# Copyright (C) 1999-2012 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Test to make sure empty _SOURCES works.
# From Paul Berrevoets.

. ./defs || Exit 1

cat >> configure.ac << 'END'
AC_PROG_CC
AC_SUBST(ZOO_OBJ)
END

cat > Makefile.am << 'END'
noinst_PROGRAMS = zoo
zoo_SOURCES =
EXTRA_zoo_SOURCES = bar.c foo.c
zoo_DEPENDENCIES = $(ZOO_OBJ)
zoo_LDADD = $(zoo_DEPENDENCIES)
END

$ACLOCAL
$AUTOMAKE
$FGREP zoo. Makefile.in && Exit 1
Exit 0
