// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ReadableContent",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "ReadableContent", targets: ["ReadableContent"]),
    ],
    targets: [
        .target(name: "ReadableContent"),
        .testTarget(name: "ReadableContentTests", dependencies: ["ReadableContent"]),
    ]
)
