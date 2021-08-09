// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ListController",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ListController",
            targets: ["ListController"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ListController",
            dependencies: [],
            path: "Sources",
            exclude: [
                "Example",
                "ListController.podspec",
                "README.md",
                "LICENSE",
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
