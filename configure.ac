dnl Please see Autoconf manual for details on modifying this file:
dnl
dnl http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/index.html
dnl
dnl which is also viewable from GNU info tool:
dnl
dnl $ info autoconf
dnl
dnl Macros starting with AM_ prefix are described in Automake manual:
dnl
dnl http://www.gnu.org/software/automake/manual/html_node/index.html
dnl
dnl which is also viewable from GNU info tool:
dnl
dnl $ info automake

dnl Initialize autoconf.
dnl
dnl Package name and revision are used by 'make dist' and 'make install'
dnl targets as well as made available to application.
dnl
dnl See Section 4.1, 'Intializing configure', for more details
AC_INIT([helloworld-grpc],[1.0],[],[],[])

dnl Look for useful macros to enhance configure's behavior at
dnl http://www.gnu.org/software/autoconf-archive and place them
dnl the m4 directory.
AC_CONFIG_MACRO_DIR([m4])

dnl Initialize automake support and customize its behavior:
dnl
dnl 1.11 - Requires automake 1.11 or newer because of parallel-tests feature
dnl -Wall - Increase automake warning level
dnl -Werror - Turn automake warnings into errors.
dnl -Wno-portability - Allows us to use gmake extension and not be limitted
dnl to only features of POSIX make.
dnl foreign - turn off check for GNU file conventions (Changelog, NEWS, etc)
dnl parallel-tests - default to parallel test runner
dnl
dnl See Section automake's Section 17.2, ' List of Automake options',
dnl for more details.
AM_INIT_AUTOMAKE([1.11 -Wall -Werror -Wno-portability foreign parallel-tests subdir-objects])
dnl Display little during compiles.  Use 'make V=1' to be verbose.
AM_SILENT_RULES([yes])
dnl Default is maintainer-mode enabled *but* without --disable-maintainer-mode
dnl arg. Calling AM_MAINTAINER_MODE enables by default and adds arg to disable.
AM_MAINTAINER_MODE([enable])

AM_EXTRA_RECURSIVE_TARGETS([check-xml])

dnl This is a C++ application and library. Autoconf default is for a C
dnl application/library.
AC_PROG_CXX
AC_LANG([C++])
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_MAKE_SET

dnl Enable C++11 with GNU extensions when avialable.
AX_CXX_COMPILE_STDCXX_11([], [optional])

dnl Add variable to increase compiler warnings for use by Makefile's. This
dnl is not added to global *FLAGS so it can be adjusted per application/library.
dnl If added globally, it tends to be immediately disabled for project at
dnl first compile failure during schedule pressure.
if test "$GXX" = yes; then
    WARNING_CFLAGS="-Wall -Werror"
    WARNING_CXXFLAGS="-Wall -Werror"
fi
AC_SUBST(WARNING_CFLAGS)
AC_SUBST(WARNING_CXXFLAGS)

LT_INIT([disable-static])

dnl Enabling valgrind will cause all host based unit tests to be ran with
dnl valgrind to detect memory leaks.  --error-exitcode will cause unit test to
dnl fail when leaks are detected. This option is only used by 'make check'
dnl target.
AC_ARG_ENABLE(valgrind,
	      AS_HELP_STRING([--enable-valgrind],
			     [Enable use of valgrind when running tests.]))

AS_IF([test "x$enable_valgrind" = "xyes"],
      [
       AC_CHECK_PROG(have_valgrind, valgrind, [yes], [no])
       AS_IF([test "x$have_valgrind" = "xno"],
	     AC_MSG_ERROR([Valgrind enabled but executable not found.]))
       ],
       [have_valgrind=no])

AS_IF([test "x$have_valgrind" = "xyes"],
      [VALGRINDOPT="--enable-valgrind"])
AC_SUBST(VALGRINDOPT)

AX_GCOVR()

DX_MAN_FEATURE(ON)
DX_INIT_DOXYGEN([$PACKAGE_NAME], [doxygen.cfg])

PKG_CHECK_MODULES([GRPCPP], [protobuf libssl libcrypto libcares grpc grpc++])

dnl Inform autoconf of files that need substitution based on previous
dnl checks.
AC_CONFIG_FILES([Makefile src/Makefile test/Makefile])

dnl Generated output files with substitutions.
AC_OUTPUT

echo "Configure was successful.  Run 'make' to compile."
