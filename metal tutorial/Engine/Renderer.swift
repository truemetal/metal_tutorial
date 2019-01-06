//
//  Renderer.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 10/31/18.
//  Copyright © 2018 ios-engineer.com. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
    
    weak var metalView: MTKView?
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    let library: MTLLibrary
    var didDrawFrameBlock: VoidBlock?
    var scene: Scene?
    
    init?(metalView: MTKView) {
        guard let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue(),
            let library = device.makeDefaultLibrary() else { return nil }
        
        self.device = device
        self.commandQueue = commandQueue
        self.metalView = metalView
        self.library = library
        super.init()
        
        metalView.device = device
        metalView.delegate = self
        metalView.depthStencilPixelFormat = .depth32Float
    }
    
    lazy var samplerState: MTLSamplerState? = {
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.magFilter = .linear
        return device.makeSamplerState(descriptor: descriptor)
    }()
    
    lazy var depthStencilState: MTLDepthStencilState? = {
        let d = MTLDepthStencilDescriptor()
        d.depthCompareFunction = .less
        d.isDepthWriteEnabled = true
        return device.makeDepthStencilState(descriptor: d)
    }()
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene?.size = size
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let descriptor = view.currentRenderPassDescriptor, let buffer = commandQueue.makeCommandBuffer() else { expectationFail(); return }
        
        scene.map { view.clearColor = $0.clearColor }
        renderScene(with: buffer, descriptor: descriptor)
        buffer.present(drawable)
        buffer.commit()
        didDrawFrameBlock?()
    }
    
    func renderScene(with buffer: MTLCommandBuffer, descriptor: MTLRenderPassDescriptor) {
        guard let encoder = buffer.makeRenderCommandEncoder(descriptor: descriptor), let scene = scene else { expectationFail(); return }
        
        encoder.setDepthStencilState(depthStencilState)
        encoder.setCullMode(.back)
        encoder.setFrontFacing(.counterClockwise)
        encoder.setFragmentSamplerState(samplerState, index: 0)
        scene.render(with: encoder)
        encoder.endEncoding()
    }
}
