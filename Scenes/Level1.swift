import SpriteKit

final class Level1: Scene {
    override var title: String { "The Meadows" }
    override var items: [Scene.Item] { [.spikes, .lizards] }
}
