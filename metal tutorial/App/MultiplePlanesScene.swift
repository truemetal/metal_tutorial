//
//  MultiplePlanesScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class MultiplePlanesScene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        let count = 100
        let size = 1 / Double(count) * 2
        
//        guard let url = Bundle.main.url(forResource: "picture.png", withExtension: nil),
        //            let texture = try? MTKTextureLoader(device: device).newTexture(URL: url, options: [.origin : MTKTextureLoader.Origin.bottomLeft]) else { expectationFail(); return }
        
        for x in 0 ..< count {
            for y in 0 ..< count {
                let x = Double(x)
                let y = Double(y)
                let rect = CGRect(x: -1.0 + size * x, y: -1.0 + size * y, width: size, height: size)
                children.append(ColoredPlane(device: device, rect: rect))
//                children.append(TexturedPlane(device: device, rect: rect, texture: texture))
            }
        }
    }
}
