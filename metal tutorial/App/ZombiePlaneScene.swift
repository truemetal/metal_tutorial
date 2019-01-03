//
//  ZombiePlaneScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class ZombiePlaneScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        guard let zombiePlane = zombiePlane else { expectationFail(); return }
        children.append(zombiePlane)
    }
    
    lazy var zombiePlane = TexturedPlane(device: device, rect: CGRect(x: -1, y: -1, width: 2, height: 2), textureImageName: "picture.png")
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        let projectionMatrix = matrix_float4x4(projectionFov: 60.fl.degreesToRadians, aspect: size.aspectRatio.fl, nearZ: 0.1, farZ: 100)
        let viewMatrix = matrix_float4x4(translationX: 0, y: 0, z: -4)
        super.render(with: encoder, parentModelViewMatrix: matrix_multiply(projectionMatrix, viewMatrix))
    }
    
    override func animate(time: TimeInterval) {
        zombiePlane?.rotation.x = time.fl
        zombiePlane?.rotation.z = time.fl
    }
}
