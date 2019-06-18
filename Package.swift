// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Bitmap",
    products: [
        .library(
            name: "Bitmap",
            targets: ["Bitmap"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Bitmap",
            dependencies: []),
        .testTarget(
            name: "BitmapTests",
            dependencies: ["Bitmap"]),
    ]
)
