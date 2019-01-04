//
//  NabooScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class NabooScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.41, blue: 0.29, alpha: 1.0)
        
        children.append(model)
        model.scale = float3(1.0 / 60)
        model.position.y = -1
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "naboo complex")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.fl
    }
}
