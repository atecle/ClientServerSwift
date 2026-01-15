// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "ClientServerSwift",
    dependencies: [
         .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.23.1"),
         .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
         .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0")
    ]
)
