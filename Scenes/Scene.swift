import SpriteKit
import Combine
import Master

private let cooldown = 0.02

class Scene: SKScene {
    weak var session: Session!
    private var time = TimeInterval()
    private var subs = Set<AnyCancellable>()
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private let jump = Jump()
    private let game = Master.Game()
    private let retry = Action(image: "Retry")
    private let exit = Action(image: "Exit")
    private let resume = Action(image: "Resume")
    private let pause = Pause()
    
    private var state = State.playing {
        didSet {
            switch state {
            case .dead:
                camera!.addChild(retry)
                camera!.addChild(exit)
                cornelius.run(.fadeOut(withDuration: 1))
                retry.run(.fadeIn(withDuration: 1))
                exit.run(.fadeIn(withDuration: 1))
            case .pause:
                joystick.clear()
                jump.clear()
                
                camera!.addChild(resume)
                camera!.addChild(exit)
                resume.run(.fadeIn(withDuration: 0.3))
                exit.run(.fadeIn(withDuration: 0.3))
            case .playing:
                resume.removeFromParent()
                exit.removeFromParent()
                resume.alpha = 0
                exit.alpha = 0
                break
            }
        }
    }
    
    final override func sceneDidLoad() {
        retry.position.y = 40
        exit.position.y = -40
        resume.position.y = 40
        retry.alpha = 0
        exit.alpha = 0
        resume.alpha = 0
        
        game.load(truffles: childNode(withName: "Truffles")!)
        game.load(ground: childNode(withName: "Ground") as! SKTileMapNode)
        addChild(cornelius)
        
        cornelius.position = game.items[.cornelius]!
        
        let camera = SKCameraNode()
        camera.position.y = 224
        addChild(camera)
        self.camera = camera
        
        camera.addChild(joystick)
        camera.addChild(jump)
        camera.addChild(pause)
        
        game
            .moveX
            .sink { [weak self] in
                self?.cornelius.position.x = $0
            }
            .store(in: &subs)
        
        game
            .moveY
            .sink { [weak self] in
                self?.cornelius.position.y = $0
            }
            .store(in: &subs)
        
        game
            .face
            .sink { [weak self] in
                self?.cornelius.face = $0
            }
            .store(in: &subs)
        
        game
            .direction
            .sink { [weak self] in
                self?.cornelius.direction = $0
            }
            .store(in: &subs)
        
        game
            .jumping
            .sink { [weak self] in
                self?.jump.state = $0
            }
            .store(in: &subs)
        
        game
            .state
            .sink { [weak self] in
                self?.state = $0
            }
            .store(in: &subs)
        
        game
            .truffle
            .sink {
                $0.removeFromParent()
            }
            .store(in: &subs)
        
        retry
            .activated
            .sink { [weak self] in
                self?.session.retry()
            }
            .store(in: &subs)
        
        exit
            .activated
            .sink { [weak self] in
                self?.session.exit()
            }
            .store(in: &subs)
        
        resume
            .activated
            .sink { [weak self] in
                self?.state = .playing
            }
            .store(in: &subs)
        
        pause
            .pause
            .sink { [weak self] in
                self?.state = .pause
            }
            .store(in: &subs)
    }
    
    final override func didMove(to: SKView) {
        let horizontal = to.bounds.width / 2
        let vertical = (to.bounds.height / -2) + 105
        
        jump.position = .init(x: horizontal - 30 - 45, y: vertical)
        joystick.position = .init(x: -horizontal + 30 + 85, y: vertical)
        pause.position = .init(x: 0, y: vertical)
        
        camera!.position = .init(x: to.center.x, y: camera!.position.y)
        camera!.constraints = [.distance(.init(upperLimit: 150), to: cornelius),
                               .positionX(.init(lowerLimit: horizontal, upperLimit: childNode(withName: "Ground")!.frame.width - horizontal)),
                               .positionY(.init(constantValue: camera!.position.y))]
        
        to.isMultipleTouchEnabled = true
    }
    
    final override func update(_ currentTime: TimeInterval) {
        guard state == .playing else { return }
        
        if currentTime - time > cooldown {
            time = currentTime
            game.contact()
            game.gravity(jumping: jump.state, walking: joystick.state, face: cornelius.face)
        }
        
        if currentTime - jump.time > cooldown, jump.active {
            jump.time = currentTime
            game.jump(jumping: jump.state, face: cornelius.face)
        }
        
        if currentTime - joystick.time > cooldown, joystick.state != .none {
            joystick.time = currentTime
            game.walk(walking: joystick.state, face: cornelius.face, direction: cornelius.direction)
        }
    
        joystick.consume()
        jump.consume()
    }
    
    final override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.begin(touches: touches)
            jump.begin(touches: touches)
            pause.begin(touches: touches)
        case .dead:
            retry.begin(touches: touches)
            exit.begin(touches: touches)
        case .pause:
            resume.begin(touches: touches)
            exit.begin(touches: touches)
        }
    }
    
    final override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.move(touches: touches)
            jump.move(touches: touches)
            pause.move(touches: touches)
        case .dead:
            retry.move(touches: touches)
            exit.move(touches: touches)
        case .pause:
            resume.move(touches: touches)
            exit.move(touches: touches)
        }
    }
    
    final override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.end(touches: touches)
            jump.end(touches: touches)
            pause.end(touches: touches)
        case .dead:
            retry.end(touches: touches)
            exit.end(touches: touches)
        case .pause:
            resume.end(touches: touches)
            exit.end(touches: touches)
        }
    }
}
