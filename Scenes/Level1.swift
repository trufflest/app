import SpriteKit

final class Level1: SKScene {
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    
    override func sceneDidLoad() {
        addChild(cornelius)
        addChild(joystick)
        
        cornelius.position = .init(x: 100, y: 40)
        
        joystick.position = .init(x: 120, y: 150)
        
        print(self.size.height)
    }
}
