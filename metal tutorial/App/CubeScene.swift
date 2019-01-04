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

        children.append(zombieBackPlane)
        children.append(zombiePlane)
        children.append(cube)
        
        zombiePlane.scale = float3(3)
        zombiePlane.position.z = -3
        zombieBackPlane.scale = float3(3)
        zombieBackPlane.position.z = -3.01
        zombieBackPlane.rotation.y = .pi
        
//        camera.position.y = -1
//        camera.position.x = 1
        camera.position.z = -6
        camera.rotation.x = -45.fl.degreesToRadians
        camera.rotation.y = -45.fl.degreesToRadians
    }
    
    lazy var cube = Cube(device: device)
    lazy var zombiePlane = Plane(device: device, textureImageName: "picture.png")
    lazy var zombieBackPlane = Plane(device: device, textureImageName: "picture.png")
    
    override func animate(time: TimeInterval) {
        cube.rotation.y = time.fl
        cube.rotation.z = time.fl
    }
}
