// swift-tools-version: 6.2

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
    dependencies: [
        .package(url: "https://github.com/ihormyroniuk/AUIKit.git", revision: "6257125b368b669ff480c13649acff545101aac4"),
        .package(url: "https://github.com/ihormyroniuk/AFoundation.git", revision: "1f8c7f56aa54a0e332cb44d80855c28d299444ba"),
    ],
    targets: [
        .target(
            name: "ReRoomyPresentation",
            dependencies: [
                "AUIKit",
                "AFoundation"
            ],
            path: "ReRoomyPresentation"
        ),
        .testTarget(
            name: "ReRoomyPresentationUnitTests",
            dependencies: ["ReRoomyPresentation"],
            path: "ReRoomyPresentationUnitTests"
        ),
    ]
)
