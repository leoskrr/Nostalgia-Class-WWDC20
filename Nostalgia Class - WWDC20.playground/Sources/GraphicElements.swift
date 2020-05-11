import SpriteKit

public func insertAudioBackground(name: String) -> SKAudioNode {
    let soundNode = SKAudioNode(fileNamed: "\(name).mp3")
    soundNode.run(.play())
    
    return soundNode
}

func getFont(){
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
    var headerNode = SKLabelNode()
    
    headerNode.text = text
    headerNode.fontSize = 54
    headerNode.position = position
    
    return basicConfigs(label: headerNode)
}

public func createSubheading(withText text: String){
    
}
