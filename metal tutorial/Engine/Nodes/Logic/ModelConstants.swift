//
//  ModelConstants.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import simd

struct ModelConstants {
    var modelViewMatrix: matrix_float4x4
    var materialColor: float4
    var normalMatrix: matrix_float3x3
    var specularIntensity: Float
    var shininess: Float
    
    init(modelViewMatrix: matrix_float4x4, materialColor: float4, normalMatrix: matrix_float3x3, specularIntensity: Float, shininess: Float) {
        self.modelViewMatrix = modelViewMatrix
        self.materialColor = materialColor
        self.normalMatrix = normalMatrix
        self.specularIntensity = specularIntensity
        self.shininess = shininess
    }
}
