//
//  Renderer.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 10/31/18.
//  Copyright © 2018 iOS-engineer. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
    
    weak var metalView: MTKView?
    let device: MTLDevice
    let commandQueue: MTLCommandQueue
    let library: MTLLibrary
    var didDrawFrameBlock: VoidBlock?
    var scene: Scene?
    let samplerState: MTLSamplerState
    
    init(metalView: MTKView) {
        guard let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue(),
            let library = device.makeDefaultLibrary(),
            let samplerState = Renderer.buildSamplerState(with: device) else { abort() }
        
        self.device = device
        self.commandQueue = commandQueue
        self.metalView = metalView
        self.library = library
        self.samplerState = samplerState
        super.init()
        
        metalView.device = device
        metalView.delegate = self
        metalView.clearColor = MTLClearColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    
    let startTime = Date()
    
    private class func buildSamplerState(with device: MTLDevice) -> MTLSamplerState? {
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.magFilter = .linear
        return device.makeSamplerState(descriptor: descriptor)
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let descriptor = view.currentRenderPassDescriptor else { abort() }
        
        let buffer = commandQueue.makeCommandBuffer()
        
        if let encoder = buffer?.makeRenderCommandEncoder(descriptor: descriptor) {
            encoder.setFragmentSamplerState(samplerState, index: 0)
            renderScene(to: encoder)
        }
        
        buffer?.present(drawable)
        buffer?.commit()
        didDrawFrameBlock?()
    }
    
    func renderScene(to encoder: MTLRenderCommandEncoder) {
        scene?.render(with: encoder, time: Date().timeIntervalSince(startTime))
        encoder.endEncoding()
    }
}
