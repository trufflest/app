import SwiftUI
import SpriteKit

struct Game: View {
    let session: Session
    let scene: Scene
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(height: 448)
            .onAppear {
                scene.session = session
            }
    }
}
