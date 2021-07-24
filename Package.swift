// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Blobmorphism",
    platforms: [.iOS(.v14), .macCatalyst(.v14), .macOS(.v11), .tvOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Blobmorphism",
            targets: ["Blobmorphism"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/twostraws/VisualEffects.git",
            from: "1.0.3"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Blobmorphism",
            dependencies: ["VisualEffects"]),
        .testTarget(
            name: "BlobmorphismTests",
            dependencies: ["Blobmorphism"]),
    ]
)
