import SpriteKit

final class Cornelius: SKSpriteNode {
    private let walking1 = SKTexture(imageNamed: "Cornelius_walk_1")
    private let walking2 = SKTexture(imageNamed: "Cornelius_walk_2")
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: walking1)
    }
}
