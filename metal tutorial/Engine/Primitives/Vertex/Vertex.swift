//
//  Vertex.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

struct Vertex {
    let position: float3
    let color: float4
    let textureCoord: float2
    let normal: float3
}

// MARK: descriptor

import MetalKit

extension Vertex: VertexWithDescriptor {
    
    static let descriptor: MTLVertexDescriptor = {
        let d = MTLVertexDescriptor()
        
        d.attributes[0].format = .float3
        d.attributes[0].bufferIndex = 0
        d.attributes[0].offset = 0
        
        d.attributes[1].format = .float4
        d.attributes[1].bufferIndex = 0
        d.attributes[1].offset = MemoryLayout<float3>.stride
        
        d.attributes[2].format = .float2
        d.attributes[2].bufferIndex = 0
        d.attributes[2].offset = d.attributes[1].offset + MemoryLayout<float3>.stride
        
        d.attributes[3].format = .float3
        d.attributes[3].bufferIndex = 0
        d.attributes[3].offset = d.attributes[2].offset + MemoryLayout<float2>.stride
        
        d.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return d
    }()
}
