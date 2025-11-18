// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReRoomyPresentation",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ReRoomyPresentation",
            targets: ["ReRoomyPresentation"]
        ),
    ],
    targets: [
        .target(
            name: "ReRoomyPresentation",
            path: "ReRoomyPresentation"
        ),
        .testTarget(
            name: "ReRoomyPresentationUnitTests",
            dependencies: ["ReRoomyPresentation"],
            path: "ReRoomyPresentationUnitTests"
        ),
    ]
)
