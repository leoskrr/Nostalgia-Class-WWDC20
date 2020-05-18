import Foundation
import PlaygroundSupport
import SpriteKit

public class ClapScene: SKScene {
    var playerNode: SKSpriteNode?
    var lightNode: SKSpriteNode?
    var text: SKLabelNode?
    var cheeringNode: SKSpriteNode?
    var btNext: SKButtonNode?

    func createBtNext(){
        let image: SKSpriteNode = SKSpriteNode(imageNamed: "arrow-right-1.png.png")
        
        image.size = CGSize(width: 200, height: 200)
        
        let btNext = SKButtonNode(image: image, label: SKLabelNode()){
            let reveal = SKTransition.reveal(with: .left,duration: 1)
            let newScene = IntroSecondScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
        
        btNext.position = CGPoint(x: frame.maxX/2 + 50, y: frame.maxY/2)
        
        btNext.run(
            .repeatForever(
                .sequence([
                    .moveTo(x: frame.maxX/2 + 50, duration: 0.5),
                    .moveTo(x: frame.maxX/2 + 40, duration: 0.5),
                ])
            )
        )
        
        self.addChild(btNext)
    }
    
    func createCheering(){
        cheeringNode = SKSpriteNode(imageNamed: "cheering-1")
        cheeringNode?.size = CGSize(width: 700, height: 700)
        cheeringNode?.position = CGPoint(x: frame.midX, y: frame.maxY/2 - 100)
//        cheeringNode?.position = CGPoint(x: frame.midX, y: frame.minY/2 - 130)

        self.addChild(cheeringNode!)
    }
    
    func animateCheering(){
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed:"cheering-1"),
            SKTexture(imageNamed:"cheering-2"),
            SKTexture(imageNamed:"cheering-3"),
            SKTexture(imageNamed:"cheering-4"),
        ]
        
        cheeringNode?.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.3)))
    }
    
    func showTxt(txt: String){
        text = createBallon(
            text: txt,
            position: CGPoint(x: frame.midX, y: frame.maxY - 70),
            fontSize: 22
        )
        
        text?.alpha = 0;
        text?.verticalAlignmentMode = .center
        
        self.addChild(text!)
        
        text?.run(
            .fadeIn(withDuration: 4)
        )
    }
    
    func createPlayer(){
        playerNode = SKSpriteNode(texture: SKTexture(imageNamed:"myself-0"))
        
        playerNode?.size = CGSize(width: 250, height: 250)
        playerNode?.position.y = frame.midY - 30
        playerNode?.position.x = frame.midX - 45

        self.addChild(playerNode!)
    }
    
    func createLightNode(){
        lightNode = SKSpriteNode(imageNamed: "light");
        lightNode?.position = CGPoint(x: frame.midX, y: frame.midY + 82)
        lightNode?.alpha = 0
        self.addChild(lightNode!)
    }
    
    func animateLightNode(){
        lightNode!.run(.repeatForever(.sequence([
            .fadeAlpha(to: 0, duration: 0.1),
            .fadeAlpha(to: 1, duration: 0.1)
        ])))
    }
    
    func animatePlayerNode(){
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "myself-0"),
            SKTexture(imageNamed: "myself-2")

        ]
        
        playerNode?.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1)))
    }
    
    func renderItems(){
        let theater = Theater(frame: frame)
        let clapAudio = insertAudioBackground(name: "clap.aiff")
        
        var specs = theater.createSpecsNode()
        specs = theater.animateSpecs(specs: specs)
        
        let floor = theater.createFloorNode()
        let mic = theater.createMicNode()
             
        self.addChild(floor)
        self.addChild(specs)
        self.addChild(mic)
        self.addChild(clapAudio)
        
        createLightNode()
        animateLightNode()
        
        self.createPlayer()
        animatePlayerNode()
        
        createCheering()
        animateCheering()
        createBtNext()
        
        showTxt(txt: clapText)
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
