import Foundation

final class Session: ObservableObject {
    @Published var state = State.home
}
