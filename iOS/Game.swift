import SwiftUI
import SpriteKit

struct Game: View {
    let session: Session
    let scene: Scene
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(maxHeight: 375)
            .onReceive(cloud) {
                session.active = $0.settings.sounds
            }
            .onAppear {
                scene.session = session
            }
    }
}
