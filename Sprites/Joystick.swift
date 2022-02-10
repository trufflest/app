import SpriteKit

final class Joystick: Control {
    private(set) var state = State.none
    private let _none = SKTexture(imageNamed: "Joystick_none")
    private let _left = SKTexture(imageNamed: "Joystick_left")
    private let _right = SKTexture(imageNamed: "Joystick_right")
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _none, radius: 80)
    }
    
    override func begin(touch: UITouch) {
        if touch.location(in: self).x >= 0 {
            state = .right
            run(.setTexture(_right))
        } else {
            state = .left
            run(.setTexture(_left))
        }
    }
    
    override func move(touch: UITouch) {
        if touch.location(in: self).x >= 0 {
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
    }
    
    override func untouch() {
        state = .none
        run(.setTexture(_none))
    }
}
