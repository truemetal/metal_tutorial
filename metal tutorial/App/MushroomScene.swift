//
//  MushroomScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class MushroomScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        clearColor = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
        
        light.direction = float3(0, -1, 0)
        light.ambientLightIntensity = 0.2
        light.diffuseIntensity = 0.8
        
        children.append(model)
        
        model.specularIntensity = 0.2
        model.shininess = 2
        model.position.y = -1.5
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "mushroom")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.fl
    }
}
