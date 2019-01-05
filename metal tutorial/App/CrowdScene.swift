//
//  CrowdScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class CrowdScene: Scene {

    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        let meshes = MTKMesh.getMeshes(byLoadingModelWithName: "humanFigure", device: device)
        
        (0 ..< 40).forEach { _ in
            let m = Model(device: device, meshes: meshes)
            m.scale = float3(arc4random_uniform(5).fl / 10)
            m.position.x = arc4random_uniform(20).fl - 10
            m.position.z = arc4random_uniform(20).fl * -1 - 3
            m.position.y = -3
            m.materialColor = float4(drand48().fl, drand48().fl, drand48().fl, 1)
            children.append(m)
        }
        
        camera.rotation.x = -30.fl.degreesToRadians
        camera.position.z = -30
        camera.position.y = -10
    }
}
