//
//  CubeScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class CubeScene: Scene {
    
    var projectionMatrix = matrix_identity_float4x4
    let viewMatrix = matrix_float4x4(translationX: 0, y: 0, z: -4)
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        defer { aspectRatio = size.aspectRatio.fl }
        
        children.append(cube)
    }
    
    var aspectRatio: Float = 0.75 { didSet { updateProjectionMatrix() } }
    
    func updateProjectionMatrix() {
        projectionMatrix = matrix_float4x4(projectionFov: 60.fl.degreesToRadians, aspect: aspectRatio, nearZ: 0.1, farZ: 100)
    }
    
    lazy var cube = Cube(device: device)
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        super.render(with: encoder, parentModelViewMatrix: matrix_multiply(projectionMatrix, viewMatrix))
    }
    
    override func animate(time: TimeInterval) {
        cube.rotation.y = time.fl
        cube.rotation.z = time.fl
    }
}
