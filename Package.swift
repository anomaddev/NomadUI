// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NomadUI",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NomadUI",
            targets: ["NomadUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yeahdongcn/UIColor-Hex-Swift.git", from: "5.1.0"),
        .package(url: "https://github.com/anomaddev/FAPanels.git", branch: "master"),
        .package(path: "../NomadUtilities"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NomadUI",
            dependencies: [
                "NomadUtilities",
                .product(name: "UIColorHexSwift", package: "UIColor-Hex-Swift"),
                .product(name: "FAPanels", package: "FAPanels"),
            ]),
        .testTarget(
            name: "NomadUITests",
            dependencies: ["NomadUI"]),
    ]
)
