//
//  GreenfieldScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class GreenfieldScene: Scene {
    
    lazy var ground = Plane(device: device)
    lazy var grassModel = try? Model(device: device, modelName: "grass")
    lazy var grass = grassModel.map { Instance(device: device, model: $0, instanceCount: 10000) }
    lazy var mushroom = try? Model(device: device, modelName: "mushroom")
    lazy var sun = try? Model(device: device, modelName: "8bitSun")
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        clearColor = MTLClearColor(red: 0.66, green: 0.9, blue: 0.96, alpha: 1.0)
        children.append(contentsOf: [ground, grass, sun, mushroom].compactMap { $0 })
        setupScene()
        light.direction = float3(1, -1, -1)
    }
    
    func setupScene() {
        guard let sun = sun, let mushroom = mushroom, let grass = grass else { expectationFail(); return }
        
        ground.materialColor = float4(0.4, 0.3, 0.1, 1)
        ground.scale = float3(20)
        ground.rotation.x = 90.flt.degreesToRadians
        
        sun.materialColor = float4(1, 1, 0, 1)
        sun.position.y = 7
        sun.position.x = 6
        sun.scale = float3(2)
        
        for row in 0 ..< 100 {
            for column in 0 ..< 100 {
                let blade = grass.instances[row * 100 + column]
                blade.scale = float3(0.5)
                blade.position.x = row.flt / 4
                blade.position.z = column.flt / 4
                blade.materialColor = grassColors[Int(arc4random_uniform(3))]
                blade.rotation.y = arc4random_uniform(360).flt.degreesToRadians
            }
        }
        
        grass.position.x = -12.5
        grass.position.z = -12.5
        
        mushroom.position.x = -6
        mushroom.position.z = -8
        mushroom.scale = float3(2)
        
        camera.rotation.x = -10.flt.degreesToRadians
        camera.position.z = -20
        camera.position.y = -2
        camera.fovDegrees = 25
    }
    
    let grassColors = [float4(0.34, 0.51, 0.01, 1), float4(0.5, 0.5, 0, 1),float4(0.29, 0.36, 0.14, 1)]
}
