//  
//  func createAnimatedLabel(){
//      
//      var label = SKLabelNode()
//      DispatchQueue.main.asyncAfter(deadline: .now() + 5){
//          label.text = "Hello, I'm Leonardo's head and today I'm going to tell to you the history about his last day in highschool";
//          label.color = .white
//          label.position = CGPoint(x: 650, y: self.frame.minY/2)
//          label.fontName = "8BIT WONDER"
//          label.fontSize = 24
//          label.numberOfLines = 0
//          label.preferredMaxLayoutWidth = viewSize.width - 100
//      }
//      self.addChild(label)
//  }
//  
//  func revealScene(){
//      let reveal = SKTransition.reveal(with: .left,duration: 1)
//      
//      let newScene = IntroScene(size: CGSize(width: 1024, height: 768))
//      
//      self.view?.presentScene(newScene,transition: reveal)
//  }
//  
//  func moveFaceNode() {
//      removeActions()
//      
//      let spriteSheet: [SKTexture] = [SKTexture(imageNamed: "face-0"),SKTexture(imageNamed: "face-1")]
//      
//      self.camera = cam
//      
//      self.faceNode?.run(.group([
//          .moveTo(x: 635, duration: 5),
//      ]))
//      createAnimatedLabel()
//  }
//  

/***********************************************************/

//  FAZER A IDEIA DA CABEÇA FALANTE
/*
 Hello, I'm Leonardo's head and today I'm going to tell to you the history about his last day in highschool, so we will travel to the past on November 22, 2019 in Manaus, Brazil
 */
//  import Foundation
//  import SpriteKit
//  
//  public class IntroScene: SKScene {
//      var bus: SKSpriteNode?
//      var player: SKSpriteNode?
//      
//      let cam = SKCameraNode()
//      
//      func basicReset() {
//          self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//          self.scaleMode = .aspectFill
//      }
//      
//      func createSun(){
//          var node = createStaticNodeAnimated(
//              withImage: "sun-0", 
//              spriteSheet: [
//                  SKTexture(imageNamed: "sun-0"), 
//                  SKTexture(imageNamed: "sun-1")
//              ], 
//              size: CGSize(width: 200, height: 200), 
//              position: CGPoint(x: frame.minX/2 - 20, y: frame.maxY/2),
//              timePerFrame: 0.5
//          )
//          self.addChild(node)
//      }
//      
//      func createClouds(){
//          var node = createStaticNodeAnimated(
//              withImage: "clouds-0", 
//              spriteSheet: [
//                  SKTexture(imageNamed: "clouds-0"), 
//                  SKTexture(imageNamed: "clouds-1")
//              ], 
//              size: CGSize(width: 250, height: 250), 
//              position: CGPoint(x: frame.minX/2 + 250, y: frame.maxY/2),
//              timePerFrame: 0.5
//          )
//          self.addChild(node)
//      }
//      
//      func createBus(){
//          bus = SKSpriteNode(imageNamed: "bus-0" )
//          
//          bus?.size = CGSize(width: 200, height: 200)
//          bus?.position = CGPoint(x: frame.minX, y: frame.midY - 100)
//          
//          self.addChild(bus!)
//          
//          animateBus()
//      }
//      
//      func animateBus(){
//          
//          let spriteSheet: [SKTexture] = [
//              SKTexture(imageNamed: "bus-0"),
//              SKTexture(imageNamed: "bus-1")
//          ]
//          
//          bus?.run(.group([
//              .animate(with: spriteSheet, timePerFrame: 1),
//              .moveTo(x: -100, duration: 1)
//          ]))
//          
//      }
//      
//      func createPlayer(){
//          player = SKSpriteNode(imageNamed: "myself-0" )
//          
//          player?.size = CGSize(width: 70, height: 70)
//          player?.position = CGPoint(x: -85, y: frame.midY - 120)
//          
//          self.addChild(player!)
//          self.moviePlayer()
//          
//      }
//      
//      func moviePlayer(){
//          let spriteSheet: [SKTexture] = [
//              SKTexture(imageNamed: "myself-0"),
//              SKTexture(imageNamed: "myself-1")
//          ]
//              //y: frame.midY - 120
//          self.player?.run(.group([
//              .moveTo(x: 550, duration: 10),
//              .repeatForever(.animate(with: spriteSheet, timePerFrame: 0.2)),
//          ]))
//          DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//              self.camera = self.cam
//              self.camera!.run(SKAction.scale(to: 1000, duration: 1))
//          }
//          
//      }
//      
//      public override func didMove(to view: SKView) {
//          basicReset()
//          createSun()
//          createClouds()
//          createBus()
//          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
//              self.createPlayer()
//          }
//          self.backgroundColor = bgColor
//  
//      }
//      
//      public override func didSimulatePhysics() {
//          DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//              self.cam.position.x = self.player!.position.x
//          }
//      }
//      
//  }
//  

//  public override func didSimulatePhysics() {
//      self.cam.position.x = self.faceNode!.position.x
//  }
