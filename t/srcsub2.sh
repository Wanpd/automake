#! /bin/sh
# Copyright (C) 2001-2012 Free Software Foundation, Inc.
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

# Test to make sure config sub in _SOURCES fails.

. ./defs || Exit 1

cat >> configure.ac << 'END'
AC_PROG_CC
END

cat > Makefile.am << 'END'
bin_PROGRAMS = x
bar = @FOO@
foo = $(bar)
x_SOURCES = x.c $(foo)
EXTRA_x_SOURCES = y.c
END

$ACLOCAL
AUTOMAKE_fails
grep 'Makefile.am:2:.*bar.*substitution' stderr
grep 'Makefile.am:2:.*x_SOURCES' stderr
