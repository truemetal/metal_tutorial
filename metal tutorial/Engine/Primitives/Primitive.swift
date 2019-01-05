//
//  Primitive.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class Primitive<VertexType>: Node, Renderable where VertexType: VertexWithDescriptor {
    
    enum ShaderFunction: String {
        case litVertexColor = "lit_vertex_color_fragment_shader",
        litMaterialColor = "lit_material_color_fragment_shader",
        nonLitVertexColor = "non_lit_vertex_color_fragment_shader",
        nonLitMaterialColor = "non_lit_material_color_fragment_shader"
    }
    
    var shaderFunction: ShaderFunction = .litMaterialColor { didSet { pipelineState = buildPipelineState(withDevice: device) } }
    
    var vertexFunctionName: String { return "vertex_shader" }
    var fragmentFunctionName: String { return shaderFunction.rawValue }
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
        
        encoder.setVertexBytes(modelConstants(withModelViewMatrix: modelViewMatrix), index: 1)
        encoder.setRenderPipelineState(pipelineState)
        
        encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        encoder.drawIndexedPrimitives(type: .triangle, indexCount: indecies.count, indexType: .uint32, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
}
