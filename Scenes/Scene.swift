import SpriteKit

private let tile = 32.0
private let cooldown = 0.1

class Scene: SKScene {
    private var time = TimeInterval()
    private var ground: SKTileMapNode!
    private let cornelius = Cornelius()
    private let joystick = Joystick()
    private let jump = Jump()

    final override func sceneDidLoad() {
        ground = childNode(withName: "Ground") as? SKTileMapNode
        
        addChild(cornelius)
        addChild(joystick)
        addChild(jump)
    
        cornelius.position = .init(x: 100, y: 0)
        joystick.position = .init(x: 70 + 95, y: 195)
    }
    
    final override func didMove(to: SKView) {
        jump.position = .init(x: to.bounds.width - 70 - 60, y: 195)
        to.isMultipleTouchEnabled = true
    }
    
    final override func update(_ currentTime: TimeInterval) {
        guard currentTime - time > cooldown else { return }
        time = currentTime
        
        let x = Int(cornelius.position.x / tile)
        let y = Int(cornelius.position.y / tile)
        
        update(x: x, y: y)
        updateActions(x: x, y: y)
    }
    
    final override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.begin(touches: touches)
        jump.begin(touches: touches)
    }
    
    final override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.move(touches: touches)
        jump.move(touches: touches)
    }
    
    final override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        joystick.end(touches: touches)
        jump.end(touches: touches)
    }
    
    private func update(x: Int, y: Int) {
        if ground.tileDefinition(atColumn: x, row: y) == nil {
            if jump.state == 0 || jump.state == 4 {
                print("state \(jump.state), y: \(y), pos: \(cornelius.position.y)")
                cornelius.run(.moveBy(x: 0, y: -tile, duration: cooldown))
                
                if cornelius.position.y - tile < 20 {
                    self.isPaused = true
                }
            }
        } else if jump.state == 0 && joystick.state == .none && cornelius.state != .none {
            cornelius.state = .none
        }
    }
    
    private func updateActions(x: Int, y: Int) {
        switch jump.state {
        case 4:
            if ground.tileDefinition(atColumn: x, row: y) != nil {
                cornelius.state = .jump
                cornelius.run(.moveBy(x: 0, y: tile, duration: cooldown))
                jump.consume()
            } else {
                jump.clear()
            }
        case 0:
            jump.clear()
        default:
            if ground.tileDefinition(atColumn: x, row: y + 1) == nil {
                cornelius.run(.moveBy(x: 0, y: tile, duration: cooldown))
                jump.consume()
            } else {
                jump.clear()
            }
        }
        
        switch joystick.state {
        case .left:
            switch cornelius.state {
            case .walk1:
                cornelius.state = .walk2
            case .walk2, .none:
                cornelius.state = .walk1
            default:
                break
            }
            
            if cornelius.facing == .right {
                cornelius.facing = .left
            }
            
            if x > 1 && ground.tileDefinition(atColumn: x - 1, row: y + 1) == nil {
                cornelius.run(.moveBy(x: -tile, y: 0, duration: cooldown))
            }
        case .right:
            switch cornelius.state {
            case .walk1:
                cornelius.state = .walk2
            case .walk2, .none:
                cornelius.state = .walk1
            default:
                break
            }
            
            if cornelius.facing == .left {
                cornelius.facing = .right
            }
            
            cornelius.run(.moveBy(x: tile, y: 0, duration: cooldown))
        case .none:
            break
        }
        
        joystick.consume()
    }
}
