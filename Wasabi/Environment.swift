//
//  Environment.swift
//  Wasabi
//
//  Created by 開発用 on 2019/02/17.
//  Copyright © 2019 mitsuyoshi. All rights reserved.
//

import Foundation

let showLabels = false

let numberOfLives = 1000

enum CollisionCategory: UInt32 {
  case life = 0b00000001
  case wall = 0b10000000
}
