//
//  Model.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit
import ModelIO

class Model: Node, Renderable, Texturable {
    
    var pipelineState: MTLRenderPipelineState?
    
    var vertexDescriptor: MTLVertexDescriptor = MTLVertexDescriptor.vertexDescriptorForOBJModels
    var vertexFunctionName: String { return "vertex_shader" }
    
    var fragmentFunctionName: String {
        if texture != nil { return "textured_fragment_shader" }
        return "noop_fragment_shader"
    }
    
    var texture: MTLTexture?
    var meshes: [MTKMesh]
    
    init(device: MTLDevice, modelName: String) {
        texture = Model.createTexture(withImageName: modelName + ".png", device: device)
        meshes = MTKMesh.getMeshes(byLoadingModelWithName: modelName, vertexDescriptor: vertexDescriptor, device: device)
        if meshes.count == 0 { expectationFail() }
        super.init()
        pipelineState = buildPipelineState(withDevice: device)
    }
    
    func doRender(encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard let pipelineState = pipelineState else { expectationFail(); return }
        encoder.setVertexBytes(ModelConstants(modelViewMatrix: modelViewMatrix), index: 1)
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
