//
//  Texturable.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

protocol Texturable {
    var texture: MTLTexture? { get }
}

extension Texturable {
    
    static func createTexture(withImageName n: String, device: MTLDevice) -> MTLTexture? {
        guard let url = Bundle.main.url(forResource: n, withExtension: nil),
            let texture = try? MTKTextureLoader(device: device).newTexture(URL: url, options: [.origin : MTKTextureLoader.Origin.bottomLeft]) else { expectationFail(); return nil }

        return texture
    }
}
