//
//  Life.swift
//  Wasabi
//
//  Created by 開発用 on 2019/02/17.
//  Copyright © 2019 mitsuyoshi. All rights reserved.
//

import Foundation
import SpriteKit

class Life {
  private(set) var energy: CGFloat = 0.0
  private(set) var node: SKNode?
  
  init(position: CGPoint, energy: CGFloat) {
    let size = type(of: self).size
    let shapeNode = SKShapeNode.init(ellipseOf: .init(width: size, height: size))
    shapeNode.position = position
    
    let physicsBody = SKPhysicsBody.init(circleOfRadius: size / 2.0)
    physicsBody.affectedByGravity = false
    physicsBody.linearDamping = 1.0
    shapeNode.physicsBody = physicsBody
    
    if showLabels {
      let labelNode = SKLabelNode.init(text: "\(position)")
      labelNode.fontSize = 12.0
      
      shapeNode.addChild(labelNode)
      
      print(position)
    }

    self.energy = energy
    node = shapeNode
  }

  // MARK: -
  func update() {
    move(to: .init(dx: 1, dy: 0))
  }

  // MARK: -
  func move(to direction: CGVector) {
    let energyNeeded = direction.magnitude

    guard energy > energyNeeded else {
      return
    }

    energy -= energyNeeded

    node?.physicsBody?.applyForce(direction)
  }
}

extension Life {
  static let size: CGFloat = 10.0
  static let energy: CGFloat = 10.0
}

extension CGVector {
  var magnitude: CGFloat {
    return CGFloat(sqrtf(Float(dx * dx + dy * dy)))
  }
}
