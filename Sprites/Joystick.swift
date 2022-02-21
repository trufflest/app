import SpriteKit
import Master

final class Joystick: SKSpriteNode, Control {
    weak var touching: UITouch?
    var time = TimeInterval()
    private(set) var state = Walking.none
    let horizontal = CGFloat(95)
    let vertical = CGFloat(45)
    private let _none = SKTexture(imageNamed: "Joystick_none")
    private let _left = SKTexture(imageNamed: "Joystick_left")
    private let _right = SKTexture(imageNamed: "Joystick_right")
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(texture: _none, color: .clear, size: _none.size())
    }
    
    func consume() {
        guard touching == nil else { return }
        state = .none
    }
    
    func begin(touch: UITouch) {
        if touch.location(in: self).x >= 0 {
            state = .right
            run(.setTexture(_right))
        } else {
            state = .left
            run(.setTexture(_left))
        }
    }
    
    func move(touch: UITouch) {
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
    
    func untouch() {
        run(.setTexture(_none))
    }
}
