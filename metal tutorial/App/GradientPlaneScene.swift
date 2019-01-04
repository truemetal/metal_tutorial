//
//  GradientPlaneScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class GradientPlaneScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
        children.append(Plane(device: device))
    }
}
