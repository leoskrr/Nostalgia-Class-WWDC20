import Foundation
import PlaygroundSupport
import SpriteKit

public class SpeechDecisionScene: SKScene {
    
    var headerNode: SKLabelNode?
    var subheader: SKLabelNode?
    
    func createFaceNode(imageName: String, point: CGPoint) -> SKSpriteNode{
        let faceNode = SKSpriteNode(imageNamed: imageName)
        
        faceNode.position = point
        faceNode.size = CGSize(width: 120, height: 120)
        
        return faceNode
    }
    
    func animateFaceNode(node: SKSpriteNode){
        
        let duration: Double = 0.5
        
        node.run(.repeatForever(.sequence([
            .moveTo(x: frame.midX - 270, duration: duration),
            .moveTo(x: frame.midX - 250, duration: duration),
        ])))
    }
    
    func createLabelNode(){
        getFont()
        headerNode = SKLabelNode()
        headerNode?.text = "WHAT SHOULD I SAY ?!"
        headerNode?.position = CGPoint(x: frame.midX, y:
            frame.maxY/2 + 125)
        headerNode?.fontName = fontName
        
        self.addChild(headerNode!)
    }
    
    func createSubheader(){
        subheader = SKLabelNode()
        subheader?.text = "Select an option"
        subheader?.position = CGPoint(x: frame.midX, y:
            frame.maxY/2 + 90)
        subheader?.fontName = fontName
        subheader?.fontSize = 20
        
        subheader?.run(.repeatForever(.sequence([
            .fadeAlpha(to: 0, duration: 0.5),
            .fadeAlpha(to: 1, duration: 0.5)
        ])))
        
        self.addChild(subheader!)
    }
    
    func createOptionNode(txt: String, position: CGPoint, color: UIColor, act: @escaping (()-> Void) ) -> SKButtonNode{
        let img = SKSpriteNode(
            color: color,
            size: CGSize(width: viewSize.width - 100, height: 150)
        )
        
        let lbl = SKLabelNode()
        
        lbl.text = txt
        lbl.numberOfLines = 0
        lbl.preferredMaxLayoutWidth = viewSize.width - 120
        lbl.fontName = fontName
        lbl.fontSize = 18
        lbl.verticalAlignmentMode = .center

        let optionNode = SKButtonNode(image: img , label: lbl, action: act)
        optionNode.position = position
        
        return optionNode
    }
    
    func renderItems(){
        createLabelNode()
        createSubheader()
        
        let audio = insertAudioBackground(name: "heartbeat.wav")

        let devilNode: SKSpriteNode = createFaceNode(
            imageName: "face-devil",
            point: CGPoint(x: frame.midX - 270, y: frame.maxY/2 + 20)
        )
        
        let angelNode: SKSpriteNode = createFaceNode(
            imageName: "face-angel",
            point: CGPoint(x: frame.midX - 270, y: frame.midY/2 - 55)
        )
        
        let option1 = createOptionNode(
            txt: speechOptions[0],
            position: CGPoint(x: frame.midX, y: frame.midY + 90),
            color: UIColor(red: 0.53, green: 0.40, blue: 0.28, alpha: 1.00)
        ){
            let reveal = SKTransition.fade(withDuration: 2)

            let newScene = BooScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
        
        let option2 = createOptionNode(
            txt: speechOptions[1],
            position: CGPoint(x: frame.midX, y: frame.midY - 160),
            color: UIColor(red: 0.83, green: 0.60, blue: 0.38, alpha: 1.00)

        ){
            let reveal = SKTransition.fade(withDuration: 2)

            let newScene = ClapScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
        
        animateFaceNode(node: devilNode)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.animateFaceNode(node: angelNode)
        }
        
        self.addChild(devilNode)
        self.addChild(angelNode)
        self.addChild(option1)
        self.addChild(option2)
        self.addChild(audio)
        
    }
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    public override func didMove(to view: SKView){
        basicReset()
        renderItems()
    }
}
