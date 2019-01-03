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
        children.append(ColoredPlane(device: device, rect: CGRect(x: -1, y: -1, width: 2, height: 2)))
    }
}
