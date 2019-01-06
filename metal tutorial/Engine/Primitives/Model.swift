//
//  Model.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit
import ModelIO

class Model: Node, Renderable, Texturable {
    
    var pipelineState: MTLRenderPipelineState?
    
    var vertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor.vertexDescriptorForOBJModels
    var vertexFunctionName: String { return "vertex_shader" }
    
    var fragmentFunctionName: String {
        if texture != nil { return "lit_textured_fragment_shader" }
        return "lit_material_color_fragment_shader"
    }
    
    var texture: MTLTexture?
    var meshes: [MTKMesh]
    
    convenience init(device: MTLDevice, modelName: String) {
        let texture = Model.createTexture(withImageName: modelName + ".png", device: device)
        let meshes = MTKMesh.getMeshes(byLoadingModelWithName: modelName, device: device)
        self.init(device: device, meshes: meshes, texture: texture)
    }
    
    init(device: MTLDevice, meshes: [MTKMesh], texture: MTLTexture? = nil) {
        self.texture = texture
        self.meshes = meshes
        if meshes.count == 0 { expectationFail() }
        super.init()
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
