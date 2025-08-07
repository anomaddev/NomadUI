// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NomadUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NomadUI",
            targets: ["NomadUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/anomaddev/NomadUtilities.git", branch: "main"),
        .package(url: "https://github.com/yeahdongcn/UIColor-Hex-Swift.git", from: "5.1.0"),
        .package(url: "https://github.com/anomaddev/FAPanels.git", branch: "master"),
        .package(url: "https://github.com/anomaddev/Cartography.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/ninjaprox/NVActivityIndicatorView.git", branch: "master"),
        .package(url: "https://github.com/SwipeCellKit/SwipeCellKit.git", branch: "develop")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NomadUI",
            dependencies: [
                .product(name: "NomadUtilities", package: "NomadUtilities"),
                .product(name: "UIColorHexSwift", package: "UIColor-Hex-Swift"),
                .product(name: "FAPanels", package: "FAPanels"),
                .product(name: "Cartography", package: "Cartography"),
                .product(name: "NVActivityIndicatorView", package: "NVActivityIndicatorView"),
                .product(name: "SwipeCellKit", package: "SwipeCellKit")
            ],
            resources: [.process("Fonts")]
        ),
        .testTarget(
            name: "NomadUITests",
            dependencies: ["NomadUI"]),
    ]
)
