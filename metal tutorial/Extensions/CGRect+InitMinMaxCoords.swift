//
//  CGRect+InitMinMaxCoords.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    init<T: BinaryFloatingPoint>(minX: T, minY: T, maxX: T, maxY: T) {
        self.init(x: minX.cg, y: minY.cg, width: (maxX - minX).cg, height: (maxY - minY).cg)
    }
}
