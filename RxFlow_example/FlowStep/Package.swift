// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowStep",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FlowStep",
            targets: ["FlowStep"]),
    ],
    dependencies: [
        .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", from: "2.13.0"),
    ],
    targets: [
        .target(
            name: "FlowStep",
            dependencies: [
                "RxFlow"
            ]
        ),
        .testTarget(
            name: "FlowStepTests",
            dependencies: ["FlowStep"]
        ),
    ]
)
