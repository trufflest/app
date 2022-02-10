import SpriteKit

private let cooldown = 0.2

final class Cornelius: SKSpriteNode {
    private var facing = Facing.right
    private var state = State.walk1
    private var time = TimeInterval()
    private let _none = SKTexture(imageNamed: "Cornelius_none")
    private let _walk1 = SKTexture(imageNamed: "Cornelius_walk_1")
    private let _walk2 = SKTexture(imageNamed: "Cornelius_walk_2")
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: _none)
        anchorPoint = .init(x: 0.5, y: 0)
    }
    
    func update(joystick: Joystick.State, current: TimeInterval) {
        guard current - time > cooldown else { return }
        switch joystick {
        case .left:
            switch state {
            case .walk1:
                state = .walk2
                run(.setTexture(_walk2))
            default:
                state = .walk1
                run(.setTexture(_walk1))
            }
            
            if facing == .right {
                xScale = -1
                facing = .left
            }
            
            run(.moveBy(x: -32, y: 0, duration: cooldown))
            time = current
        case .right:
            switch state {
            case .walk1:
                state = .walk2
                run(.setTexture(_walk2))
            default:
                state = .walk1
                run(.setTexture(_walk1))
            }
            
            if facing == .left {
                xScale = 1
                facing = .right
            }
            
            run(.moveBy(x: 32, y: 0, duration: cooldown))
            time = current
        case .none:
            if state != .none {
                state = .none
                run(.setTexture(_none))
            }
        }
    }
}
