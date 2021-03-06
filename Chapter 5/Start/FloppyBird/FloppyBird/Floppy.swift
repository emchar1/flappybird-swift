//
//  Floppy.swift
//  FloppyBird
//
//  Created by Jeremy Novak on 9/27/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Floppy:SKSpriteNode {
    
    // MARK: - Private class constants
    private let animationName = "Flap"
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        // Create the frames of the animation
        let frame0 = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        let frame1 = Textures.sharedInstance.textureWith(name: SpriteName.player1)
        
        // Create the animation using the frames
        let animation = SKAction.animate(with: [frame0, frame1], timePerFrame: 0.1)
        
        // Run the animation forever
        self.run(SKAction.repeatForever(animation), withKey: animationName)
        
        // Position Floppy 30% into the screen from left on the X axis and 80% up the Y axis
        self.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.8)
    }
    
    private func setupPhysics() {
        // Make the physics body circle a little tighter because the sprite is egg shaped.
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.floppy
        self.physicsBody?.collisionBitMask = Contact.scene
        self.physicsBody?.contactTestBitMask = Contact.scene | Contact.log | Contact.score
    }
    
    // MARK: - Update
    func update() {
        if self.physicsBody!.velocity.dy > 30.0 {
            self.zRotation = CGFloat(M_PI / 6.0)
        } else if self.physicsBody!.velocity.dy < -100.0 {
            self.zRotation = CGFloat(-1 * (M_PI_4))
        } else {
            self.zRotation = 0.0
        }
    }
    
    // MARK: - Actions
    func fly () {
        self.physicsBody!.velocity = CGVector.zero
        
        let impulse = CGVector(dx: 0, dy: 25)
        
        self.physicsBody!.applyImpulse(impulse)
    }
    
    // MARK: - Actions
    private func animate() {
    }
}

