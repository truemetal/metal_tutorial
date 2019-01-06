//
//  MTKTextureLoader+LoadTexture.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/6/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

extension MTKTextureLoader {
    
    static func loadTexture(fromImageNamed n: String, device: MTLDevice) -> MTLTexture? {
        guard let url = Bundle.main.url(forResource: n, withExtension: nil),
            let texture = try? MTKTextureLoader(device: device).newTexture(URL: url, options: [.origin : MTKTextureLoader.Origin.bottomLeft]) else { return nil }
        
        return texture
    }
}
