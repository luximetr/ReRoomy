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
    ],
    targets: [
        .target(
            name: "ReRoomyPresentation",
            dependencies: [
                "AUIKit"
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
