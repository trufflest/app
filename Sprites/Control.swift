import SpriteKit

class Control: SKSpriteNode {
    private weak var touching: UITouch?
    private let radius: CGFloat
    
    required init?(coder: NSCoder) { nil }
    init(texture: SKTexture, radius: CGFloat) {
        self.radius = radius
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    func begin(touch: UITouch) {
        
    }
    
    func move(touch: UITouch) {
        
    }
    
    func untouch() {
        
    }
    
    final func begin(touches: Set<UITouch>) {
        guard touching == nil else { return }
        touches
            .first(where: validate(touch:))
            .map {
                touching = $0
                begin(touch: $0)
            }
    }
    
    final func move(touches: Set<UITouch>) {
        if let touching = touching, touches.contains(touching) {
            if validate(touch: touching) {
                move(touch: touching)
            } else {
                self.touching = nil
                untouch()
            }
        } else {
            begin(touches: touches)
        }
    }
    
    final func end(touches: Set<UITouch>) {
        guard
            let touching = touching,
            touches.contains(touching)
        else { return }
        self.touching = nil
        untouch()
    }
    
    private func validate(touch: UITouch) -> Bool {
        let location = touch.location(in: self)
        guard
            abs(location.x) < radius,
            abs(location.y) < 40
        else {
            return false
        }
        return true
    }
}
