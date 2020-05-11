import SpriteKit

let colors: [CGColor] = [
    CGColor.init(srgbRed: 1, green: 0, blue: 0, alpha: 0.7),
    CGColor.init(srgbRed: 0, green: 1, blue: 0, alpha: 0.7),
    CGColor.init(srgbRed: 0, green: 0, blue: 1, alpha: 0.7),
    CGColor.init(srgbRed: 1, green: 1, blue: 1, alpha: 0.7)
]

public let changeFontColor = SKAction.customAction(withDuration: 0) {
    node, elapsedTime in
    if let node = node as? SKLabelNode {
        node.fontColor = UIColor(cgColor: colors[Int.random(in: 0..<colors.count)])
    }
}
    
