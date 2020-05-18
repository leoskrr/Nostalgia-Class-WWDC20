import Foundation
import PlaygroundSupport
import SpriteKit

public class EndScene: SKScene {
    
    func basicReset(){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    func formateLabel(text: String, posY: CGFloat, size: CGFloat) -> SKLabelNode{
        let label = SKLabelNode()
        
        label.text = text
        label.position.x = frame.midX
        label.position.y = posY
        label.fontSize = size
        label.fontName = fontName
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = viewSize.width - 100
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        
        return label
    }
    
    func createLabels(){
        getFont()
        
        let timeLabel: SKLabelNode = formateLabel(text: "THE END", posY: frame.midY + 60, size: 48)
        
        
        let txtLabel: SKLabelNode = formateLabel(text: "THANK YOU SO MUCH!", posY: frame.midY + 15, size: 22)
        
        timeLabel.alpha = 0
        txtLabel.alpha = 0
        
        timeLabel.run(
            .fadeIn(withDuration: 4)
        )
        
        txtLabel.run(
            .fadeIn(withDuration: 4)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.addChild(timeLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.addChild(txtLabel)
        }
    }
    
    func renderItems(){
        createLabels()

    }
    
    public override func didMove(to view: SKView){
        basicReset()
        renderItems()
    }
    
}
