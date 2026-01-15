import ProjectDescription

let project = Project(
    name: "ClientServerSwift",
    options: .options(automaticSchemesOptions: .disabled),
    packages: [
        .remote(url: "https://github.com/SimplyDanny/SwiftLintPlugins", requirement: .upToNextMajor(from: "0.62.2"))
    ],
    targets: [
        .target(
            name: "ClientServerSwift",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.ClientServerSwift",
            infoPlist: .default,
            buildableFolders: [
                "Sources",
                "Resources"
            ],
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin)
            ]
        ),
        .target(
            name: "ClientServerSwiftTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.ClientServerSwiftTests",
            infoPlist: .default,
            buildableFolders: [
                "Tests"
            ],
            dependencies: [
                .target(name: "ClientServerSwift"),
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin)
            ]
        )
    ],
    schemes: [
        .scheme(
            name: "ClientServerSwift",
            shared: true,
            buildAction: .buildAction(targets: [
                .target("ClientServerSwift")
            ]),
            testAction: .targets([
                .testableTarget(
                    target: .target(
                        "ClientServerSwiftTests"
                    )
                )]
            ),
            runAction: .runAction(
                configuration: .debug,
                executable: .target("ClientServerSwift")
            )
        )
    ]
)
