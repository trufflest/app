import SwiftUI
import AVFoundation

final class Session: ObservableObject {
    var active = true
    @Published private(set) var state = State.home
    private var audios = Set<AVAudioPlayer>()

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
    
    func play(sound: Sound) {
        Task
            .detached(priority: .background) { [weak self] in
                self?.detachedPlay(sound: sound)
            }
    }
    
    private func detachedPlay(sound: Sound) {
        guard active else { return }
        
        audios = audios
            .filter { !$0.isPlaying }
        
        guard
            let file = Bundle.main.url(forResource: sound.rawValue, withExtension: "aiff"),
            let audio = try? AVAudioPlayer(contentsOf: file)
        else { return }
        
        audios.insert(audio)
        audio.play()
    }
}
