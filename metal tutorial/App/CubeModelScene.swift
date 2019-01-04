//
//  CubeModelScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class CubeModelScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        children.append(model)
        
        camera.position.z = -6
    }
    
    lazy var model = Model(device: device, modelName: "texturedCube")
    
    override func animate(time: TimeInterval) {
        model.rotation.y = time.fl
    }
}

