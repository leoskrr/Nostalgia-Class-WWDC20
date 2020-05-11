
import Foundation
import SpriteKit

public class IntroScene: SKScene {
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
    }
    
    public override func didMove(to view: SKView) {
        basicReset()
        self.backgroundColor = bgColor
    }
}
