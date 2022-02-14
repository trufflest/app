import Foundation

extension Session {
    enum State {
        case
        home,
        play(UUID, String)
    }
}
