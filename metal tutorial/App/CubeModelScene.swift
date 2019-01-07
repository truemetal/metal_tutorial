//
//  CubeModelScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class CubeModelScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
        
        guard let model = model else { expectationFail(); return }
        children.append(model)
        
        camera.position.z = -6
    }
    
    lazy var model = try? Model(device: device, modelName: "texturedCube")
    
    override func animate(time: TimeInterval) {
        model?.rotation.y = time.flt
    }
}

