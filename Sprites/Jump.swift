import SpriteKit
import Master

final class Jump: SKSpriteNode, Control {
    weak var touching: UITouch?
    var time = TimeInterval()
    var state = 0
    private(set) var active = false
    let horizontal = CGFloat(35)
    let vertical = CGFloat(35)
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, color: .clear, size: _off.size())
    }
    
    func consume() {
        guard touching == nil else { return }
        active = false
        state = 0
    }
    
    func begin(touch: UITouch) {
        active = true
        state = 0
        run(.setTexture(_on))
    }
    
    func untouch() {
        active = false
        state = 0
        run(.setTexture(_off))
    }
}
