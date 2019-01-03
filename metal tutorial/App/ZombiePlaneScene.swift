//
//  ZombiePlaneScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class ZombiePlaneScene: Scene {
    
    var projectionMatrix = matrix_identity_float4x4
    let viewMatrix = matrix_float4x4(translationX: 0, y: 0, z: -4)
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        defer { aspectRatio = size.aspectRatio.fl }
        
        guard let zombiePlane = zombiePlane else { expectationFail(); return }
        children.append(zombiePlane)
        
        zombiePlane.position.y = -0.5
        
        let quad2 = TexturedPlane(device: device, textureImageName: "picture.png")
        quad2?.position.y = 1.5
        quad2?.scale = float3(0.5)
        quad2.map { zombiePlane.children.append($0) }
    }
    
    var aspectRatio: Float = 0.75 { didSet { updateProjectionMatrix() } }
    
    func updateProjectionMatrix() {
        projectionMatrix = matrix_float4x4(projectionFov: 60.fl.degreesToRadians, aspect: aspectRatio, nearZ: 0.1, farZ: 100)
    }
    
    lazy var zombiePlane = TexturedPlane(device: device, textureImageName: "picture.png")
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        super.render(with: encoder, parentModelViewMatrix: matrix_multiply(projectionMatrix, viewMatrix))
    }
    
    override func animate(time: TimeInterval) {
        zombiePlane?.rotation.y = time.fl
        zombiePlane?.rotation.z = time.fl
    }
}
