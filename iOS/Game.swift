import SwiftUI
import SpriteKit

struct Game: View {
    let session: Session
    let scene: Scene
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(height: 480)
            .onAppear {
                scene.session = session
            }
    }
}
