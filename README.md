# Tiki iOS Rules For Bazel

The rules for Bazel that can be used to bundle iOS applications at Tiki.

## Prerequisites

Install with [homebrew](https://brew.sh).

```bash
brew install bazel go
```

## Usage

There are three available environments: develop, staging, production.

### Command line

```bash
# Build the develop target
# Or: make build develop
bazel build //config:develop
```

## License

[WTFPL](http://www.wtfpl.net)