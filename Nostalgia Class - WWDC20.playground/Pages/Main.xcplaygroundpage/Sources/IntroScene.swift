import SpriteKit
import Foundation

public class IntroScene: SKScene {
    
    var busNode: SKSpriteNode?
    var playerNode: SKSpriteNode?
    var sunNode: SKSpriteNode?
    var cloudsNode: SKSpriteNode?
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    func createSunNode(){
        sunNode = SKSpriteNode(imageNamed: "sun-0")
        sunNode?.size = CGSize(width: 240, height: 240)
        sunNode?.position = CGPoint(x: frame.minX/2 - 100, y: frame.maxY/2 + 100)
        
        self.addChild(sunNode!)
    }
    
    func createCloudsNode(){
        cloudsNode = SKSpriteNode(imageNamed: "clouds-0")
        cloudsNode?.size = CGSize(width: 300, height: 300)
        cloudsNode?.position = CGPoint(x: frame.minX/2 + 150, y: frame.maxY/2 + 90)
        
        self.addChild(cloudsNode!)
    }
    
    func animateStatic(node: SKSpriteNode, spriteSheet: [SKTexture]){
        node.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.5)))
    }
    
    func createStreetNode() {
        let streetNode = SKSpriteNode(color: UIColor(red: 0.09, green: 0.04, blue: 0.03, alpha: 1.00), size: CGSize(width: frame.width, height: 100))
        
        streetNode.position = CGPoint(x: frame.midX, y: frame.minY + 50)
        
        self.addChild(streetNode)
    }
    
    func createBusNode() {
        busNode = SKSpriteNode(imageNamed: "bus-0")
        busNode?.position = CGPoint(x: frame.midX/4 - 350, y: frame.minY + 165)
        busNode?.size = CGSize(width: 400, height: 400)
        
        self.addChild(busNode!)
    }
    
    func animateBusNode(toX x: CGFloat, duration: Double) {
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "bus-0"),
            SKTexture(imageNamed: "bus-1")
        ]
        
        busNode?.run(.group([
            .moveTo(x: x, duration: duration),
            .repeat(.animate(with: spriteSheet, timePerFrame: 0.2), count: 8)
        ]))
    }
    
    func createPlayerNode() {
        playerNode = SKSpriteNode(imageNamed: "myself-0")
        playerNode?.position = CGPoint(x: 37, y: frame.minY + 140)
        playerNode?.size = CGSize(width: 190, height: 190)
        
        self.addChild(playerNode!)
    }
    
    func animatePlayerNode(){
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "myself-0"),
            SKTexture(imageNamed: "myself-1")
        ]
        
        playerNode?.run(.group([
            .moveTo(x: 700, duration: 4),
            .repeat(.animate(with: spriteSheet, timePerFrame: 0.2), count: 9)
        ]))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.changeScene()
        }
        
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
        let dateLabel: SKLabelNode = formateLabel(text: "22th November, 2019", posY: frame.midY + 120, size: 20)
        
        let cityLabel: SKLabelNode = formateLabel(text: "Manaus, Brazil", posY: frame.midY + 90, size: 22)
        
        let titleLabel: SKLabelNode = formateLabel(text: "My last day in high school", posY: frame.midY + 65, size: 24)
        
        self.addChild(dateLabel)     
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.addChild(cityLabel)     
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.addChild(titleLabel)     
        }
    }
    
    func changeScene(){
        let reveal = SKTransition.fade(withDuration: 2)
        //let reveal = SKTransition.reveal(with: .left,duration: 1)
        let newScene = TalksScene(size: viewSize)
        self.view?.presentScene(newScene,transition: reveal)
    }
    
    public override func didMove(to view: SKView) {
        var audio: SKAudioNode?
        
        basicReset()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.createSunNode()
            self.createCloudsNode()
            self.createStreetNode()
            self.createBusNode()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            self.animateBusNode(toX: 20, duration: 3)
            self.animateStatic(node: self.sunNode!, spriteSheet: [
                SKTexture(imageNamed: "sun-0"),
                SKTexture(imageNamed: "sun-1")
            ])
            self.animateStatic(node: self.cloudsNode!, spriteSheet: [
                SKTexture(imageNamed: "clouds-0"),
                SKTexture(imageNamed: "clouds-1")
            ])
            audio = insertAudioBackground(name: "accelerating")
            self.addChild(audio!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6){
            self.createPlayerNode()
            audio?.run(.stop())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7){
            self.animateBusNode(toX: 750, duration: 4)
            audio?.run(.play())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
            //self.busNode?.removeFromParent()
            self.createLabels()
            audio?.run(.stop())

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 12){
            self.animatePlayerNode()
        }
    }
    
}
