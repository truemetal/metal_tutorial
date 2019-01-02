//
//  ColoredPlane.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class ColoredPlane: Node, Renderable {
    
    var vertexFunctionName: String { return "noop_vertex_shader" }
    var fragmentFunctionName: String { return "noop_fragment_shader" }
    var vertexDescriptor: MTLVertexDescriptor? { return VertexWithColor.descriptor }
    lazy var pipelineState: MTLRenderPipelineState = buildPipelineState(withDevice: device)
    
    init(device: MTLDevice) {
        self.device = device
        super.init()
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
    
    var vertices: [VertexWithColor] = [
        VertexWithColor(position: float3(-1, 1, 0), color: float4(1, 0, 0, 1)),
        VertexWithColor(position: float3(-1, -1, 0), color: float4(0, 1, 0, 1)),
        VertexWithColor(position: float3(1, -1, 0), color: float4(0, 0, 1, 1)),
        VertexWithColor(position: float3(1, 1, 0), color: float4(1, 0, 1, 1))
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
