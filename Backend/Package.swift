// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "ClientServerSwiftBackend",
    platforms: [
       .macOS(.v13)
    ],
    products: [
        .library(name: "ClientServerSwiftBackendCore", targets: ["ClientServerSwiftBackendCore"]),
        .executable(name: "ClientServerSwiftBackend", targets: ["ClientServerSwiftBackendRun"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0")
    ],
    targets: [
        .target(
            name: "ClientServerSwiftBackendCore",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ],
            path: "Sources/Core",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "ClientServerSwiftBackendCoreTests",
            dependencies: [
                .target(name: "ClientServerSwiftBackendCore"),
                .product(name: "VaporTesting", package: "vapor")
            ],
            path: "Tests",
            swiftSettings: swiftSettings
        ),
        .executableTarget(
            name: "ClientServerSwiftBackendRun",
            dependencies: [
                .target(name: "ClientServerSwiftBackendCore"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio")
            ],
            path: "Sources/Run",
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] {
    [.enableUpcomingFeature("ExistentialAny")]
}
