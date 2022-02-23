import Foundation
import Master
import SpriteKit

final class Cornelius: Character {
    override var textures: [String : SKTexture] {
        tex
    }
    
    private let tex = [Face.none.key : SKTexture(imageNamed: "Cornelius_none"),
                       Face.walk1(0).key : .init(imageNamed: "Cornelius_walk_1"),
                       Face.walk2(0).key : .init(imageNamed: "Cornelius_walk_2"),
                       Face.jump.key : .init(imageNamed: "Cornelius_jump"),
                       Face.dead.key : .init(imageNamed: "Cornelius_dead")]
}
