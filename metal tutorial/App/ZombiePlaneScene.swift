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
        clearColor = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
        
        children.append(zombiePlane)
        
        zombiePlane.position.y = -0.5
        
        let quad2 = Plane(device: device, textureImageName: "picture.png")
        quad2.position.y = 1.5
        quad2.scale = float3(0.5)
        zombiePlane.children.append(quad2)
    }
    
    lazy var zombiePlane = Plane(device: device, textureImageName: "picture.png")
    
    override func animate(time: TimeInterval) {
        zombiePlane.rotation.y = time.fl
        zombiePlane.rotation.z = time.fl
    }
}
