// swift-tools-version: 5.10

import PackageDescription

internal let package = Package(
    name: "app-support",
    products: [
        .library(
            name: "AppSupport",
            targets: ["AppSupport"]
        )
    ],
    targets: [
        .target(
            name: "AppSupport"
        )
    ]
)
