import SwiftUI

struct Window: View {
    @StateObject private var session = Session()
    
    var body: some View {
        switch session.state {
        case .home:
            Home(session: session)
        case let .play(id, play):
            Game(session: session, scene: .init(fileNamed: play)!)
                .id(id)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
