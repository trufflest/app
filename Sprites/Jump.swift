import SpriteKit

final class Jump: Control {
    private(set) var state = false
    private let _off = SKTexture(imageNamed: "Jump_off")
    private let _on = SKTexture(imageNamed: "Jump_on")

    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _off, radius: 50)
    }
    
    override func begin(touch: UITouch) {
        state = true
        run(.setTexture(_on))
    }
    
    override func untouch() {
        state = false
        run(.setTexture(_off))
    }
}
