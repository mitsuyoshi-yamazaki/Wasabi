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
  private var lives: [Life] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpScene()
  }
  
  private func setUpScene() {
    let scene = SKScene.init(size: view.bounds.size)
    scene.delegate = self
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    lives = createLives(in: view.bounds.size)
    nodes(for: lives).forEach { node in
      scene.addChild(node)
    }
    
    setUpWalls(in: scene)
    sceneView.presentScene(scene)
  }

  private func setUpWalls(in scene: SKScene) {
    let wallNode = SKShapeNode.init(rect: scene.frame)
    wallNode.strokeColor = .clear

    let physicsBody = SKPhysicsBody.init(edgeLoopFrom: wallNode.frame)
    physicsBody.isDynamic = false

    physicsBody.categoryBitMask = CollisionCategory.wall.rawValue
    physicsBody.collisionBitMask = UInt32.max
    physicsBody.contactTestBitMask = 0

    wallNode.physicsBody = physicsBody
    scene.addChild(wallNode)
  }

  private func createLives(in area: CGSize) -> [Life] {
    return (0..<numberOfLives)
      .map { _ in
        Life.init(position: randomPosition(in: area), energy: Life.energy)
      }
  }
  
  private func nodes(`for` lives: [Life]) -> [SKNode] {
    return lives
      .map { $0.node }
      .compactMap { $0 }
  }
  
  private func update() {    
    lives.forEach { $0.update() }
  }
}

extension ViewController: SKSceneDelegate {
  func update(_ currentTime: TimeInterval, for scene: SKScene) {
    update()
  }
}

func randomPosition(in size: CGSize) -> CGPoint {
  let halfWidth = size.width / 2.0
  let widthRange = -halfWidth..<halfWidth
  let x = CGFloat.random(in: widthRange)
  
  let halfHeight = size.height / 2.0
  let heightRange = -halfHeight..<halfHeight
  let y = CGFloat.random(in: heightRange)
  
  return CGPoint.init(x: x, y: y)
}
