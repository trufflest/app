import Foundation

extension Level {
    struct Level1: LevelProtocol {
        let title = "The Meadows"
        let comics = (0 ..< 2).map { $0 }
        let items = [Scene.Item.spikes, .lizards]
    }
}
