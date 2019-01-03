//
//  VertexWithTexture.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

struct VertexWithTexture {
    let position: float3
    let textureCoord: float2
}

// MARK: descriptor

import MetalKit

extension VertexWithTexture: VertexWithDescriptor {
    
    static let descriptor: MTLVertexDescriptor = {
        let d = MTLVertexDescriptor()
        
        d.attributes[0].format = .float3
        d.attributes[0].bufferIndex = 0
        d.attributes[0].offset = 0
        
        d.attributes[1].format = .float2
        d.attributes[1].bufferIndex = 0
        d.attributes[1].offset = MemoryLayout<float3>.stride
        
        d.layouts[0].stride = MemoryLayout<VertexWithTexture>.stride
        
        return d
    }()
}
