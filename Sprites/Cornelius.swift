import Foundation
import Master

final class Cornelius: Character {
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(textures: [Face.none.key : .init(imageNamed: "Cornelius_none"),
                              Face.walk1(0).key : .init(imageNamed: "Cornelius_walk_1"),
                              Face.walk2(0).key : .init(imageNamed: "Cornelius_walk_2"),
                              Face.jump.key : .init(imageNamed: "Cornelius_jump"),
                              Face.dead.key : .init(imageNamed: "Cornelius_dead")])
    }
}
