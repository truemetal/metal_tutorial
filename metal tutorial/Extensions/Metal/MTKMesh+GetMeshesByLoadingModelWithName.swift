//
//  MTKMesh+GetMeshesByLoadingModelWithName.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

extension MTKMesh {
    
    class func getMeshes(byLoadingModelWithName modelName: String, vertexDescriptor: MTLVertexDescriptor, device: MTLDevice) -> [MTKMesh] {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            expectationFail(); return [] }
        
        let bufferAllocator = MTKMeshBufferAllocator(device: device)
        let asset = MDLAsset(url: url, vertexDescriptor: MDLVertexDescriptor.vertexDescriptorForOBJModels, bufferAllocator: bufferAllocator)
        
        do {
            return try MTKMesh.newMeshes(asset: asset, device: device).metalKitMeshes
        }
        catch {
            expectationFail()
            return []
        }
    }
}
