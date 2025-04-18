// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyApp",
    products: [
        .executable(
            name: "App",
            targets: ["App", "Dependency"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: ["Dependency"],
            path: "Sources/App",
            publicHeadersPath: ".",
        ),
        .target(
          name: "Dependency",
          dependencies: [],
          path: "Sources/DependencyHL",
          publicHeadersPath: ".",
        )
    ]
)
