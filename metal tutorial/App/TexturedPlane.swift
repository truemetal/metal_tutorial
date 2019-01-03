//
//  TexturedPlane.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

class TexturedPlane: Plane<VertexWithTexture>, Texturable {
    
    override var vertexFunctionName: String { return "textured_vertex_shader" }
    override var fragmentFunctionName: String { return maskTexture != nil ? "masked_textured_fragment_shader" : "textured_fragment_shader" }
    var texture: MTLTexture? = nil
    var maskTexture: MTLTexture? = nil
    
    convenience init?(device: MTLDevice, textureImageName: String, maskImageName: String? = nil) {
        guard let texture = TexturedPlane.createTexture(withImageName: textureImageName, device: device) else { return nil }
        let maskTexture = maskImageName.flatMap { TexturedPlane.createTexture(withImageName: $0, device: device) }
        self.init(device: device, texture: texture, maskTexture: maskTexture)
    }
    
    init(device: MTLDevice, texture: MTLTexture, maskTexture: MTLTexture?) {
        let rect = CGRect(x: -1, y: -1, width: 2, height: 2)
        let vertecies = zip(rect.vertexPositions, texureCoords).map { VertexWithTexture(position: $0, textureCoord: $1) }
        
        super.init(device: device, vertecies: vertecies)
        self.texture = texture
        self.maskTexture = maskTexture
    }
    
    let texureCoords = [float2(0, 1), float2(0, 0), float2(1, 0), float2(1, 1)]
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        encoder.setFragmentTexture(texture, index: 0)
        encoder.setFragmentTexture(maskTexture, index: 1)
        super.render(with: encoder, parentModelViewMatrix: parentModelViewMatrix)
    }
}
