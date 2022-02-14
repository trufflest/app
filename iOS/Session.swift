import Foundation
import SwiftUI

final class Session: ObservableObject {
    @Published private(set) var state = State.home
    
    func play(name: String) {
        withAnimation(.easeInOut(duration: 1)) {
            state = .play(.init(), name)
        }
    }
    
    func retry() {
        if case let .play(_, name) = state {   
            withAnimation(.easeInOut(duration: 0.75)) {
                state = .play(.init(), name)
            }
        }
    }
}
