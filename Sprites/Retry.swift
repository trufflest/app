import SpriteKit
import Combine

final class Retry: SKSpriteNode, Control {
    weak var touching: UITouch?
    let radius = CGFloat(30)
    let activated = PassthroughSubject<Void, Never>()

    required init?(coder: NSCoder) { nil }
    init() {
        let texture = SKTexture(imageNamed: "Retry")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func begin(touch: UITouch) {
        activated.send()
    }
}
