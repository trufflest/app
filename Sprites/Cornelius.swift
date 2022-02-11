import SpriteKit

final class Cornelius: SKSpriteNode {
    var facing = Facing.right {
        didSet {
            switch facing {
            case .left:
                xScale = -1
            case .right:
                xScale = 1
            }
        }
    }
    
    var state = State.walk1 {
        didSet {
            switch state {
            case .walk1:
                run(.setTexture(_walk1))
            case .walk2:
                run(.setTexture(_walk2))
            case .jump:
                run(.setTexture(_jump))
            case .none:
                run(.setTexture(_none))
            }
        }
    }

    private let _none = SKTexture(imageNamed: "Cornelius_none")
    private let _walk1 = SKTexture(imageNamed: "Cornelius_walk_1")
    private let _walk2 = SKTexture(imageNamed: "Cornelius_walk_2")
    private let _jump = SKTexture(imageNamed: "Cornelius_jump")
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: _none)
    }
}
