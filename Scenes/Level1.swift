import SpriteKit

final class Level1: SKScene {
    private let cornelius = Cornelius()
    
    override func sceneDidLoad() {
        addChild(cornelius)
        cornelius.position = .init(x: 100, y: 68)
    }
}
