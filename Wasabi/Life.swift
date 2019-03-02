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
  private(set) var labelNode: SKLabelNode?

  init(position: CGPoint, energy: CGFloat) {
    let size = type(of: self).size
    let shapeNode = SKShapeNode.init(ellipseOf: .init(width: size, height: size))
    shapeNode.position = position
    
    let physicsBody = SKPhysicsBody.init(circleOfRadius: size / 2.0)
    physicsBody.affectedByGravity = false
    physicsBody.linearDamping = 3.0
    physicsBody.density = type(of: self).density

    physicsBody.categoryBitMask = CollisionCategory.life.rawValue
    physicsBody.collisionBitMask = CollisionCategory.wall.rawValue
    physicsBody.contactTestBitMask = 0

    shapeNode.physicsBody = physicsBody
    
    if showLabels {
      let labelNode = SKLabelNode.init(text: "\(position.rounded)")
      labelNode.fontSize = 12.0
      
      shapeNode.addChild(labelNode)
      self.labelNode = labelNode
      
      print(position)
    }

    self.energy = energy
    node = shapeNode
  }

  // MARK: -
  func update() {
    move(to: .init(dx: 1, dy: 0))

    if let node = node, energy > 0.0 {
      updateLabel(with: "\(node.position.rounded)")
    }
  }

  func updateLabel(with text: String) {
    labelNode?.text = text
  }

  // MARK: -
  func move(to direction: CGVector) {
    let energyNeeded = direction.magnitude

    guard energy > energyNeeded else {
      energy = 0.0  // FixMe:
      updateLabel(with: "DEAD")
      return
    }

    energy -= energyNeeded

    node?.physicsBody?.applyForce(direction)
  }
}

extension Life {
  static let size: CGFloat = 2.0
  static let energy: CGFloat = 10.0
  static let density: CGFloat = 25.0 // およそ (10 / size) ^ 2
}

extension CGVector {
  var magnitude: CGFloat {
    return CGFloat(sqrtf(Float(dx * dx + dy * dy)))
  }
}

extension CGPoint {
  var rounded: CGPoint {
    return CGPoint.init(x: x.rounded(), y: y.rounded())
  }
}
