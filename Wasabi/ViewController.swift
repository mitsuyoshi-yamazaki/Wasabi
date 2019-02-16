//
//  ViewController.swift
//  Wasabi
//
//  Created by 開発用 on 2019/02/16.
//  Copyright © 2019 mitsuyoshi. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
  
  private var sceneView: SKView {
    return view as! SKView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpScene()
  }
  
  private func setUpScene() {
    let scene = SKScene.init(size: view.bounds.size)
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    let size: CGFloat = 10.0
    let shapeNode = SKShapeNode.init(ellipseOf: .init(width: size, height: size))
    let physicsBody = SKPhysicsBody.init(circleOfRadius: size / 2.0)
    physicsBody.affectedByGravity = false
    shapeNode.physicsBody = physicsBody
    
    scene.addChild(shapeNode)
    sceneView.presentScene(scene)
  }
}
