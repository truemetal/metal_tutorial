//
//  CubeScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class CubeScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)

        children.append(zombiePlane)
        children.append(cube)
        
        zombiePlane.scale = float3(3)
        zombiePlane.position.z = -3
    }
    
    lazy var cube = Cube(device: device)
    lazy var zombiePlane = TexturedPlane(device: device, textureImageName: "picture.png")!
    
    override func animate(time: TimeInterval) {
        cube.rotation.y = time.fl
        cube.rotation.z = time.fl
    }
}
