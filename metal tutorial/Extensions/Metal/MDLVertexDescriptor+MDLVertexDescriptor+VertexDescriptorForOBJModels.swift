//
//  MDLVertexDescriptor+MDLVertexDescriptor+VertexDescriptorForOBJModels.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

extension MTLVertexDescriptor {
    
    static let vertexDescriptorForOBJModels: MTLVertexDescriptor = {
        let d = MTLVertexDescriptor()
        
        d.attributes[0].format = .float3
        d.attributes[0].bufferIndex = 0
        d.attributes[0].offset = 0
        
        d.attributes[1].format = .float4
        d.attributes[1].bufferIndex = 0
        d.attributes[1].offset = MemoryLayout<Float>.stride * 3
        
        d.attributes[2].format = .float2
        d.attributes[2].bufferIndex = 0
        d.attributes[2].offset = MemoryLayout<Float>.stride * 7
        
        d.attributes[3].format = .float3
        d.attributes[3].bufferIndex = 0
        d.attributes[3].offset = MemoryLayout<Float>.stride * 9
        
        d.layouts[0].stride = MemoryLayout<Float>.stride * 12
        
        return d
    }()
}

extension MDLVertexDescriptor {
    
    static let vertexDescriptorForOBJModels: MDLVertexDescriptor = {
        let descriptor = MTKModelIOVertexDescriptorFromMetal(MTLVertexDescriptor.vertexDescriptorForOBJModels)
        descriptor.setAttribute(name: MDLVertexAttributePosition, index: 0)
        descriptor.setAttribute(name: MDLVertexAttributeColor, index: 1)
        descriptor.setAttribute(name: MDLVertexAttributeTextureCoordinate, index: 2)
        descriptor.setAttribute(name: MDLVertexAttributeNormal, index: 3)
        return descriptor
    }()
}
