import SpriteKit

final class Level1: SKScene {
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private weak var touch: UITouch?
    
    override func sceneDidLoad() {
        addChild(cornelius)
        addChild(joystick)
        
        cornelius.position = .init(x: 100, y: 40)
        
        joystick.position = .init(x: 150, y: 195)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.begin(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.move(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.end(touches: touches)
    }
}
