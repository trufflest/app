import SpriteKit

final class Jump: SKSpriteNode, Control {
    weak var touching: UITouch?
    let radius = CGFloat(50)
    private(set) var state = false
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, color: .clear, size: _off.size())
    }
    
    func begin(touch: UITouch) {
        state = true
        run(.setTexture(_on))
    }
    
    func untouch() {
        state = false
        run(.setTexture(_off))
    }
}
