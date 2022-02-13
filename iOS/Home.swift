import SwiftUI

struct Home: View {
    let session: Session
    
    var body: some View {
        VStack {
            Spacer()
            Text("Truffle Forest")
            Button("Play") {
                session.state = .play("Level1_Scene")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}
