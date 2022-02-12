import SpriteKit
import Combine
import Master

private let cooldown = 0.1

class Scene: SKScene {
    private var state = State.playing
    private var time = TimeInterval()
    private var subs = Set<AnyCancellable>()
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private let jump = Jump()
    private let map = Map()
    
    final override func sceneDidLoad() {
        map.load(ground: childNode(withName: "Ground") as! SKTileMapNode)
        
        addChild(cornelius)
        addChild(joystick)
        addChild(jump)
        
        cornelius.position = map[.cornelius]
        joystick.position = .init(x: 70 + 95, y: 195)

        map
            .move
            .sink { [weak self] in
                self?.cornelius.run(.move(to: $0, duration: cooldown))
            }
            .store(in: &subs)
        
        map
            .face
            .sink { [weak self] in
                self?.cornelius.face = $0
            }
            .store(in: &subs)
        
        map
            .direction
            .sink { [weak self] in
                self?.cornelius.direction = $0
            }
            .store(in: &subs)
        
        map
            .jumping
            .sink { [weak self] in
                self?.jump.consume(jumping: $0)
            }
            .store(in: &subs)
        
        map
            .state
            .sink { [weak self] in
                self?.state = $0
            }
            .store(in: &subs)
    }
    
    final override func didMove(to: SKView) {
        jump.position = .init(x: to.bounds.width - 70 - 60, y: 195)
        to.isMultipleTouchEnabled = true
    }
    
    final override func update(_ currentTime: TimeInterval) {
        guard
            state == .playing,
            currentTime - time > cooldown
        else { return }
        
        time = currentTime
        
        map.update(jumping: jump.state,
                   walking: joystick.state,
                   face: cornelius.face,
                   direction: cornelius.direction)
        
        joystick.consume()
        jump.consume()
    }
    
    final override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.begin(touches: touches)
        jump.begin(touches: touches)
    }
    
    final override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.move(touches: touches)
        jump.move(touches: touches)
    }
    
    final override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.end(touches: touches)
        jump.end(touches: touches)
    }
}
