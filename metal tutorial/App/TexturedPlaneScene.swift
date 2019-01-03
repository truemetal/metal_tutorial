//
//  TexturedPlaneScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class TexturedPlaneScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        children.append(TexturedPlane(device: device, rect: CGRect(x: -1, y: -1, width: 2, height: 2), textureImageName: "picture.png"))
    }
}
