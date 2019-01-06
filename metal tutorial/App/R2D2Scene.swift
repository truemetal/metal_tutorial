//
//  R2D2Scene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class R2D2Scene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.41, blue: 0.29, alpha: 1.0)
        
        children.append(model)
        model.scale = float3(1.0 / 20)
        model.position.y = -2
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "R2D2 by abrock")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.fl
    }
}
