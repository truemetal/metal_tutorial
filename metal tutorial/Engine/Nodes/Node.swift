//
//  Node.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class Node {
    
    var children: [Node] = []
    
    var position: float3 = float3(0)
    var rotation: float3 = float3(0)
    var scale: float3 = float3(1)
    
    var modelMatrix: matrix_float4x4 {
        var matrix = matrix_float4x4(translationX: position.x, y: position.y, z: position.z)
        matrix = matrix.rotatedBy(rotationAngle: rotation.x, x: 1, y: 0, z: 0)
        matrix = matrix.rotatedBy(rotationAngle: rotation.y, x: 0, y: 1, z: 0)
        matrix = matrix.rotatedBy(rotationAngle: rotation.z, x: 0, y: 0, z: 1)
        matrix = matrix.scaledBy(x: scale.x, y: scale.y, z: scale.z)
        return matrix
    }
    
    func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        let modelViewMatrix = matrix_multiply(parentModelViewMatrix, modelMatrix)
        
        if let renderable = self as? Renderable {
            encoder.pushDebugGroup("\(ObjectIdentifier(self))")
            renderable.doRender(encoder: encoder, modelViewMatrix: modelViewMatrix)
            encoder.popDebugGroup()
        }
        
        for child in children {
            child.render(with: encoder, parentModelViewMatrix: modelViewMatrix)
        }
    }
}
