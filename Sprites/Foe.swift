import SpriteKit
import Master

class Foe: SKSpriteNode {
    var direction = Walking.right {
        didSet {
            switch direction {
            case .left:
                xScale = -1
            case .right:
                xScale = 1
            default:
                break
            }
        }
    }
    
    var face = Face.none {
        didSet {
            switch face {
            case .walk1:
                run(.setTexture(_walk1))
            case .walk2:
                run(.setTexture(_walk2))
            default:
                run(.setTexture(_none))
            }
        }
    }

    var _none: SKTexture!
    var _walk1: SKTexture!
    var _walk2: SKTexture!
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: _none)
        anchorPoint = .init(x: 0.5, y: 0)
    }
}
