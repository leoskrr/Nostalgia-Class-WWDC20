import Foundation
import SpriteKit
import PlaygroundSupport

public class Theater {
    
    var frame: CGRect?
    
    public init(frame: CGRect){
        self.frame = frame
    }
    
    public func createFloorNode() -> SKSpriteNode{
        let floorNode = SKSpriteNode(imageNamed: "floor")
        floorNode.position.y = frame!.minY + 175
        floorNode.size.height = 950

        return floorNode
    }
    
    public func createSpecsNode() -> SKSpriteNode{
        let specsNode = SKSpriteNode(imageNamed: "specs")
        specsNode.position.y = frame!.minY + 55
        specsNode.size.height = 700
        
        return specsNode
    }
    
    public func createMicNode() -> SKSpriteNode{
        let micNode = SKSpriteNode(imageNamed: "microphone-1")
        micNode.position.y = frame!.midY - 55
        micNode.position.x = frame!.midX + 55
        micNode.size.height = 950
        
        return micNode
    }
    
   public func animateSpecs(specs: SKSpriteNode) -> SKSpriteNode {
        
        let node = specs
        
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "specs"),
            SKTexture(imageNamed: "specs-2"),
            SKTexture(imageNamed: "specs"),
            SKTexture(imageNamed: "specs-3"),
        ]
        
        node.run(.repeatForever(.animate(
            with: spriteSheet,
            timePerFrame: 0.1
            )))
        
        return node
    }
}
