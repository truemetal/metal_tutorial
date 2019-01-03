//
//  TexturedPlane.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class TexturedPlane: Plane<VertexWithTexture>, Texturable {
    
    override var vertexFunctionName: String { return "noop_textured_vertex_shader" }
    override var fragmentFunctionName: String { return "textured_fragment_shader" }
    var texture: MTLTexture? = nil
    
    init(device: MTLDevice, rect: CGRect, textureImageName: String) {
        let vertecies = zip(rect.vertexPositions, texureCoords).map { VertexWithTexture(position: $0, textureCoord: $1) }
        
        super.init(device: device, vertecies: vertecies)
        texture = createTexture(withImageName: textureImageName, device: device)
        if texture == nil { expectationFail() }
    }
    
    init(device: MTLDevice, rect: CGRect, texture: MTLTexture) {
        let vertecies = zip(rect.vertexPositions, texureCoords).map { VertexWithTexture(position: $0, textureCoord: $1) }
        
        super.init(device: device, vertecies: vertecies)
        self.texture = texture
    }
    
    let texureCoords = [float2(0, 1), float2(0, 0), float2(1, 0), float2(1, 1)]
    
    override func render(with encoder: MTLRenderCommandEncoder, time: TimeInterval) {
        encoder.setFragmentTexture(texture, index: 0)
        super.render(with: encoder, time: time)
    }
}
