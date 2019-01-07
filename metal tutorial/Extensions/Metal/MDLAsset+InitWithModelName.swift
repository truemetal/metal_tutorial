//
//  MDLAsset+InitWithModelName.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

extension MDLAsset {
    
    convenience init?(modelName: String, device: MTLDevice) {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "obj") else { expectationFail(); return nil }
        
        let bufferAllocator = MTKMeshBufferAllocator(device: device)
        self.init(url: url, vertexDescriptor: MDLVertexDescriptor.vertexDescriptorForOBJModels, bufferAllocator: bufferAllocator)
    }
}
