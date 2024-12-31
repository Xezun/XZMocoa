// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XZMocoa",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "XZMocoa",
            targets: ["XZMocoa"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "XZDefines", url: "https://github.com/Xezun/XZDefines.git", from: "2.0.0"),
        .package(name: "XZExtensions", url: "https://github.com/Xezun/XZExtensions.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "XZMocoa",
            dependencies: ["XZDefines", "XZExtensions"],
            path: "XZMocoa",
            sources: ["Code"],
            publicHeadersPath: "Headers/Public",
            cSettings: [
                .headerSearchPath("Headers/Private")
            ],
            cxxSettings: [
                .define("XZ_FRAMEWORK")
            ]
        )
    ]
)
