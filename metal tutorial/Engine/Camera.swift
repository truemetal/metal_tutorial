//
//  Camera.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/4/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class Camera: Node {
    
    var fovDegrees: Float = 65
    var aspect: Float = 1
    var nearZ: Float = 0.1
    var farZ: Float = 100
    
    var viewMatrix: matrix_float4x4 { return modelMatrix }
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4(projectionFov: fovDegrees.degreesToRadians, aspect: aspect, nearZ: nearZ, farZ: farZ)
    }
}
