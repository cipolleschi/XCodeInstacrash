// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyApp",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "App",
            targets: ["App", "Dependency"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "App",
            dependencies: ["Dependency"],
            path: "Sources/App",
            publicHeadersPath: ".",
        ),
        .target(
          name: "Dependency",
          dependencies: [],
          path: "Sources/Dependency",
          publicHeadersPath: ".",
        )
    ]
)
