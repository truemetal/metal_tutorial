//
//  Primitive.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class Primitive<VertexType>: Node, Renderable where VertexType: VertexWithDescriptor {
    
    var vertexFunctionName: String { return "noop_vertex_shader" }
    var fragmentFunctionName: String { return "noop_fragment_shader" }
    var vertexDescriptor: MTLVertexDescriptor { return VertexType.descriptor }
    lazy var pipelineState: MTLRenderPipelineState? = buildPipelineState(withDevice: device)!
    
    init(device: MTLDevice) {
        self.device = device
        super.init()
        setVerteciesAndIndecies()
        buildBuffers()
    }
    
    let device: MTLDevice
    
    private func buildBuffers() {
        vertexBuffer = device.makeBuffer(bytes: vertecies)
        indexBuffer = device.makeBuffer(bytes: indecies)
    }
    
    var vertexBuffer: MTLBuffer?
    var indexBuffer: MTLBuffer?
    
    var vertecies: [VertexType] = []
    var indecies: [UInt32] = []
    func setVerteciesAndIndecies() { }
    
    func doRender(encoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
        guard let indexBuffer = indexBuffer, let pipelineState = pipelineState else { expectationFail(); return }
        
        encoder.setRenderPipelineState(pipelineState)
        encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        encoder.setVertexBytes(ModelConstants(modelViewMatrix: modelViewMatrix), index: 1)
        encoder.drawIndexedPrimitives(type: .triangle, indexCount: indecies.count, indexType: .uint32, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
}
