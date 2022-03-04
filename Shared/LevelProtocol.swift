import Foundation

protocol LevelProtocol {
    var title: String { get }
    var items: [Scene.Item] { get }
    var comics: [Level.Comic] { get }
}
