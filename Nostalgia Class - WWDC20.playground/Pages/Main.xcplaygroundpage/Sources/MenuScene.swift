
import SpriteKit
import Foundation

public class MenuScene: SKScene {
    
    var faceNode: SKSpriteNode?
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = .black
    }
    
    func configTitle() {
        let gameName = createHeading(withText: "NOSTALGIA CLASS", position: CGPoint(x: frame.midX, y: frame.midY + 120))
        
        gameName.run(.repeatForever(.sequence([
            .moveTo(y: frame.midY + 100, duration: 1),
            .moveTo(y: frame.midY + 120, duration: 1),
        ])))
        
        self.addChild(gameName)
    }
    
    func addFaceNode(){
        faceNode = SKSpriteNode(imageNamed: "face")
        faceNode?.size = CGSize(width: 250, height: 250)
        faceNode?.position = CGPoint(x: frame.midX + 100, y: frame.midY + 120)
        self.addChild(faceNode!)
        
    }
    
    func animateFaceNode(){
        faceNode?.run(.repeatForever(.sequence([
            .moveTo(y: frame.midY + 100, duration: 1),
            .moveTo(y: frame.midY + 120, duration: 1),
            
        ])))
    }
    
    func insertButton(){
        var btLabel = SKLabelNode()
        btLabel.fontColor = .white
        btLabel.fontSize = 32
        btLabel.fontName = "8BIT WONDER"
        btLabel.text = "START"
        
        btLabel.run(.repeatForever(.group([
            .wait(forDuration: 0.15),
            changeFontColor
        ])))
        
        let button = SKButtonNode(image: nil, label: btLabel){

            let reveal = SKTransition.reveal(with: .left,
                                             duration: 1)
            
            let newScene = IntroScene(size: CGSize(width: 1024, height: 768))
            
            self.view?.presentScene(newScene,
                                    transition: reveal)
        }
        
        button.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        
        self.addChild(button)
    }
    
    public override func didMove(to view: SKView) {
        basicReset()
        configTitle()
        addFaceNode()
        animateFaceNode()
        insertButton()
        
        self.backgroundColor = bgColor
        self.addChild(insertAudioBackground(name: "free-run"))
    }
    
}
