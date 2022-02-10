import SwiftUI
import SpriteKit

struct Game: View {
    var body: some View {
        SpriteView(scene: .init(fileNamed: "Level1_Scene")!)
            .frame(height: 390)
    }
}
