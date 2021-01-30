// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "TypedTranslations",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(name: "TypedTranslationsCore", targets: ["TypedTranslationsCore"]),
        .executable(name: "TypedTranslations", targets: ["TypedTranslations"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.3.2")),
    ],
    targets: [
        .target(
            name: "TypedTranslations",
            dependencies: ["TypedTranslationsCore"]),
        .target(
            name: "TypedTranslationsCore",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "TypedTranslationsCoreTests",
            dependencies: ["TypedTranslationsCore"]),
    ]
)
