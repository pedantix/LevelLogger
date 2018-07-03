// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LevelLogger",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LevelLogger",
            targets: ["LevelLogger"]),
    ],
    dependencies: [
      // 💻 APIs for creating interactive CLI tools.
      .package(url: "https://github.com/vapor/console.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "LevelLogger",
            dependencies: ["Console"]),
        .testTarget(
            name: "LevelLoggerTests",
            dependencies: ["LevelLogger"]),
    ]
)
