//
//  FixedWidthInteger+BinaryFloatingPoint+CGFloat+Float+Int+Double.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import CoreGraphics

extension FixedWidthInteger {
    var flt: Float { return Float(self) }
}

extension BinaryFloatingPoint {
    var cg: CGFloat { return CGFloat(self) }
    var flt: Float { return Float(self) }
}
