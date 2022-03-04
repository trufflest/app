import Foundation

protocol LevelProtocol {
    var title: String { get }
    var comics: [Int] { get }
    var items: [Scene.Item] { get }
}
