import SpriteKit
import Combine
import Master

private let cooldown = 0.1

class Scene: SKScene {
    weak var session: Session!
    private var time = TimeInterval()
    private var subs = Set<AnyCancellable>()
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private let jump = Jump()
    private let map = Map()
    private let retry = Retry()
    
    private var state = State.playing {
        didSet {
            switch state {
            case .fell:
                camera!.addChild(retry)
            default:
                break
            }
        }
    }
    
    final override func sceneDidLoad() {
        map.load(ground: childNode(withName: "Ground") as! SKTileMapNode)
        addChild(cornelius)
        
        cornelius.position = map[.cornelius]
        
        let camera = SKCameraNode()
        camera.position.y = 224
        addChild(camera)
        self.camera = camera
        
        camera.addChild(joystick)
        camera.addChild(jump)
        
        map
            .moveX
            .sink { [weak self] in
                self?.cornelius.run(.moveTo(x: $0, duration: cooldown))
            }
            .store(in: &subs)
        
        map
            .moveY
            .sink { [weak self] in
                self?.cornelius.run(.moveTo(y: $0, duration: cooldown))
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
        
        retry
            .activated
            .sink { [weak self] in
                self?.session.retry()
            }
            .store(in: &subs)
    }
    
    final override func didMove(to: SKView) {
        let mid = (to.bounds.width / 2)
        
        jump.position = .init(x: mid - 25 - 60, y: 120)
        joystick.position = .init(x: -mid + 25 + 95, y: 120)
        
        camera!.position = .init(x: to.center.x, y: camera!.position.y)
        camera!.constraints = [.distance(.init(upperLimit: 150), to: cornelius),
                               .positionX(.init(lowerLimit: mid, upperLimit: childNode(withName: "Ground")!.frame.width - mid)),
                               .positionY(.init(constantValue: camera!.position.y))]
        
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
        switch state {
        case .playing:
            joystick.begin(touches: touches)
            jump.begin(touches: touches)
        case .fell, .dead:
            retry.begin(touches: touches)
        }
    }
    
    final override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.move(touches: touches)
            jump.move(touches: touches)
        case .fell, .dead:
            retry.move(touches: touches)
        }
    }
    
    final override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.end(touches: touches)
            jump.end(touches: touches)
        case .fell, .dead:
            retry.end(touches: touches)
        }
    }
}
