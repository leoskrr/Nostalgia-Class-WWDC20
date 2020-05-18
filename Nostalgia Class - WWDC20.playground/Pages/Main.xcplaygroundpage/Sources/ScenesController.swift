
import PlaygroundSupport
import SpriteKit

var skView: SKView?

func createView(){
    skView = SKView(frame: CGRect(origin: .zero, size: viewSize))
}

func configPlaygroundPage(){
    PlaygroundPage.current.liveView = skView
    //PlaygroundPage.current.wantsFullScreenLiveView = true
    
}

/*
 
 var skView: SKView?
 skView = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 800, height: 800)))
 let gameScene = MyScene
 
 gameScene.size = skView!.frame.size
 
 gameScene.scaleMode = .aspectFill
 
 skView!.presentScene(scene, transition: SKTransition.moveIn(with: .right, duration: 10))
 
 configPlaygroundPage()

 
 */


public func goToScene(scene: SKScene){
    createView()
    let gameScene = scene
    
    gameScene.size = skView!.frame.size
    
    gameScene.scaleMode = .aspectFill
    
    skView!.presentScene(scene, transition: SKTransition.moveIn(with: .right, duration: 10))
    
    configPlaygroundPage()
}

//  public func changeScene(NewScene: SKScene){
//      let reveal = SKTransition.reveal(with: .down,
//                                       duration: 1)
//      
//      let newScene = NewScene
//      newScene.size = skView!.frame.size
//      newScene.scaleMode = .aspectFill
//      
//      scene.view?.presentScene(newScene,
//                              transition: reveal)
//  }
//  
