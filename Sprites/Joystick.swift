import SpriteKit

final class Joystick: SKSpriteNode {
    private let none = SKTexture(imageNamed: "Joystick_none")
    private let left = SKTexture(imageNamed: "Joystick_none")
    private let right = SKTexture(imageNamed: "Joystick_right")
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: none)
        anchorPoint = .init(x: 0.5, y: 0)
    }
}
