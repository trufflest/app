import SpriteKit

final class Jump: SKSpriteNode, Control {
    weak var touching: UITouch?
    private(set) var state = 0
    let radius = CGFloat(50)
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, color: .clear, size: _off.size())
    }
    
    func clear() {
        state = touching == nil ? 0 : 4
    }
    
    func consume() {
        state = touching == nil ? 0 : max(0, state - 1)
    }
    
    func begin(touch: UITouch) {
        guard state == 0 else { return }
        state = 4
        run(.setTexture(_on))
    }
    
    func untouch() {
        run(.setTexture(_off))
    }
}
