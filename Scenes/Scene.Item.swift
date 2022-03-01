import Foundation
import Master

extension Scene {
    enum Item {
        case
        spikes,
        lizards
        
        func load(game: Master.Game, scene: Scene) {
            switch self {
            case .spikes:
                game.load(spikes: scene.childNode(withName: "Spikes")!)
            case .lizards:
                game.load(lizards: scene.childNode(withName: "Lizards")!)
            }
        }
    }
}
