// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GraphConverter",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "GraphConverter", targets: ["GraphConverter"]),
        .library(name: "GraphVizAdaptor", targets: ["GraphVizAdaptor"]),
        .library(name: "GraphModel", targets: ["GraphModel"]),

    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/SwiftDocOrg/GraphViz.git", from: "0.4.1"),
    ],
    targets: [
        .executableTarget(
            name: "GraphConverter",
            dependencies: [
                "GraphVizAdaptor",
                "GraphModel",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "GraphVizAdaptor",
            dependencies: [
                .product(name: "GraphViz", package: "GraphViz"),
            ]
        ),
        .target(name: "GraphModel"),
        .testTarget(
            name: "GraphConverterTests",
            dependencies: ["GraphConverter"],
            resources: [.process("Resources")]
        ),
    ]
)
