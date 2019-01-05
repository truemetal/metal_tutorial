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
    var ambientLightIntensity: Float = 0.2
    var direction: float3 = float3(0, -1, 0)
    var diffuseIntensity: Float = 0.8
}
