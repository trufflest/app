import Foundation

extension Session {
    enum State {
        case
        home,
        comic(UInt8),
        play(UUID, UInt8)
    }
}
