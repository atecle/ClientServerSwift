import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var apiResponse: String?
    }

    enum Action {
        case contentViewDidAppear
        case setAPIResponse(String)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .contentViewDidAppear:
                return .run { send in
                    let request = URLRequest(
                        url: URL(
                            string: "http://localhost:8080/hello"
                        )!
                    )
                    let (data, response) = try await URLSession.shared.data(for: request)

                    guard let string = String(data: data, encoding: .utf8) else {
                        throw URLError(.cannotDecodeContentData)
                    }

                    await send(.setAPIResponse(string))
                } catch: { error, _ in
                    print("Got an error: \(error)")
                }

            case let .setAPIResponse(response):
                state.apiResponse = response
                return .none
            }
        }
    }
}

struct ContentView: View {

    private let store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    public var body: some View {
        switch store.state.apiResponse {
        case .none:
            ProgressView()
                .onAppear {
                    store.send(.contentViewDidAppear)
                }
        case let .some(text):
            Text(text)
                .padding()
        }
    }
}

#Preview {
  ContentView(
    store: Store(initialState: AppFeature.State()) {
      AppFeature()
    }
  )
}
