import SwiftUI
import ComposableArchitecture

@main
struct ClientServerSwiftApp: App {

    static let store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: ClientServerSwiftApp.store)
        }
    }
}
