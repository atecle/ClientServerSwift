# ClientServerSwift

An experiment in building an iOS app + Vapor server in a monorepo using modern tooling.

The goal of this project was just to sketch out architecture/tooling for an app written in Swift on frontend and backend.

## Running

Assuming you have tuist installed and an environent set up for iOS development, this should work:

1. Run `tuist install && tuist generate` to install dependencies and generate the `.xcworkspace`
2. Open `ClientServerSwift-Generated.xcworkspace`
3. Run `ClientServerSwiftBackend` to run the server. It should start on `localhost:3000`
4. Run `ClientServerSwift` to run the app. You should see some text that says `Hello from the server!`

## High-level arch

```
ClientServerSwift/
├── App/
├── Backend/
```

This repo is a monorepo, meaning the iOS app and backend live in the same directory. The iOS app and the backend are built/tested/deployed independently.

The entire workspace is managed with [tuist](https://tuist.dev) - so the targets are all defined in a Swift DSL that in turn generate the `xcworkspace` that you'd work on.

## Backend

The backend lives under `Backend/` and is supposed to work without Tuist as a regular-degular Swift package. It could be developed with the Tuist generated project, but I thought it made sense that if I was deploying a Swift server with Docker to not depend on Tuist. So you can just rely on SwiftPM for deployment/CI tasks - e.g. `swift build`, `swift test`.

### Backend module layout

The backend is split into three targets, `*Core`, `*Run`, `*Tests`:

```
Backend/
├── Sources/
│ ├── Core/
│ └── Run/
├── Tests/
└── Package.swift
```

### `ClientServerSwiftBackendCore`

- A pure Swift library module
- Contains application logic and no process level concerns
- This is the module imported by tests

### `ClientServerSwiftBackendRun`

- A minimal executable target
- Creates a Vapor `Application`
- Calls into `ClientServerSwiftBackendCore.configure(...)`
- Starts the server

This is the binary that Docker would run.

### Backend tests

- `ClientServerSwiftBackendCoreTests`
- Tests import only the core library

## Client

There's really not much going on iOS app-side - it's a simple demo that uses [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) to build a screen that makes an API call and renders the response.
