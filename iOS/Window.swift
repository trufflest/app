import SwiftUI

struct Window: View {
    var body: some View {
        Game()
            .preferredColorScheme(.dark)
            .edgesIgnoringSafeArea(.all)
    }
}
