//
//  R2D2Scene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class R2D2Scene: Scene {
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        clearColor = MTLClearColor(red: 0, green: 0.41, blue: 0.29, alpha: 1.0)
        
        guard let model = model else { expectationFail(); return }
        children.append(model)
        model.scale = float3(1.0 / 20)
        model.position.y = -2
        
        camera.position.z = -6
    }
    
    lazy var textures: [String: MTLTexture] = [
        "axe_bras" : MTKTextureLoader.loadTexture(fromImageNamed: "r2d2 texture bras.jpg", device: device),
        "acessoires" : MTKTextureLoader.loadTexture(fromImageNamed: "r2d2 texture accesoires.jpg", device: device),
        "corps" : MTKTextureLoader.loadTexture(fromImageNamed: "r2d2 texture corps.jpg", device: device),
        "tete" : MTKTextureLoader.loadTexture(fromImageNamed: "r2d2 texture tete.jpg", device: device)
        ].reduce([:]) {
            var dict = $0
            if let v = $1.1 { dict[$1.0] = v }
            return dict
    }
    
    lazy var model = try? ModelWithMultipleTextures(device: device, asset: MDLAsset(modelName: "r2d2", device: device) ?? MDLAsset(), textures: textures)
    
    override func animate(time: TimeInterval) {
        model?.rotation.y = time.flt
    }
}

