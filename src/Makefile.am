# Path to Exernal API header files
AM_CFLAGS = $(WARNING_CFLAGS)
AM_CXXFLAGS = $(WARNING_CXXFLAGS)

PROTOC = protoc
GRPC_CPP_PLUGIN = grpc_cpp_plugin
GRPC_CPP_PLUGIN_PATH ?= `which $(GRPC_CPP_PLUGIN)`
PROTOS_PATH = $(srcdir)

# List of targets to build and install in --bindir
bin_PROGRAMS = greeter_server greeter_client

# List of source files; including headers; used to produce hello executable.
# See automake for how to set compiler/linker flags per application.
greeter_server_SOURCES = greeter_server.cc helloworld.grpc.pb.cc helloworld.pb.cc
greeter_server_CXXFLAGS = $(AM_CXXFLAGS) $(GRPCPP_CFLAGS)
greeter_server_LDADD = $(AM_CXXFLAGS) $(GRPCPP_LIBS)

greeter_client_SOURCES = greeter_client.cc helloworld.grpc.pb.cc helloworld.pb.cc
greeter_client_CXXFLAGS = $(AM_CXXFLAGS) $(GRPCPP_CFLAGS)
greeter_client_LDADD = $(AM_CXXFLAGS) $(GRPCPP_LIBS)

BUILT_SOURCES = helloworld.grpc.pb.h helloworld.pb.h

%.grpc.pb.cc %.grpc.pb.h: %.proto
	$(PROTOC) -I $(PROTOS_PATH) --grpc_out=. --plugin=protoc-gen-grpc=$(GRPC_CPP_PLUGIN_PATH) $<

%.pb.cc %.pb.h: %.proto
	$(PROTOC) -I $(PROTOS_PATH) --cpp_out=. $<

MOSTLYCLEANFILES = *.gcda *.gcno *.pb.cc *.pb.h
