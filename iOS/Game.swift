import SwiftUI
import SpriteKit

struct Game: View {
    let scene: String
    
    var body: some View {
        SpriteView(scene: .init(fileNamed: scene)!)
            .frame(height: 448)
    }
}
