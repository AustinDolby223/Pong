import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKSpriteNode()
    var player = SKSpriteNode()
    var computer = SKSpriteNode()
    
    // this is called when the scene loads
    override func sceneDidLoad() {
        
    }
    
    //Called when scene appears
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        ball = SKSpriteNode(imageNamed: "Grabias")
        ball.position = CGPoint(x: frame.width / 2, y: frame.height/2)
        ball.size = CGSize(width: 69, height: 69)
        addChild(ball)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        
        ball.physicsBody?.contactTestBitMask = 1
        player = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 30))
        player.position = CGPoint(x: size.width/2 , y: size.height-50)
        player.name = "Player"
        addChild(player)
        
        // give physics 
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = false // paddle wont move 
        
       
        // create computer paddle
        computer = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 30))
        computer.position = CGPoint(x: size.width/2, y: 50)
        computer.name = "Computer"
        addChild(computer)
        
        // give computer physics
        computer.physicsBody = SKPhysicsBody(rectangleOf: computer.size)
        computer.physicsBody?.isDynamic = false // paddle wont move 
        
    }
    
    // called once every time user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if ball.frame.contains(location) {
            
            ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
            
        }
//        createBlock(location: location)
        // player.position = location
        
        player.position = CGPoint(x: location.x, y: player.position.y)
        
        
    }
    
    //called when there is any type of movement 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return } 
        let location = touch.location(in: self)
        
        player.position = CGPoint(x: location.x, y: player.position.y)
    }
    
    //this is called every frame (60 times per second)
    override func update(_ currentTime: TimeInterval) {
        let action = SKAction.moveTo(x: ball.position.x , duration: 0.2)
        computer.run(action)
    }
    
    //every time there is a contact that you are listening to
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.contactPoint)
        
        if contact.bodyA.node?.name == "Computer" {
            print ("ball hit computer a")
            if contact.contactPoint.x < computer.position.x {
                print ("Ball hit left side of computer")
                
                ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
            }
            else {
                print ("Ball hit right side of computer")
            }
        }
        if contact.bodyB.node?.name == "Computer" {
          print ("Ball hit computer b")  
            }
        if contact.bodyA.node?.name == "Player" {
            print ("ball hit Player a")
        }
        if contact.bodyB.node?.name == "Player" {
            print ("Ball hit Player b")  
        }
        if contact.bodyA.contactTestBitMask == 1 {
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    func createBlock(location: CGPoint) {
        
        //Get random color
        let colors: [UIColor] = [.red, .yellow]
        
        let randomColor = colors.randomElement() ?? .red
        
        //Create a SKSpriteNode
        let block = SKSpriteNode(color: randomColor, size: CGSize(width: 30, height: 30))
        
        //Design the spriteNode
        block.position = location
        
        //Add to a scene
        self.addChild(block)
        
        //Give it phisics or not
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        block.physicsBody?.restitution = 1
        block.physicsBody?.friction = -1
        block.physicsBody?.linearDamping = 1
        block.physicsBody?.angularDamping = 0
        block.physicsBody?.affectedByGravity = false
        block.physicsBody?.applyImpulse(CGVector(dx: 20, dy:20))
        
        block.physicsBody?.categoryBitMask = 2
        
        
        
    }
}

