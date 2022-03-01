import Foundation
import SwiftUI

final class Session: ObservableObject {
    @Published private(set) var state = State.home
    
    func play(level: UInt8) {
        withAnimation(.easeInOut(duration: 1)) {
            state = .play(.init(), "Level\(level)_Scene")
        }
    }
    
    func levelUp(truffles: UInt16) {
        Task {
            await cloud.levelup()
            await cloud.update(truffles: truffles)
        }
        
        withAnimation(.easeInOut(duration: 1)) {
            state = .home
        }
    }
    
    func retry() {
        if case let .play(_, name) = state {   
            withAnimation(.easeInOut(duration: 0.75)) {
                state = .play(.init(), name)
            }
        }
    }
    
    func exit() {
        withAnimation(.easeInOut(duration: 0.75)) {
            state = .home
        }
    }
}
