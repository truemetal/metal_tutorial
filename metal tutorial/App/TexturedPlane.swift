//
//  TexturedPlane.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class TexturedPlane: Node, Renderable, Texturable {
    
    var vertexFunctionName: String { return "noop_textured_vertex_shader" }
    var fragmentFunctionName: String { return "textured_fragment_shader" }
    var vertexDescriptor: MTLVertexDescriptor? { return VertexWithTexture.descriptor }
    lazy var pipelineState: MTLRenderPipelineState = buildPipelineState(withDevice: device)
    var texture: MTLTexture? = nil
    
    init(device: MTLDevice, textureImageName: String) {
        self.device = device
        super.init()
        texture = createTexture(withImageName: textureImageName, device: device)
        if texture == nil { expectationFail() }
        buildBuffers()
    }
    
    let device: MTLDevice
    
    private func makeBuffer<T>(bytes: [T]) -> MTLBuffer? {
        return device.makeBuffer(bytes: bytes, length: bytes.count * MemoryLayout<T>.stride, options: [])
    }
    
    private func buildBuffers() {
        vertexBuffer = makeBuffer(bytes: vertices)
        indexBuffer = makeBuffer(bytes: indecies)
    }
    
    var vertexBuffer: MTLBuffer?
    var indexBuffer: MTLBuffer?
    
    var vertices: [VertexWithTexture] = [
                VertexWithTexture(position: float3(-1, 1, 0), textureCoord: float2(0, 1)),
                VertexWithTexture(position: float3(-1, -1, 0), textureCoord: float2(0, 0)),
                VertexWithTexture(position: float3(1, -1, 0), textureCoord: float2(1, 0)),
                VertexWithTexture(position: float3(1, 1, 0), textureCoord: float2(1, 1))
    ]
    
    var indecies: [UInt32] = [
        0, 1, 2,
        0, 2, 3
    ]
    
    var time: Float = 0
    
    struct RenderConstants {
        let xOffset: Float
    }
    
    override func render(with encoder: MTLRenderCommandEncoder, time: TimeInterval) {
        super.render(with: encoder, time: time)
        guard let indexBuffer = indexBuffer else { return }
        
        encoder.setFragmentTexture(texture, index: 0)
        encoder.setRenderPipelineState(pipelineState)
        encoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        setCurrentOffset(to: encoder, time: time)
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        encoder.drawIndexedPrimitives(type: .triangle, indexCount: indecies.count, indexType: .uint32, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
    
    func setCurrentOffset(to encoder: MTLRenderCommandEncoder, time: TimeInterval) {
        var constants = RenderConstants(xOffset: Float(sin(time)))
        encoder.setVertexBytes(&constants, length: MemoryLayout.size(ofValue: constants), index: 1)
    }
}
