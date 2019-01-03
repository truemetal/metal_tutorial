//
//  CGRect+VertexPositions.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import CoreGraphics
import simd

extension CGRect {
    
    var vertexPositions: [float3] {
        return [
            float3(minX.fl, maxY.fl, 0),
            float3(minX.fl, minY.fl, 0),
            float3(maxX.fl, minY.fl, 0),
            float3(maxX.fl, maxY.fl, 0)
        ]
    }
}
