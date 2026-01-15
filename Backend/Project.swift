import ProjectDescription

let project = Project(
  name: "ClientServerSwiftBackend",
  options: .options(
    automaticSchemesOptions: .disabled
  ),
  targets: [
    .target(
      name: "ClientServerSwiftBackendCore",
      destinations: [.mac],
      product: .staticLibrary,
      bundleId: "dev.tuist.ClientServerSwiftBackendCore",
      sources: ["Sources/Core/**"],
      dependencies: [
        .external(name: "Vapor"),
        .external(name: "NIOCore"),
        .external(name: "NIOPosix")
      ],
      settings: .settings(
         base: [
           "SWIFT_ENABLE_EXPERIMENTAL_FEATURES": "ExistentialAny"
         ]
       )
    ),
    .target(
      name: "ClientServerSwiftBackendRun",
      destinations: [.mac],
      product: .commandLineTool,
      bundleId: "dev.tuist.ClientServerSwiftBackendRun",
      sources: ["Sources/Run/**"],
      dependencies: [
        .target(name: "ClientServerSwiftBackendCore")
      ]
    ),
    .target(
        name: "ClientServerSwiftBackendCoreTests",
        destinations: [.mac],
        product: .unitTests,
        bundleId: "dev.tuist.ClientServerSwiftBackendCoreTests",
        sources: ["Tests/**"],
        dependencies: [
            .target(name: "ClientServerSwiftBackendCore"),
            .external(name: "VaporTesting")
      ]
    )
  ],
  schemes: [
    .scheme(
        name: "ClientServerSwiftBackend",
        shared: true,
        buildAction: .buildAction(targets: [
            .target("ClientServerSwiftBackendRun")
        ]),
        runAction: .runAction(
            configuration: .debug,
            executable: .target("ClientServerSwiftBackendRun")
        )
    ),
    .scheme(
        name: "ClientServerSwiftBackendCore",
        shared: true,
        buildAction: .buildAction(targets: [
            .target("ClientServerSwiftBackendCore")
        ]),
        testAction: .targets([
            .testableTarget(
                target: .target(
                    "ClientServerSwiftBackendCoreTests"
                )
            )]
        ),
    )
  ]
)
