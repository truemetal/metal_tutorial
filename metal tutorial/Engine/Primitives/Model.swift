//
//  Model.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit
import ModelIO

class Model: Node, Renderable {
    
    var pipelineState: MTLRenderPipelineState?
    
    var vertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor.vertexDescriptorForOBJModels
    var vertexFunctionName: String { return "vertex_shader" }
    
    var fragmentFunctionName: String {
        if texture != nil { return "lit_textured_fragment_shader" }
        return "lit_material_color_fragment_shader"
    }
    
    var texture: MTLTexture?
    var meshes: [MTKMesh]
    
    convenience init(device: MTLDevice, modelName: String) throws {
        guard let asset = MDLAsset(modelName: modelName, device: device).valOrExpFail else { throw generalError }
        let texture = MTKTextureLoader.loadTexture(fromImageNamed: modelName + ".png", device: device)
        try self.init(device: device, asset: asset, texture: texture)
    }
    
    init(device: MTLDevice, asset: MDLAsset, texture: MTLTexture? = nil) throws {
        self.texture = texture
        self.meshes = try MTKMesh.newMeshesWithNormals(asset: asset, device: device)
        if meshes.count == 0 { expectationFail() }
        super.init()
        width = asset.width
        height = asset.height
        pipelineState = buildPipelineState(withDevice: device)
    }
    
    func doRender(encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard let pipelineState = pipelineState else { expectationFail(); return }
        encoder.setVertexBytes(modelConstants(withModelViewMatrix: modelViewMatrix), index: 1)
        encoder.setRenderPipelineState(pipelineState)
        texture.map { encoder.setFragmentTexture($0, index: 0) }
        
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            encoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
            
            for submesh in mesh.submeshes {
                encoder.drawIndexedPrimitives(type: submesh.primitiveType, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }
}
