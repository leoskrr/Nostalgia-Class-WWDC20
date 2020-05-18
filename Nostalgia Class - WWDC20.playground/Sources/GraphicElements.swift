import SpriteKit
import Foundation
import PlaygroundSupport

public func insertAudioBackground(name: String) -> SKAudioNode {
    let soundNode = SKAudioNode(fileNamed: "\(name)")
    soundNode.run(.play())
    soundNode.run(SKAction.changeVolume(to: 0.5, duration: 3))
    
    return soundNode
    //self.addChild(soundNode)
    //soundNode.run(.stop())
}

public func getFont(){
    let fontURL = Bundle.main.url(forResource: "8-BIT WONDER", withExtension: "TTF")
    CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
}

func basicConfigs(label: SKLabelNode) -> SKLabelNode{
    getFont()
    
    label.preferredMaxLayoutWidth = viewSize.width - 100
    label.numberOfLines = 0
    label.color = .white
    label.fontName = "8BIT WONDER"
    
    return label
}

public func createHeading(withText text: String, position: CGPoint) -> SKLabelNode{
    let headerNode = SKLabelNode()
    
    headerNode.text = text
    headerNode.fontSize = 54
    headerNode.position = position
    
    return basicConfigs(label: headerNode)
}

public func createSubheading(withText text: String){
    
}

public func createStaticNodeAnimated(withImage image: String, spriteSheet: [SKTexture], size: CGSize, position: CGPoint, timePerFrame: Double) -> SKSpriteNode {
    
    let node = SKSpriteNode(imageNamed: image )
    let spriteSheet = spriteSheet
    
    node.size = size
    node.position = position
    node.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: timePerFrame)))
    
    return node
}
