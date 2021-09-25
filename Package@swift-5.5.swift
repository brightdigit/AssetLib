// swift-tools-version:5.5
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
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
    .package(url: "https://github.com/realm/SwiftLint", from: "0.43.0"), // dev
    .package(
      url: "https://github.com/shibapm/Rocket",
      from: "1.2.0"
    ), // dev
    .package(
      url: "https://github.com/brightdigit/swift-test-codecov",
      from: "1.0.0"
    ) // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "AssetLib",
      dependencies: []
    ),
    .executableTarget(
      name: "assetlibrary",
      dependencies: ["AssetLib", .product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
    .testTarget(
      name: "AssetLibTests",
      dependencies: ["AssetLib"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 85

  let config = PackageConfiguration([
    "rocket": [
      "steps": [
        ["hide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
        "hide_dev_dependencies",
        "git_add",
        "commit",
        "tag",
        "unhide_dev_dependencies",
        ["unhide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
        "git_add",
        ["commit": ["message": "Unhide dev dependencies"]]
      ]
    ],
    "komondor": [
      "pre-push": [
        "swift test --enable-code-coverage --enable-test-discovery",
        // swiftlint:disable:next line_length
        "swift run swift-test-codecov .build/debug/codecov/AssetLib.json --minimum \(requiredCoverage)"
      ],
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
