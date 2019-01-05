//
//  Light.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import simd

struct Light {
    var color: float3 = float3(1)
    var ambientLightIntensity: Float = 1
    var direction: float3 = float3(1)
    var diffuseIntensity: Float = 0
}
