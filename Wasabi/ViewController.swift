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
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    lives = createLives(in: view.bounds.size)
    nodes(for: lives).forEach { scene.addChild($0) }
    
    sceneView.presentScene(scene)
  }
  
  private func createLives(in area: CGSize) -> [Life] {
    return (0..<10)
      .map { _ in
        Life.init(position: randomPosition(in: area), energy: Life.energy)
      }
  }
  
  private func nodes(`for` lives: [Life]) -> [SKNode] {
    return lives
      .map { life -> SKNode? in
        switch life.status {
        case let .alive(_, node):
          return node
          
        default:
          return nil
        }
      }
      .compactMap { $0 }
  }
}

func randomPosition(in size: CGSize) -> CGPoint {
  let halfWidth = size.width / 2.0
  let widthRange = -halfWidth..<halfWidth
  let x = CGFloat.random(in: widthRange).rounded()
  
  let halfHeight = size.height / 2.0
  let heightRange = -halfHeight..<halfHeight
  let y = CGFloat.random(in: heightRange).rounded()
  
  return CGPoint.init(x: x, y: y)
}
