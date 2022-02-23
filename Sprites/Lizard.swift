import SpriteKit
import Master

final class Lizard: SKSpriteNode, Character {
    var direction = Walking.right
    var face = Face.none
    let textures = [Face.none.key : SKTexture(imageNamed: "Lizard_none"),
                    Face.walk1(0).key : SKTexture(imageNamed: "Lizard_walk_1"),
                    Face.walk2(0).key : SKTexture(imageNamed: "Lizard_walk_2")]
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: textures[Face.none.key], color: .clear, size: textures[Face.none.key]!.size())
        anchorPoint = .init(x: 0.5, y: 0)
    }
}
