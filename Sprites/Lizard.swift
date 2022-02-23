import Foundation
import Master

final class Lizard: Character {
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(textures: [Face.none.key : .init(imageNamed: "Lizard_none"),
                              Face.walk1(0).key : .init(imageNamed: "Lizard_walk_1"),
                              Face.walk2(0).key : .init(imageNamed: "Lizard_walk_2")])
    }
}
