import SwiftUI

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
                    
//                    switch Defaults.action {
//                    case .rate:
//                        UIApplication.shared.review()
//                    case .froob:
//                        froob = true
//                    case .none:
//                        break
//                    }
                    
                    _ = await UNUserNotificationCenter.request()
                }
        }
        .onChange(of: phase) {
            switch $0 {
            case .active:
                cloud.pull.send()
            default:
                break
            }
        }
    }
}
