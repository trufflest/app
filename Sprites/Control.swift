import SpriteKit

protocol Control: SKSpriteNode {
    var touching: UITouch? { get set }
    var horizontal: CGFloat { get }
    var vertical: CGFloat { get }
    
    func clear()
    func consume()
    func begin(touch: UITouch)
    func move(touch: UITouch)
    func untouch()
}

extension Control {
    func consume() { }
    func move(touch: UITouch) { }
    func untouch() { }
    
    func clear() {
        touching = nil
        untouch()
    }
    
    func begin(touches: Set<UITouch>) {
        guard touching == nil else { return }
        touches
            .first(where: validate(touch:))
            .map {
                touching = $0
                begin(touch: $0)
            }
    }
    
    func move(touches: Set<UITouch>) {
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
    
    func end(touches: Set<UITouch>) {
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
            abs(location.x) < horizontal,
            abs(location.y) < vertical
        else {
            return false
        }
        return true
    }
}
