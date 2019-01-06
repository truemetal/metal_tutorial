//
//  HumanScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class HumanScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
        
        children.append(model)
        model.scale = float3(1.0 / 3)
        model.position.y = -2
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "humanFigure")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.flt
    }
}
