import SpriteKit
import Master

final class Lizard: Character {
    override var textures: [String : SKTexture] {
        tex
    }
    
    private let tex = [Face.none.key : SKTexture(imageNamed: "Lizard_none"),
                       Face.walk1(0).key : .init(imageNamed: "Lizard_walk_1"),
                       Face.walk2(0).key : .init(imageNamed: "Lizard_walk_2")]
}
