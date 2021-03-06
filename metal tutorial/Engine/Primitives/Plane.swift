//
//  Plane.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class Plane: Primitive<Vertex> {
    
    override var fragmentFunctionName: String {
        if texture != nil, maskTexture != nil { return "masked_textured_fragment_shader" }
        else if texture != nil { return "lit_textured_fragment_shader" }
        return super.fragmentFunctionName
    }
    
    var texture: MTLTexture? = nil
    var maskTexture: MTLTexture? = nil
    
    convenience init(device: MTLDevice, textureImageName: String, maskImageName: String? = nil) {
        let texture = MTKTextureLoader.loadTexture(fromImageNamed: textureImageName, device: device).valOrExpFail
        let maskTexture = maskImageName.flatMap { MTKTextureLoader.loadTexture(fromImageNamed: $0, device: device).valOrExpFail }
        self.init(device: device, texture: texture, maskTexture: maskTexture)
    }
    
    init(device: MTLDevice, texture: MTLTexture? = nil, maskTexture: MTLTexture? = nil) {
        super.init(device: device)
        self.texture = texture
        self.maskTexture = maskTexture
    }
    
    override func setVerteciesAndIndecies() {
        let inputs = zip(zip(positions, colors), textureCoords).map { ($0.0, $0.1, $1) }
        vertecies = inputs.map { Vertex(position: $0, color: $1, textureCoord: $2, normal: float3(1, 0, 0)) }
        indecies = [0, 1, 2, 0, 2, 3]
    }
    
    let positions: [float3] = [
        float3(-1, 1, 0), float3(-1, -1, 0), float3(1, -1, 0), float3(1, 1, 0)
    ]
    
    let colors: [float4] = [
        float4(1, 0, 0, 1), float4(0, 1, 0, 1), float4(0, 0, 1, 1), float4(1, 0, 1, 1)
    ]
    
    let textureCoords = [
        float2(0, 1), float2(0, 0), float2(1, 0), float2(1, 1)
    ]
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        encoder.setFragmentTexture(texture, index: 0)
        encoder.setFragmentTexture(maskTexture, index: 1)
        super.render(with: encoder, parentModelViewMatrix: parentModelViewMatrix)
    }
}
