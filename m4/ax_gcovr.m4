# SYNOPSIS
#
#   AX_GCOVR()
#
# DESCRIPTION
#
#   Adds --enable-gcov option that will add gcov options to CFLAGS, CXXFLAGS,
#   LDFLAGS as well as disable any optimization flags on CFLAGS/CXXFLAGS.
#
#   Also, Test for gcov program and create GCOV variable
#   Also, Test for gcovr program and create GCOVR variable
#
#   Usage example:
#
#   configure.ac:
#
#     AX_GCOVR
#
#   Makefile.am:
#     GCOV = @GCOV@
#     GCOVR = @GCOVR@
#
#     gcovr:
#         $(GCOVR) --gcov-executable=$(GCOV) -r . -e test
#
#     GCOVR_XML_FILE = coverage.xml
#     gcovr-xml:
#         $(GCOVR) --gcov-executable=$(GCOV) -r . -e test --xml-pretty > $(GCOVR_XML_FILE)
#
#     MOSTLYCLEANFILES = $(GCOVR_XML_FILE)
#
AC_DEFUN([AX_GCOVR],[
	dnl Check for --enable-gcov
	AC_REQUIRE([AC_PROG_SED])

	AC_MSG_CHECKING([whether to build with gcov support])
	AC_ARG_ENABLE([gcov],
	  AS_HELP_STRING([--enable-gcov],
	  [Whether to enable gcov support]),,
	  enable_gcov=no)

	AM_CONDITIONAL([GCOV_ENABLED], [test x$enable_gcov = xyes])
	AC_SUBST([GCOV_ENABLED], [$enable_gcov])
	AC_MSG_RESULT($enable_code_coverage)

	AS_IF([ test "$enable_gcov" = "yes" ], [
		AC_ARG_VAR([GCOV], [gcov command])
		AC_CHECK_TOOL([GCOV], gcov, [:])
		AS_IF([test "X$GCOV" = "X:"],
		  [AC_MSG_ERROR([gcov is needed to do coverage])])

		dnl Check if gcc is being used
		AS_IF([ test "$GCC" = "no" ], [
			AC_MSG_ERROR([not compiling with gcc, which is required for gcov code coverage])
		])

		AC_ARG_VAR([GCOVR], [gcovr command])
		AC_CHECK_PROG([GCOVR], gcovr, gcovr, [:])
		AS_IF([test "X$GCOVR" = "X:"],
		  [AC_MSG_ERROR([gcovr is needed to do coverage])])
		AC_SUBST([GCOVR])

		dnl Optimizations will defeat code coverage so remove those.
		changequote({,})
		CFLAGS=`echo "$CFLAGS" | sed -e 's/-O[0-9]*//g'`
		CXXFLAGS=`echo "$CXXFLAGS" | sed -e 's/-O[0-9]*//g'`
		changequote([,])
		CFLAGS="$CFLAGS -O0 -fprofile-arcs -ftest-coverage -fno-inline -fno-inline-small-functions"
		CXXFLAGS="$CXXFLAGS -O0 -fprofile-arcs -ftest-coverage -fno-inline -fno-inline-small-functions -fno-default-inline"
		LDFLAGS="$LDFLAGS -lgcov"
	])

])
