import SwiftUI

struct Window: View {
    @StateObject private var session = Session()
    
    var body: some View {
        switch session.state {
        case .home:
            Home(session: session)
        case let .comic(level):
            Comic(session: session, level: level)
        case let .play(id, level):
            Game(session: session, scene: .init(fileNamed: "Level\(level)")!)
                .id(id)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
