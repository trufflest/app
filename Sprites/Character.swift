import SpriteKit
import Master

protocol Character: SKSpriteNode {
    var direction: Walking { get set }
    var face: Face { get set }
    var textures: [String : SKTexture] { get }
}

extension Character {
    init() {
        super.init(texture: textures[Face.none.key], color: .clear, size: textures[Face.none.key]!.size())
        anchorPoint = .init(x: 0.5, y: 0)
    }
    
    func update(direction: Walking) {
        self.direction = direction
        switch direction {
        case .left:
            xScale = -1
        case .right:
            xScale = 1
        default:
            break
        }
    }
    
    func update(face: Face) {
        self.face = face
        texture = textures[face.key]
    }
}
