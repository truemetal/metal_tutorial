//
//  ModelWithMultipleTextures.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/6/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class ModelWithMultipleTextures: Node, Renderable {
    
    var pipelineState: MTLRenderPipelineState?
    
    var vertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor.vertexDescriptorForOBJModels
    var vertexFunctionName: String { return "vertex_shader" }
    
    var fragmentFunctionName: String {
        if textures.count > 0  { return "lit_textured_fragment_shader" }
        return "lit_material_color_fragment_shader"
    }
    
    var textures: [String: MTLTexture]
    var meshes: [MTKMesh]
    
    init(device: MTLDevice, meshes: [MTKMesh], textures: [String: MTLTexture]) {
        self.textures = textures
        self.meshes = meshes
        if meshes.count == 0 { expectationFail() }
        super.init()
        pipelineState = buildPipelineState(withDevice: device)
    }
    
    func doRender(encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard let pipelineState = pipelineState else { expectationFail(); return }
        encoder.setVertexBytes(modelConstants(withModelViewMatrix: modelViewMatrix), index: 1)
        encoder.setRenderPipelineState(pipelineState)
        
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            encoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
            
            for submesh in mesh.submeshes {
                if textures.count > 0, let texture = textures[mesh.name].valOrExpFail { encoder.setFragmentTexture(texture, index: 0) }
                encoder.drawIndexedPrimitives(type: submesh.primitiveType, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }
}
