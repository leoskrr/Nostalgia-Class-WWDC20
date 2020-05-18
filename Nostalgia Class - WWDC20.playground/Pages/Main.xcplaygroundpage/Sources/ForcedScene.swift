import Foundation
import SpriteKit
import PlaygroundSupport

public class ForcedScene: SKScene {
    var theater: Theater?
    var text: SKLabelNode?
    var player: SKSpriteNode?
    
    func createGirl(){
        var girlNode = SKSpriteNode(texture: SKTexture(imageNamed:"girl-1"))
        
        girlNode.size = CGSize(width: 250, height: 250)
        girlNode.position.y = frame.midY - 30
        girlNode.position.x = frame.midX + 75
        girlNode.alpha = 0
        girlNode.xScale = -1
        girlNode = fadeNode(node: girlNode)

        self.addChild(girlNode)
    }
    
    func changePlayerTexture(){
        player = SKSpriteNode(texture: SKTexture(imageNamed:"kneeling"))
        
        player?.size = CGSize(width: 250, height: 250)
        player?.position.y = frame.midY - 35
        player?.position.x = frame.midX - 80

        self.addChild(player!)
        
    }
    
    func createPlayer(){
        player = SKSpriteNode(texture: SKTexture(imageNamed:"myself-0"))
        
        player?.size = CGSize(width: 250, height: 250)
        player?.position.y = frame.midY - 20
        player?.position.x = -600

        self.addChild(player!)
    }
    
    func animatePlayer(){
        let countForWalking: Int = 8
        
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "myself-1"),
            SKTexture(imageNamed: "myself-0"),
        ]
        
        player?.run(
            .group([
                .repeat(.animate(with: spriteSheet, timePerFrame: 0.2), count: countForWalking),
                .moveTo(x: frame.midX - 75, duration: 3)
            ])
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
    
    func fadeNode(node: SKSpriteNode) -> SKSpriteNode {
        
        let item = node
        item.run(
            .fadeIn(withDuration: 4)
        )
        
        return item
    }
    
    func renderItems(){
        theater = Theater(frame: frame)
        
        var specs = theater!.createSpecsNode()
        var floor = theater!.createFloorNode()
        
        specs.alpha = 0
        floor.alpha = 0
        
        specs = fadeNode(node: specs)
        floor = fadeNode(node: floor)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.showTxt(txt: forcedTexts[0])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.text?.removeFromParent()
            self.showTxt(txt: forcedTexts[1])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9){
            self.text?.removeFromParent()
            self.showTxt(txt: forcedTexts[2])
            self.addChild(specs)
            self.addChild(floor)
            self.createGirl()
            self.createPlayer()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
            self.animatePlayer()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 14){
            self.player?.removeFromParent()
            self.changePlayerTexture()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 17){
            let reveal = SKTransition.fade(withDuration: 2)
            
            let newScene = ForcedDecisionScene(size: viewSize)
            self.view?.presentScene(newScene,transition: reveal)
        }
        
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
