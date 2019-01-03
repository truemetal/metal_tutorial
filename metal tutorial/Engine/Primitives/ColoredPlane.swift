//
//  ColoredPlane.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class ColoredPlane: Primitive<VertexWithColor> {
        
    override func setVerteciesAndIndecies() {
        let rect = CGRect(x: -1, y: -1, width: 2, height: 2)
        vertecies = zip(rect.vertexPositions, colors).map { VertexWithColor(position: $0, color: $1) }
        indecies = [0, 1, 2, 0, 2, 3]
    }
    
    let colors: [float4] = [float4(1, 0, 0, 1), float4(0, 1, 0, 1), float4(0, 0, 1, 1), float4(1, 0, 1, 1)]
}
