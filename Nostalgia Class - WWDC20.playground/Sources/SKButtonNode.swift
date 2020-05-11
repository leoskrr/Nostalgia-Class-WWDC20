import Foundation
import SpriteKit

public class SKButtonNode: SKNode {
    var image: SKSpriteNode?
    var label: SKLabelNode?
    var action: (()-> Void)?
    
    public init(image: SKSpriteNode?, label: SKLabelNode?, action: @escaping (()-> Void)){
        self.image = image
        self.label = label
        self.action = action
        super.init()
        self.isUserInteractionEnabled = true
        
        if(image != nil){
            self.addChild(image!)
        }
        if(label != nil){
            self.addChild(label!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.action?()
    }
}
