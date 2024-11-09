// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "More",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "More",
            targets: ["More"]),
    ],
    dependencies: [
        .package(path: "../Coordinator"),
        .package(path: "../Extension"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "More",
            dependencies: [
                "Extension",
                "Coordinator",
                "SnapKit",
                "Then"
            ]
        ),
        .testTarget(
            name: "MoreTests",
            dependencies: ["More"]
        ),
    ]
)
