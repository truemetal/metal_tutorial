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
        
        zombiePlane.position.y = -0.5
        
        let quad2 = TexturedPlane(device: device, textureImageName: "picture.png")
        quad2?.position.y = 1.5
        quad2?.scale = float3(0.5)
        quad2.map { zombiePlane.children.append($0) }
    }
    
    lazy var zombiePlane = TexturedPlane(device: device, textureImageName: "picture.png")
    
    override func animate(time: TimeInterval) {
        zombiePlane?.rotation.y = time.fl
        zombiePlane?.rotation.z = time.fl
    }
}
