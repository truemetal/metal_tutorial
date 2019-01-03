//
//  ColoredPlane.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class ColoredPlane: Plane<VertexWithColor> {
    
    override var vertexFunctionName: String { return "animate_vertex_shader" }
    override var fragmentFunctionName: String { return "noop_fragment_shader" }
    
    init(device: MTLDevice) {
        let rect = CGRect(x: -1, y: -1, width: 2, height: 2)
        let vertecies = zip(rect.vertexPositions, colors).map { VertexWithColor(position: $0, color: $1) }
        super.init(device: device, vertecies: vertecies)
    }
    
    let colors: [float4] = [float4(1, 0, 0, 1), float4(0, 1, 0, 1), float4(0, 0, 1, 1), float4(1, 0, 1, 1)]
}
