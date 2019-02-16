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
  enum Status {
    case alive(energy: Double, node: SKNode)
    case dead
  }
  
  private(set) var status: Status
  
  var energy: Double {
    switch status {
    case let .alive(energy, _):
      return  energy
      
    case .dead:
      return 0.0
    }
  }
  
  init(position: CGPoint, energy: Double) {
    let size = type(of: self).size
    let shapeNode = SKShapeNode.init(ellipseOf: .init(width: size, height: size))
    shapeNode.position = position
    
    let physicsBody = SKPhysicsBody.init(circleOfRadius: size / 2.0)
    physicsBody.affectedByGravity = false
    shapeNode.physicsBody = physicsBody
    
    if showLabels {
      let labelNode = SKLabelNode.init(text: "\(position)")
      labelNode.fontSize = 12.0
      
      shapeNode.addChild(labelNode)
      
      print(position)
    }
    
    status = .alive(energy: energy, node: shapeNode)
  }
}

extension Life {
  static let size: CGFloat = 10.0
  static let energy: Double = 10.0
}
