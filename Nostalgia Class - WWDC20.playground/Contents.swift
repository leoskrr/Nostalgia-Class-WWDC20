
import PlaygroundSupport
import SpriteKit
import UIKit

let skView = SKView(frame: .zero)

let gameScene = GameScene(size: UIScreen.main.bounds.size)
gameScene.scaleMode = .aspectFill

skView.presentScene(gameScene)

PlaygroundPage.current.liveView = skView
PlaygroundPage.current.wantsFullScreenLiveView = true

//a
