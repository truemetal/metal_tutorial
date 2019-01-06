//
//  CGFloat+Float+Int+Double.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    var flt: Float { return Float(self) }
}

extension FixedWidthInteger {
    var flt: Float { return Float(self) }
}

extension Double {
    var flt: Float { return Float(self) }
}
