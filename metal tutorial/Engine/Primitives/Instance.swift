//
//  Instance.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class Instance: Node, Renderable {
    
    let model: Model
    var instances: [Node]
    
    // MARK: renderable
    var pipelineState: MTLRenderPipelineState?
    var vertexFunctionName: String = "instance_vertex_shader"
    var fragmentFunctionName: String { return model.fragmentFunctionName }
    var vertexDescriptor: MTLVertexDescriptor { return model.vertexDescriptor }
    var instanceConstantsBuffer: MTLBuffer?
    
    init(device: MTLDevice, model: Model, instanceCount: UInt) {
        let instanceCount = Int(instanceCount)
        self.model = model
        instances = (0 ..< instanceCount).map { _ in Node() }
        instanceConstantsBuffer = device.makeBuffer(length: MemoryLayout<ModelConstants>.stride * instanceCount, options: [])
        super.init()
        pipelineState = buildPipelineState(withDevice: device)
    }
    
    func doRender(encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard instances.count > 0 else { return }
        guard let pipelineState = pipelineState else { expectationFail(); return }
        
        encoder.setRenderPipelineState(pipelineState)
        setInstanceConstants(toEncoder: encoder, modelViewMatrix: modelViewMatrix)
        
        model.texture.map { encoder.setFragmentTexture($0, index: 0) }
        
        for mesh in model.meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            encoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
            
            for submesh in mesh.submeshes {
                encoder.drawIndexedPrimitives(type: submesh.primitiveType, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset, instanceCount: instances.count)
            }
        }
    }
    
    func setInstanceConstants(toEncoder encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard let buffer = instanceConstantsBuffer else { expectationFail(); return }
        
        var pointer = buffer.contents().bindMemory(to: ModelConstants.self, capacity: instances.count)
        
        for instance in instances {
            pointer.pointee = instance.modelConstants(withModelViewMatrix: matrix_multiply(modelViewMatrix, instance.modelMatrix))
            pointer = pointer.advanced(by: 1)
        }
        
        encoder.setVertexBuffer(buffer, offset: 0, index: 1)
    }
}
