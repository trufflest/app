import SwiftUI
import AVFoundation
import Master

@main struct App: SwiftUI.App {
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor(Delegate.self) private var delegate
    
    var body: some SwiftUI.Scene {
        WindowGroup {
            Window()
                .preferredColorScheme(.dark)
                .task {
                    cloud.ready.notify(queue: .main) {
                        cloud.pull.send()
                    }
                    
                    if Defaults.rate {
                        UIApplication.shared.review()
                    }
                    
                    _ = await UNUserNotificationCenter.request()
                }
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try? AVAudioSession.sharedInstance().setActive(true)
            default:
                break
            }
        }
    }
}
