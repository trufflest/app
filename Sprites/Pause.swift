import SpriteKit
import Combine

final class Pause: SKSpriteNode, Control {
    weak var touching: UITouch?
    let horizontal = CGFloat(25)
    let vertical = CGFloat(25)
    let pause = PassthroughSubject<Void, Never>()

    required init?(coder: NSCoder) { nil }
    init() {
        let texture = SKTexture(imageNamed: "Pause")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func begin(touch: UITouch) {
        pause.send()
    }
}
