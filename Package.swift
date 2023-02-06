// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "codable-data-manager",
    products: [
        .library(
            name: "CodableDataManager",
            targets: ["CodableDataManager"]
        ),
    ],
    targets: [
        .target(
            name: "CodableDataManager",
            dependencies: []
        ),
        .testTarget(
            name: "CodableDataManagerTests",
            dependencies: ["CodableDataManager"]
        ),
    ]
)
