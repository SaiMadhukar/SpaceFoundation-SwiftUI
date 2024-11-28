// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SpaceFoundation",
    platforms: [
        .iOS(.v16)
    ], products: [
        .library(
            name: "SpaceFoundation",
            targets: ["SpaceFoundation"]),
    ],
    targets: [
        .target(
            name: "SpaceFoundation"),
        .testTarget(
            name: "SpaceFoundationTests",
            dependencies: ["SpaceFoundation"]
        )
    ]
)
