//
//  ModelConstants.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import simd

struct ModelConstants {
    
    var modelViewMatrix: matrix_float4x4
    var materialColor: float4
    var normalMatrix: matrix_float3x3

    init(modelViewMatrix: matrix_float4x4, materialColor: float4) {
        self.modelViewMatrix = modelViewMatrix
        self.materialColor = materialColor
        self.normalMatrix = modelViewMatrix.upperLeft3x3()
    }
}
