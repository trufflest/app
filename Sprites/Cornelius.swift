import SpriteKit
import Master

final class Cornelius: SKSpriteNode, Character {
    var direction = Walking.right
    var face = Face.none
    let textures = [Face.none.key : SKTexture(imageNamed: "Cornelius_none"),
                    Face.walk1(0).key : SKTexture(imageNamed: "Cornelius_walk_1"),
                    Face.walk2(0).key : SKTexture(imageNamed: "Cornelius_walk_2"),
                    Face.jump.key : SKTexture(imageNamed: "Cornelius_jump"),
                    Face.dead.key : SKTexture(imageNamed: "Cornelius_dead")]
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: textures[Face.none.key], color: .clear, size: textures[Face.none.key]!.size())
        anchorPoint = .init(x: 0.5, y: 0)
    }
}
