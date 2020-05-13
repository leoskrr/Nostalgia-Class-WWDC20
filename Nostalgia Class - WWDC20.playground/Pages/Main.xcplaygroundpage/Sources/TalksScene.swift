
import SpriteKit
import Foundation

public class TalksScene: SKScene {
    var bg: SKSpriteNode?
    
    func createBg(){
        
    }
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    public override func didMove(to view: SKView) {
        basicReset()
    }
}

