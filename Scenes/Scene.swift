import SpriteKit
import Combine
import Master

private let cooldown = 0.02

class Scene: SKScene {
    weak var session: Session!
    
    var title: String { "" }
    var items: [Item] { [] }
    
    private var cornelius: Cornelius!
    private var time = TimeInterval()
    private var truffles = UInt16()
    private var subs = Set<AnyCancellable>()
    private let joystick = Joystick()
    private let jump = Jump()
    private let game = Master.Game()
    private let retry = Action(image: "Retry")
    private let exit = Action(image: "Exit")
    private let resume = Action(image: "Resume")
    private let pause = Pause()
    private let counter = SKSpriteNode(imageNamed: "Counter")
    private let titleLabel = SKLabelNode()
    private let finishLabel = SKLabelNode(attributedText: .init(.init("Finished", attributes: .init([
        .font: UIFont.systemFont(ofSize: 30, weight: .medium),
            .foregroundColor: UIColor.blue]))))
    private let counterLabel = SKLabelNode()
    private let shade = SKSpriteNode()
    
    private var state = State.playing {
        didSet {
            guard state != oldValue else { return }
            switch state {
            case .fell:
                [cornelius, jump, joystick, pause]
                    .forEach {
                        $0.run(.fadeOut(withDuration: 1))
                    }
                
                [retry, exit]
                    .forEach {
                        shade.addChild($0)
                    }
                
                camera!.addChild(shade)
                shade.run(.fadeIn(withDuration: 1.5))
            case .dead:
                [cornelius, jump, joystick, pause]
                    .forEach {
                        $0.run(.fadeOut(withDuration: 1.5))
                    }
                
                [retry, exit]
                    .forEach {
                        shade.addChild($0)
                    }
                
                camera!.addChild(shade)
                
                cornelius.run(.moveBy(x: 0, y: 50, duration: 1.5))
                shade.run(.sequence([.wait(forDuration: 1.5), .fadeIn(withDuration: 0.5)]))
            case .finished:
                [jump, joystick, pause]
                    .forEach {
                        $0.run(.fadeOut(withDuration: 1.5))
                    }
                
                [finishLabel]
                    .forEach {
                        shade.addChild($0)
                    }
                
                camera!.addChild(shade)
                
                shade.run(.sequence([.wait(forDuration: 1.5),
                                     .fadeIn(withDuration: 0.5),
                                     .wait(forDuration: 1),
                                     .run { [weak self, truffles] in
                                        self?.session.levelUp(truffles: truffles)
                                    }]))
            case .pause:
                camera!.addChild(shade)
                shade.run(.fadeIn(withDuration: 0.3))
                
                joystick.clear()
                jump.clear()
                
                [jump, joystick, pause]
                    .forEach {
                        $0.run(.fadeOut(withDuration: 1))
                    }
                
                [resume, exit]
                    .forEach {
                        shade.addChild($0)
                    }
            case .playing:
                [jump, joystick, pause]
                    .forEach {
                        $0.run(.fadeIn(withDuration: 0.5))
                    }
                
                shade.run(.sequence([.fadeOut(withDuration: 0.3), .run { [weak self] in
                    [self?.resume, self?.exit, self?.shade]
                        .forEach {
                            $0?.removeFromParent()
                        }
                }]))
            }
        }
    }
    
    final override func sceneDidLoad() {
        retry.position.y = 10
        exit.position.y = -60
        resume.position.y = 10

        titleLabel.position.y = 65
        titleLabel.attributedText = .init(.init(title, attributes: .init([
            .font: UIFont.systemFont(ofSize: 22, weight: .medium),
                .foregroundColor: UIColor.white])))
        
        updateCounter()
        counterLabel.horizontalAlignmentMode = .right
        counterLabel.verticalAlignmentMode = .center
        
        shade.color = .init(white: 0, alpha: 0.75)
        shade.alpha = 0
        shade.addChild(titleLabel)
        
        cornelius = childNode(withName: "Cornelius") as? Cornelius
        game.load(truffles: childNode(withName: "Truffles")!)
        game.load(ground: childNode(withName: "Ground") as! SKTileMapNode)
        game.add(cornelius: cornelius)
        
        items
            .forEach {
                game.load(spikes: childNode(withName: "\($0)")!)
            }
        
        let camera = SKCameraNode()
        camera.position.y = 187.5
        addChild(camera)
        self.camera = camera
        
        camera.addChild(joystick)
        camera.addChild(jump)
        camera.addChild(pause)
        camera.addChild(counter)
        camera.addChild(counterLabel)
        
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
            .sink { [weak self] in
                $0.removeFromParent()
                self?.truffles += 1
                self?.updateCounter()
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
        
        cloud
            .first()
            .sink { [weak self] in
                self?.truffles = $0.truffles
            }
            .store(in: &subs)
    }
    
    final override func didMove(to: SKView) {
        shade.size = to.bounds.size
        let horizontal = to.bounds.width / 2
        let vertical = (to.bounds.height / -2) + 60
        
        jump.position = .init(x: horizontal - 30 - 45, y: vertical)
        joystick.position = .init(x: -horizontal + 30 + 95, y: vertical)
        pause.position = .init(x: 0, y: vertical)
        counter.position = .init(x: horizontal - 30 - 10, y: (to.bounds.height / 2) - 25)
        counterLabel.position = .init(x: counter.position.x - 19, y: counter.position.y)
        
        camera!.position = .init(x: to.center.x, y: camera!.position.y)
        camera!.constraints = [.distance(.init(upperLimit: 150), to: cornelius),
                               .positionX(.init(lowerLimit: horizontal, upperLimit: childNode(withName: "Ground")!.frame.width - horizontal)),
                               .positionY(.init(constantValue: camera!.position.y))]
        
        to.isMultipleTouchEnabled = true
    }
    
    final override func update(_ currentTime: TimeInterval) {
        guard state == .playing else { return }
        
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
        
        if currentTime - time > cooldown {
            time = currentTime
            game.gravity(jumping: jump.state, walking: joystick.state, face: cornelius.face)
            game.contact()
            
            game.foes()
        }
    }
    
    final override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.begin(touches: touches)
            jump.begin(touches: touches)
            pause.begin(touches: touches)
        case .dead, .fell:
            retry.begin(touches: touches)
            exit.begin(touches: touches)
        case .pause:
            resume.begin(touches: touches)
            exit.begin(touches: touches)
        case .finished:
            break
        }
    }
    
    final override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.move(touches: touches)
            jump.move(touches: touches)
            pause.move(touches: touches)
        case .dead, .fell:
            retry.move(touches: touches)
            exit.move(touches: touches)
        case .pause:
            resume.move(touches: touches)
            exit.move(touches: touches)
        case .finished:
            break
        }
    }
    
    final override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        switch state {
        case .playing:
            joystick.end(touches: touches)
            jump.end(touches: touches)
            pause.end(touches: touches)
        case .dead, .fell:
            retry.end(touches: touches)
            exit.end(touches: touches)
        case .pause:
            resume.end(touches: touches)
            exit.end(touches: touches)
        case .finished:
            break
        }
    }
    
    private func updateCounter() {
        counterLabel.attributedText = .init(.init("×\(truffles)", attributes: .init([
            .font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .medium),
                .foregroundColor: UIColor.white])))
    }
}
