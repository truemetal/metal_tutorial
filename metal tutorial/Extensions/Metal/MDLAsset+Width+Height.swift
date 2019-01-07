//
//  MDLAsset+Width+Height.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

extension MDLAsset {
    
    var width: Float { return boundingBox.maxBounds.x - boundingBox.minBounds.x }
    var height: Float { return boundingBox.maxBounds.y - boundingBox.minBounds.y }
}
