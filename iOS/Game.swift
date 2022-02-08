import SwiftUI
import SpriteKit

struct Game: View {
    var body: some View {
        SpriteView(scene: .init())
            .edgesIgnoringSafeArea(.all)
    }
}
