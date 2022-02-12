import SpriteKit
import Master

final class Jump: SKSpriteNode, Control {
    weak var touching: UITouch?
    private(set) var state = Jumping.none
    let radius = CGFloat(50)
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, color: .clear, size: _off.size())
    }
    
    func consume() {
        guard state != .none && touching == nil else { return }
        state = .none
    }
    
    func consume(jumping: Jumping) {
        state = jumping
    }
    
    func begin(touch: UITouch) {
        guard state == .none else { return }
        state = .start
        run(.setTexture(_on))
    }
    
    func untouch() {
        run(.setTexture(_off))
    }
}
