import SwiftUI

struct Home: View {
    let session: Session
    
    var body: some View {
        VStack {
            Spacer()
            Text("Truffle Forest")
            Button("Play") {
                session.play(name: "Level1_Scene")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}
