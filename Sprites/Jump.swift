import SpriteKit
import Master

final class Jump: SKSpriteNode, Control {
    weak var touching: UITouch?
    var time = TimeInterval()
    var state = Jumping.ready
    private(set) var active = false
    let horizontal = CGFloat(40)
    let vertical = CGFloat(40)
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, color: .clear, size: _off.size())
    }
    
    func consume() {
        guard touching == nil || state == .over else { return }
        untouch()
    }
    
    func begin(touch: UITouch) {
        active = true
        state = .ready
        run(.setTexture(_on))
    }
    
    func untouch() {
        active = false
        state = .over
        run(.setTexture(_off))
    }
}
