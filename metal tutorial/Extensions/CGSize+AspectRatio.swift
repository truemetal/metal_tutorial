//
//  CGSize+AspectRatio.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGSize {
    var aspectRatio: CGFloat { return width / height }
}
