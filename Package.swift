// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AssetLib",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "AssetLib",
      targets: ["AssetLib"]
    ),
    .executable(name: "assetlibrary", targets: ["assetlibrary"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
    .package(url: "https://github.com/shibapm/Komondor", from: "1.0.6"), // dev
    .package(url: "https://github.com/eneko/SourceDocs", from: "1.2.1"), // dev
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
    .package(url: "https://github.com/realm/SwiftLint", from: "0.43.0"), // dev
    .package(
      url: "https://github.com/brightdigit/Rocket",
      .branch("feature/yams-4.0.0")
    ), // dev
    .package(
      url: "https://github.com/mattpolzin/swift-test-codecov",
      .branch("master")
    ) // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "AssetLib",
      dependencies: []
    ),
    .target(
      name: "assetlibrary",
      dependencies: ["AssetLib", .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .testTarget(
      name: "AssetLibTests",
      dependencies: ["AssetLib"]
    )
  ]
)
