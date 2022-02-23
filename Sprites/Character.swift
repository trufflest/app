import SpriteKit
import Master

class Character: SKSpriteNode {
    var direction = Walking.none {
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
            texture = textures[face.key]
        }
    }
    
    private let textures: [String : SKTexture]
    
    required init?(coder: NSCoder) { nil }
    init(textures: [String : SKTexture]) {
        self.textures = textures
        super.init(texture: textures[Face.none.key], color: .clear, size: textures[Face.none.key]!.size())
        anchorPoint = .init(x: 0.5, y: 0)
    }
}
