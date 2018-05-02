Example "Hello, World!" gRPC C++ application.

This compiles an application called greeter_server and can be ran to
listen for clients.  It also compiles an applicatoin called greeter_client
that cna be ran to conect to this server.

    $ ./autogen.sh
    $ mkdir build
    $ cd build
    $ ../configure --prefix=`pwd`/debug --enable-gcov --enable-valgrind
    $ make
    $ ./src/greeter_server &
    [1] 12345
    Server listening on 0.0.0.0:50051
    $ ./src/greeter_client
    Greeter received: Hello world

It is safe to always have debug enabled because you can chose to install with
or without debug symbols by choice of install target. Also, release applications
and libraries should not have gcov enabled and so the '--enable-gcov' should
be removed for most usecases of 'make install-strip'.

    $ make install
    $ make install-strip

The following unit test related targets exist.  They run unit tests using
automake's test framework and display code coverage reports on the terminal.
Unit tests create log files that can be reviewed for failure details.

    $ make check
    $ make gcovr

The following static analysis targets exist that are useful when ran from
a terminal or inside Vim/Eclipse/Emacs.  Since all reports are gnu gcc
compatible, most editors will populate their quickfix/problems windows
with the issues found.

    $ make cppcheck
    $ make cpplint

In vim use ':make analyze' to run all possible static analysis targets and
populate its quickfix list with the results. Eclipse's Problem window
can also be populated by changing the build target to 'analyze' and running
a build.

    $ make analyze

The following targets exist that are useful when used with automation
tools such as Jenkins and SonarQube. They generate gtest results in
its own XML format, Valgrind results in its own XML format,
Cobertura compatible XML from gcov data, cppcheck's data to its own XML
format, converts cpplint.py's output to checkstyle compatible XML, and dumps
flexelint to its own XML format.

    $ make check-xml
    $ make gcovr-xml
    $ make cppcheck-xml
    $ make cpplint-xml

The following 'sonar-prepare' is a convenience target that runs all previous
XML targets.

    $ make sonar-prepare

'sonar-incremental' will run sonar-prepare and also generate
an incremental issues HTML report that covers only modified files.
'sonar-preview' will run sonar-prepare and also generate a full issue HTML
report which can be filtered for only new items.

    $ make sonar-prepare
    $ make sonar-incremental
    $ make sonar-preview

Code Coverage can also be generated in HTML format in either a single HTML
page or multiple HTML pages.

    $ make gcovr-html
    $ make gcovr-html-detail
