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
    
    let startTime = Date()
    func animate(time: TimeInterval) { }
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        expectationFail()
    }
    
    func render(with encoder: MTLRenderCommandEncoder) {
        animate(time: Date().timeIntervalSince(startTime))
        super.render(with: encoder, parentModelViewMatrix: matrix_multiply(camera.projectionMatrix, camera.viewMatrix))
    }
}
