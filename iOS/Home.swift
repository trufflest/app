import SwiftUI

struct Home: View {
    let session: Session
    
    var body: some View {
        VStack {
            Spacer()
            Text("Truffle Forest")
            Button {
                session.play(name: "Level1_Scene")
            } label: {
                Text("Play")
                    .font(.headline)
                    .frame(width: 120, height: 32)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
            Spacer()
        }
    }
}
