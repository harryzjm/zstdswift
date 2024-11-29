// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZstdSwift",
    platforms: [.macOS(.v10_14), .iOS(.v13)],
    products: [
        .library(name: "ZstdSwift", targets: [ "ZstdSwift" ])
    ],
    dependencies: [
        .package(url: "https://github.com/facebook/zstd.git", .upToNextMajor(from: "1.5.6")),
    ],
    targets: [
        .target(name: "ZstdSwift", path: "source")
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)