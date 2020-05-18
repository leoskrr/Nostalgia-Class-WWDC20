import SpriteKit
import Foundation
import PlaygroundSupport

public class TalksScene: SKScene {
    
    var floorNode: SKSpriteNode?
    var specsNode: SKSpriteNode?
    var micNode: SKSpriteNode?
    var talkerNode: SKSpriteNode?
    var lightNode: SKSpriteNode?
    var btNext: SKButtonNode?
    var text: SKLabelNode?
    
    let durationRun: Double = 5
    
    func basicReset() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.backgroundColor = bgColor
    }
    
    func createTalkerNode(){
        talkerNode = SKSpriteNode(texture: SKTexture(imageNamed: "generic-2"), color: .red, size: CGSize(width: 250, height: 250))
        talkerNode?.position.y = frame.midY - 30
        talkerNode?.position.x = -600
        
        self.addChild(talkerNode!)
    }
    
    func animateTalkerNode(){
        let countForWalking: Int = 13
        
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "generic-3"),
            SKTexture(imageNamed: "generic-2"),
        ]
        
        let spriteSheetInverted: [SKTexture] = [
            SKTexture(imageNamed: "generic-4"),
            SKTexture(imageNamed: "generic-5"),
        ]
        
        talkerNode?.run(
            .repeatForever(.sequence([
                .group([
                    .moveTo(
                        x: frame.midX - 45,
                        duration: durationRun
                    ),
                    .repeat(
                        .animate(
                            with: spriteSheet,
                            timePerFrame: 0.2
                        ),
                        count: countForWalking
                    )
                ]),
                .wait(forDuration: durationRun),
                .group([
                    .moveTo(
                        x: -600,
                        duration: durationRun
                    ),
                    .repeat(
                        .animate(
                            with: spriteSheetInverted,
                            timePerFrame: 0.2),
                        count: countForWalking
                    )
                ]),
                .wait(forDuration: durationRun)
            ]))
        )
    }
    
    func createLightNode(){
        lightNode = SKSpriteNode(imageNamed: "light");
        lightNode?.position = CGPoint(x: -600, y: frame.midY + 82)
        self.addChild(lightNode!)
    }
    
    func animateLightNode(){
        lightNode?.run(
            .repeatForever(
                .sequence([
                    .moveTo(x: frame.midX, duration: durationRun + 0.5),
                    .wait(forDuration: durationRun),
                    .moveTo(x: -600, duration: durationRun - 0.2),
                    .wait(forDuration: durationRun)
            ]))
        )
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
    
    func createBtNext(){
        let image: SKSpriteNode = SKSpriteNode(imageNamed: "arrow-right-1.png.png")
        
        image.size = CGSize(width: 200, height: 200)
        
        btNext = SKButtonNode(image: image, label: SKLabelNode()){
            self.text?.removeFromParent()
            var i = talksTexts.firstIndex(of: (self.text?.text)!)
            i = i! + 1
            if (i! < talksTexts.count){
                self.showTxt(txt: talksTexts[i!])
            }
            else {
                let reveal = SKTransition.fade(withDuration: 2)
                //let reveal = SKTransition.reveal(with: .left,duration: 1)
                let newScene = SpeechScene(size: viewSize)
                self.view?.presentScene(newScene,transition: reveal)
            }
        }
        
        btNext?.position = CGPoint(x: frame.maxX/2 + 50, y: frame.maxY/2)
        
        btNext?.run(
            .repeatForever(
                .sequence([
                    .moveTo(x: frame.maxX/2 + 50, duration: 0.5),
                    .moveTo(x: frame.maxX/2 + 40, duration: 0.5),
                ])
            )
        )
        
        self.addChild(btNext!)
    }
    
    func renderItems(){
        let theater = Theater(frame: frame)
        let audio = insertAudioBackground(name: "talking.mp3")
        
        var specs = theater.createSpecsNode()
        specs = theater.animateSpecs(specs: specs)
        let floor = theater.createFloorNode()
        let mic = theater.createMicNode()
        
        self.addChild(audio)
        self.addChild(specs)
        self.addChild(floor)
        createLightNode()
        self.addChild(mic)
        createTalkerNode()
        animateTalkerNode()
        animateLightNode()
        showTxt(txt: talksTexts[0])
        createBtNext()
    }
    
    public override func didMove(to view: SKView) {
        basicReset()
        self.renderItems()
    }
}
