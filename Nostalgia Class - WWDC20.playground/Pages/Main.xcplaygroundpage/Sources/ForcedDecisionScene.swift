import Foundation
import PlaygroundSupport
import SpriteKit

public var selectedPhrases: [String] = []

public class ForcedDecisionScene: SKScene {
    
    var headerNode: SKLabelNode?
    var subheader: SKLabelNode?
    var index1: Int = 0
    var index2: Int = 0
    var isSecondOptions: Bool = false
    var option1: SKButtonNode?
    var option2: SKButtonNode?
    
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
        subheader?.text = "Choose an option"
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
    
    func createOptions(idx1: Int, idx2: Int){
        
        if isSecondOptions {
            self.option1?.removeFromParent()
            self.option2?.removeFromParent()
        }
        
        option1 = createOptionNode(
            txt: statementOptions[idx1],
            position: CGPoint(x: frame.midX, y: frame.midY + 90),
            color: UIColor(red: 0.53, green: 0.40, blue: 0.28, alpha: 1.00)
        ){
            selectedPhrases.append(statementOptions[idx1])
            if !self.isSecondOptions {
                self.isSecondOptions = true
                self.createOptions(idx1: 2, idx2: 3)
            } else {
                let reveal = SKTransition.reveal(with: .right,duration: 1)
                let newScene = ResultScene(size: viewSize)
                self.view?.presentScene(newScene,transition: reveal)
            }
                
        }
                
        option2 = createOptionNode(
                txt: statementOptions[idx2],
                position: CGPoint(x: frame.midX, y: frame.midY - 160),
                color: UIColor(red: 0.83, green: 0.60, blue: 0.38, alpha: 1.00)

        ){
            selectedPhrases.append(statementOptions[idx2])
            if !self.isSecondOptions {
                self.isSecondOptions = true
                self.createOptions(idx1: 2, idx2: 3)
            } else {
                let reveal = SKTransition.reveal(with: .right,duration: 1)
                let newScene = ResultScene(size: viewSize)
                self.view?.presentScene(newScene,transition: reveal)
            }
        }
        
        self.addChild(option1!)
        self.addChild(option2!)
    }
    
    func renderItems(){
        createLabelNode()
        createSubheader()
        createOptions(idx1: 0, idx2: 1)
        
        let audio = insertAudioBackground(name: "heartbeat.wav")
        self.addChild(audio)

        let devilNode: SKSpriteNode = createFaceNode(
            imageName: "happy",
            point: CGPoint(x: frame.midX - 270, y: frame.maxY/2 + 20)
        )
        
        let angelNode: SKSpriteNode = createFaceNode(
            imageName: "heart",
            point: CGPoint(x: frame.midX - 270, y: frame.midY/2 - 55)
        )
        
        animateFaceNode(node: devilNode)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.animateFaceNode(node: angelNode)
        }
        
        self.addChild(devilNode)
        self.addChild(angelNode)
        
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

public class ResultScene: SKScene {
    
    var player: SKSpriteNode?
    var girlNode: SKSpriteNode?
    var audio: SKAudioNode?
    var specs: SKSpriteNode?

    func createTexts(){
        let text1 = SKLabelNode()
        text1.fontSize = 18
        text1.fontName = fontName
        text1.text = selectedPhrases[0]
        text1.numberOfLines = 0
        text1.preferredMaxLayoutWidth = 250
        text1.alpha = 0
        text1.position = CGPoint(x: -100, y: 120)
        
        
        let text2 = SKLabelNode()
        text2.fontSize = 18
        text2.fontName = fontName
        text2.text = selectedPhrases[1]
        text2.numberOfLines = 0
        text2.preferredMaxLayoutWidth = 250
        text2.position = CGPoint(x: -100, y: 120)
        
        let text3 = SKLabelNode()
        text3.fontSize = 18
        text3.fontName = fontName
        text3.text = "No, I do not."
        text3.numberOfLines = 0
        text3.preferredMaxLayoutWidth = 250
        text3.position = CGPoint(x: 300, y: 120)
        
        text1.run(
            .fadeIn(withDuration: 4)
        )
        
        text2.run(
            .fadeIn(withDuration: 4)
        )
        
        text3.run(
            .fadeIn(withDuration: 4)
        )
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.player?.addChild(text1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8){
            text1.removeFromParent()
            self.player?.addChild(text2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 14){
            text2.removeFromParent()
            
            self.specs?.removeFromParent()
            self.audio?.run(.stop())
            self.player?.addChild(text3)
            
            let theater = Theater(frame: self.frame)
            self.specs = theater.createSpecsNode()
            self.addChild(self.specs!)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 17){
            text3.removeFromParent()
            let reveal = SKTransition.reveal(with: .left,duration: 1)
            let newScene = EndScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
    }
    
    func createGirl(){
        girlNode = SKSpriteNode(texture: SKTexture(imageNamed:"girl-1"))
        
        girlNode?.size = CGSize(width: 250, height: 250)
        girlNode?.position.y = frame.midY - 30
        girlNode?.position.x = frame.midX + 75
        girlNode?.xScale = -1

        self.addChild(girlNode!)
    }
    
    func changePlayerTexture(){
        player = SKSpriteNode(texture: SKTexture(imageNamed:"kneeling"))
        
        player?.size = CGSize(width: 250, height: 250)
        player?.position.y = frame.midY - 35
        player?.position.x = frame.midX - 80

        self.addChild(player!)
        
    }
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    func renderItems(){
        let theater = Theater(frame: frame)
        audio = insertAudioBackground(name: "clap.aiff")
        
        specs = theater.createSpecsNode()
        specs = theater.animateSpecs(specs: specs!)
        
        let floor = theater.createFloorNode()
        
        self.addChild(specs!)
        self.addChild(floor)
        self.addChild(audio!)
        
        self.createGirl()
        self.changePlayerTexture()
        
        createTexts()

    }
    
    public override func didMove(to view: SKView){
        basicReset()
        renderItems()
    }
}
