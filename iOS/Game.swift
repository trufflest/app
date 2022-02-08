import SwiftUI
import SpriteKit

struct Game: View {
    var body: some View {
        SpriteView(scene: .init(fileNamed: "Level1_Scene")!)
            .edgesIgnoringSafeArea(.all)
    }
}
