import Foundation
import SpriteKit

var textLabel: SKLabelNode?

public func createBallon(text: String, position: CGPoint, fontSize: CGFloat) -> SKLabelNode {
    getFont()
    
    textLabel = SKLabelNode(text: text)
    textLabel?.preferredMaxLayoutWidth = viewSize.width - 100
    textLabel?.numberOfLines = 0
    textLabel?.fontSize = fontSize
    textLabel?.fontName = fontName
    textLabel?.position = position
    
    return textLabel!
}
