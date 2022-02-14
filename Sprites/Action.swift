import SpriteKit
import Combine

final class Action: SKSpriteNode, Control {
    weak var touching: UITouch?
    let horizontal = CGFloat(80)
    let vertical = CGFloat(26)
    let activated = PassthroughSubject<Void, Never>()

    required init?(coder: NSCoder) { nil }
    init(image: String) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func begin(touch: UITouch) {
        activated.send()
    }
}
