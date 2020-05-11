import SpriteKit

public class Persona {
    
    var spriteNode: SKSpriteNode?
    var spriteSheet: [SKTexture]?
    
    public init(spriteNode: SKSpriteNode?, spriteSheet: [SKTexture]?){ 
        self.spriteNode = spriteNode
        self.spriteSheet = spriteSheet
    }
    
    public func create(withSize size: CGSize, position: CGPoint) -> SKSpriteNode {
        spriteNode!.size = size
        spriteNode!.position = position
        
        return spriteNode!
    }
    
    public func animate(){
        spriteNode?.run(.repeatForever(.animate(with: spriteSheet!, timePerFrame: 0.1)))
    }
    
    public func walkGoAndBack(point: CGPoint){
        spriteNode?.run(.repeatForever(.group([
            .move(to: point, duration: 5),
            .animate(with: spriteSheet!, timePerFrame: 0.1),
            .wait(forDuration: 5),
            SKAction.move(to: point, duration: 5).reversed(),
            .wait(forDuration: 5)
        ])))
    }
    
    public func walkTo(point: CGPoint){
//          spriteNode?.run(.group([
//              .move(to: point, duration: 1),
//              .repeatForever(.animate(with: spriteSheet!, timePerFrame: 0.1))
//          ]))
    }
    
    
    
}
