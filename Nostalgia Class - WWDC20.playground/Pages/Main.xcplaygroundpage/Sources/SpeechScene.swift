import Foundation
import PlaygroundSupport
import SpriteKit

public class SpeechScene: SKScene{
    
    var playerNode: SKSpriteNode?
    var text: SKLabelNode?
    var btNext: SKButtonNode?
    var lightNode: SKSpriteNode?
    var specs: SKSpriteNode = SKSpriteNode()
    var theater: Theater?

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
            var i = speechTexts.firstIndex(of: (self.text?.text)!)
            i = i! + 1
            if (i! < speechTexts.count){
                self.showTxt(txt: speechTexts[i!])
                self.lightNode?.alpha = 1
                self.changePlayerImage()
                self.specs = (self.theater?.animateSpecs(specs: self.specs))!

            }
            else {
                let reveal = SKTransition.fade(withDuration: 2)

                let newScene = SpeechDecisionScene(size: viewSize)
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
    
    func createLightNode(){
        lightNode = SKSpriteNode(imageNamed: "light");
        lightNode?.position = CGPoint(x: frame.midX, y: frame.midY + 82)
        lightNode?.alpha = 0
//        lightNode?.zPosition = -1
        self.addChild(lightNode!)
    }

    func changePlayerImage(){
        playerNode?.texture = SKTexture(imageNamed: "myself-0")
        let audio = insertAudioBackground(name: "talking.mp3")
        self.addChild(audio)
    }
    
    func createDarkedPlayer(){
        playerNode = SKSpriteNode(texture: SKTexture(imageNamed:"generic-2"))
        
        playerNode?.size = CGSize(width: 250, height: 250)
        playerNode?.position.y = frame.midY - 30
        playerNode?.position.x = frame.midX - 45

        self.addChild(playerNode!)
    }
    
    func renderItems(){
        theater = Theater(frame: frame)
        specs = theater!.createSpecsNode()

        let floor = theater!.createFloorNode()
        let mic = theater!.createMicNode()
         
        self.addChild(floor)
        self.createLightNode()
        self.addChild(specs)
        self.addChild(mic)
        
        createDarkedPlayer()
        showTxt(txt: speechTexts[0])
        createBtNext()
        
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
