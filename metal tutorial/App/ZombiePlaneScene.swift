//
//  ZombiePlaneScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class ZombiePlaneScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        guard let zombiePlane = TexturedPlane(device: device, rect: CGRect(x: -1, y: -1, width: 2, height: 2), textureImageName: "picture.png", maskImageName: "picture-frame-mask.png"),
        let framePlane = TexturedPlane(device: device, rect: CGRect(x: -1, y: -1, width: 2, height: 2), textureImageName: "picture-frame.png") else { expectationFail(); return }
        
        children.append(contentsOf: [zombiePlane, framePlane])
    }
}
