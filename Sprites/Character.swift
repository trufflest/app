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
    
    var textures: [String : SKTexture] {
        [:]
    }
}
