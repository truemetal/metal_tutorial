//
//  Vertex.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import simd

struct VertexWithColor {
    let position: float3
    let color: float4
}

// MARK: descriptor

import MetalKit

extension VertexWithColor: VertexWithDescriptor {
    
    static let descriptor: MTLVertexDescriptor = {
        let d = MTLVertexDescriptor()
        
        d.attributes[0].format = .float3
        d.attributes[0].bufferIndex = 0
        d.attributes[0].offset = 0
        
        d.attributes[1].format = .float4
        d.attributes[1].bufferIndex = 0
        d.attributes[1].offset = MemoryLayout<float3>.stride
        
        d.layouts[0].stride = MemoryLayout<VertexWithColor>.stride
        
        return d
    }()
}
