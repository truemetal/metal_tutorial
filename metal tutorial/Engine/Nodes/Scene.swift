//
//  Scene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class Scene: Node {
    
    init(device: MTLDevice, size: CGSize) {
        self.device = device
        self.size = size
        super.init()
        
        camera.aspect = size.aspectRatio.fl
        camera.position.z = -4
        children.append(camera)
    }
    
    var device: MTLDevice
    var size: CGSize { didSet { camera.aspect = size.aspectRatio.fl } }
    var camera = Camera()
    var clearColor: MTLClearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    var light = Light()
    
    let startTime = Date()
    func animate(time: TimeInterval) { }
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        expectationFail()
    }
    
    func render(with encoder: MTLRenderCommandEncoder) {
        animate(time: Date().timeIntervalSince(startTime))
        encoder.setVertexBytes(SceneConstants(projectionMatrix: camera.projectionMatrix), index: 2)
        encoder.setFragmentBytes(light, index: 0)
        super.render(with: encoder, parentModelViewMatrix: camera.viewMatrix)
    }
}
