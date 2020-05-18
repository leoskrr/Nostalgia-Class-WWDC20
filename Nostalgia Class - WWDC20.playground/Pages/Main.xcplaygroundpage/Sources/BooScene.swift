import Foundation
import PlaygroundSupport
import SpriteKit

public class BooScene: SKScene {
    var playerNode: SKSpriteNode?
    var lightNode: SKSpriteNode?
    var text: SKLabelNode? 
    
    func createBtNext(){
        let image: SKSpriteNode = SKSpriteNode(imageNamed: "arrow-right-1.png.png")
        
        image.size = CGSize(width: 200, height: 200)
        image.xScale = -1

        let btNext = SKButtonNode(image: image, label: SKLabelNode()){
            let reveal = SKTransition.reveal(with: .right,duration: 1)
            let newScene = SpeechDecisionScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
        
        btNext.position = CGPoint(x: -1*(frame.maxX/2 + 50), y: frame.maxY/2)
        
        btNext.run(
            .repeatForever(
                .sequence([
                    .moveTo(x: -1*(frame.maxX/2 + 50), duration: 0.5),
                    .moveTo(x: -1*(frame.maxX/2 + 40), duration: 0.5),
                ])
            )
        )
        
        self.addChild(btNext)
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
        let booAudio = insertAudioBackground(name: "boo.wav")
        
        var specs = theater.createSpecsNode()
        specs = theater.animateSpecs(specs: specs)
        
        let floor = theater.createFloorNode()
        let mic = theater.createMicNode()
             
        self.addChild(floor)
        self.addChild(specs)
        self.addChild(mic)
        self.addChild(booAudio)
        
        createLightNode()
        animateLightNode()
        
        self.createPlayer()
        animatePlayerNode()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.createBtNext()
        }
        
        showTxt(txt: booText)
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
