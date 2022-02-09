import SpriteKit

final class Joystick: SKSpriteNode {
    private(set) var state = State.none
    private weak var touching: UITouch?
    private let _none = SKTexture(imageNamed: "Joystick_none")
    private let _left = SKTexture(imageNamed: "Joystick_left")
    private let _right = SKTexture(imageNamed: "Joystick_right")
    
    required init?(coder: NSCoder) { nil }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init() {
        super.init(texture: _none)
    }
    
    func begin(touches: Set<UITouch>) {
        guard state == .none else { return }
        touches
            .first(where: validate(touch:))
            .map {
                touching = $0
                if $0.location(in: self).x >= 0 {
                    state = .right
                    run(.setTexture(_right))
                } else {
                    state = .left
                    run(.setTexture(_left))
                }
            }
    }
    
    func move(touches: Set<UITouch>) {
        switch state {
        case .none:
            begin(touches: touches)
        default:
            guard
                let touching = touching,
                touches.contains(touching)
            else { return }
            
            if validate(touch: touching) {
                if touching.location(in: self).x >= 0 {
                    if state != .right {
                        state = .right
                        run(.setTexture(_right))
                    }
                } else {
                    if state != .left {
                        state = .left
                        run(.setTexture(_left))
                    }
                }
            } else {
                self.touching = nil
                state = .none
                run(.setTexture(_none))
            }
        }
    }
    
    func end(touches: Set<UITouch>) {
        guard
            let touching = touching,
            touches.contains(touching)
        else { return }
        self.touching = nil
        state = .none
        run(.setTexture(_none))
    }
    
    private func validate(touch: UITouch) -> Bool {
        let location = touch.location(in: self)
        guard
            abs(location.x) < 80,
            abs(location.y) < 40
        else {
            return false
        }
        return true
    }
}
