//
//  SunScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class SunScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        clearColor = MTLClearColor(red: 0.66, green: 0.9, blue: 0.96, alpha: 1.0)
        model.materialColor = float4(1, 1, 0, 1)
        children.append(model)
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "8bitSun")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.flt
    }
}
