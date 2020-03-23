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
    .package(url: "https://github.com/apple/swift-argument-parser", .exact("0.0.1"))
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
