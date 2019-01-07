//
//  Light.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import simd

struct Light {
    var color: float3 = float3(1)
    var ambientIntensity: Float = 0.2
    var direction: float3 = float3(0, -1, 0)
    var diffuseIntensity: Float = 0.8
}
