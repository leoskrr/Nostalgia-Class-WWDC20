

import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    // SKSpriteNode é um node utilizando para mostrar de uma maneira fácil imagem! 
    // Tem propriedades como texture (que aceita a imagem)
    public var playerNode: SKSpriteNode?
    
    override func sceneDidLoad() {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        playerNode = SKSpriteNode(imageNamed: "knight_m_run_anim_f0")
        self.addChild(playerNode!)
        //          runAnimation()
        //          moveToAnimation()
        //          sequenceAnimation()
        groupAnimation()
    }
    
    // WRNING: Só separei em funções para ficar mais fácil de entender, você pode escolher sua própria metodologia de organização 
    
    public func runAnimation() {
        
        // Uma lista com todas as texturas que vou utilizar para animar o personagem
        // WARNING: Se você quiser mais de uma animação por exemplo, RUN e IDLE, sugiro fazer uma lista para cada animação!
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "knight_m_run_anim_f0"),
            SKTexture(imageNamed: "knight_m_run_anim_f1"),
            SKTexture(imageNamed: "knight_m_run_anim_f2"),
            SKTexture(imageNamed: "knight_m_run_anim_f3"),
        ]
        
        // Peço para animação acontecer no node do player
        // Ela vai se repetir para sempre
        // E irá passar por cada imagem na minha lista de texturas gastando 0.1 segundos em cada imagem
        playerNode?.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1)))
    }
    
    public func moveToAnimation() {
        // Peço para animação acontecer no node do player
        // Ele irá se mover PARA o ponto (x: 150, t: 0) e irá levar 1 segundo para completar tal ação
        
        //          playerNode?.position = .init(x: 130, y: 130)
        playerNode?.run(.move(to: .init(x: 150, y: 0), duration: 1))
        //          playerNode?.run(.moveBy(x: -150, y: 0, duration: 1))
    }
    
    public func sequenceAnimation() {
        // Pode colocar um delay também
        // .wait(forDuration: 1),
        // MoveBy é diferente de MoveTo
        // Significa mova-se uma quantidade (Move by)
        // Se eu estiver no ponto (x: 0, y:0) e pedir moveBy de 10 em X, o node irá se move 10 pontos apartir do ponto em que se encontra!
        // Sequence roda as animações uma de cada vez (em sequência)
        
        //          let spriteSheet: [SKTexture] = [
        //              SKTexture(imageNamed: "knight_m_run_anim_f0"),
        //              SKTexture(imageNamed: "knight_m_run_anim_f1"),
        //              SKTexture(imageNamed: "knight_m_run_anim_f2"),
        //              SKTexture(imageNamed: "knight_m_run_anim_f3"),
        //          ]
        
        //          playerNode?.run(.sequence([
        //              .moveBy(x: 150, y: 0, duration: 1),
        //              .wait(forDuration: 1),
        //              SKAction.moveBy(x: 150, y: 0, duration: 1).reversed(),
        //          ]))
    }
    
    public func groupAnimation() {
        // Group roda as animações em paralelo
        
        let spriteSheet: [SKTexture] = [
            SKTexture(imageNamed: "knight_m_run_anim_f0"),
            SKTexture(imageNamed: "knight_m_run_anim_f1"),
            SKTexture(imageNamed: "knight_m_run_anim_f2"),
            SKTexture(imageNamed: "knight_m_run_anim_f3"),
        ]
        
        playerNode?.run(.group([
            .moveBy(x: 150, y: 0, duration: 1),
            .repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1))
        ]))
    }
}

var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 500, height: 500)))
var scene = GameScene(size: view.frame.size)
//  view.presentScene(scene)
//  PlaygroundPage.current.setLiveView(view)
