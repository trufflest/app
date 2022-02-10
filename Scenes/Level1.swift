import SpriteKit

final class Level1: SKScene {
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private let jump = Jump()
    private weak var touch: UITouch?
    
    override func sceneDidLoad() {
        addChild(cornelius)
        addChild(joystick)
        addChild(jump)

        cornelius.position = .init(x: 100, y: 40)
        joystick.position = .init(x: 70 + 95, y: 195)
    }
    
    override func didMove(to: SKView) {
        print(jump.size.width)
        jump.position = .init(x: to.bounds.width - 70 - 60, y: 195)
    }
    
    override func update(_ currentTime: TimeInterval) {
        cornelius.update(joystick: joystick.state, current: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.begin(touches: touches)
        jump.begin(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.move(touches: touches)
        jump.move(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.end(touches: touches)
        jump.end(touches: touches)
    }
}
