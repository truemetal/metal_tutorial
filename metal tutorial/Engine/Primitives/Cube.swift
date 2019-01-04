//
//  Cube.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class Cube: Primitive<Vertex> {

    override func setVerteciesAndIndecies() {
        let inputs = zip(zip(positions, colors), textureCoords).map { ($0.0, $0.1, $1) }
        vertecies = inputs.map { Vertex(position: $0, color: $1, textureCoord: $2) }

        indecies = [
            0, 1, 2,    0, 2, 3,    // front
            4, 7, 5,    5, 7, 6,    // back
            4, 5, 1,    4, 1, 0,    // left
            3, 2, 6,    3, 6, 7,    // right
            4, 0, 3,    4, 3, 7,    // top
            1, 5, 6,    1, 6, 2     // bottom
        ]
    }

    let positions: [float3] = [
        float3(-1, 1, 1), float3(-1, -1, 1), float3(1, -1, 1), float3(1, 1, 1),
        float3(-1, 1, -1), float3(-1, -1, -1), float3(1, -1, -1), float3(1, 1, -1),
        ]

    let textureCoords: [float2] = [
        float2(0, 1), float2(0, 0), float2(1, 0), float2(1, 1),
        float2(0, 1), float2(0, 0), float2(1, 0), float2(1, 1)
    ]
    
    let colors: [float4] = [
        float4(1, 0, 0, 1), float4(0, 1, 0, 1), float4(0, 0, 1, 1), float4(1, 0, 1, 1),
        float4(0, 0, 1, 1), float4(0, 1, 0, 1), float4(1, 0, 0, 1), float4(1, 0, 1, 1),
        ]
}
