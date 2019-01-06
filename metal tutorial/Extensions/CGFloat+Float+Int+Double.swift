//
//  CGFloat+Float+Int+Double.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    var fl: Float { return Float(self) }
}

extension FixedWidthInteger {
    var fl: Float { return Float(self) }
}

extension Double {
    var fl: Float { return Float(self) }
}
