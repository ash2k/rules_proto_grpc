load("//scala:scala_proto_compile.bzl", "scala_proto_compile")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")

def scala_proto_library(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    scala_proto_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )

    # Create scala library
    scala_library(
        name = kwargs.get("name"),
        srcs = [name_pb],
        deps = PROTO_DEPS,
        exports = PROTO_DEPS,
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

PROTO_DEPS = [
    "@io_bazel_rules_scala//scala_proto:default_scalapb_compile_dependencies",
]
