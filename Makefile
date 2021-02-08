# develop | staging | production
environment = develop

build:
	bazel build //config:$(environment)