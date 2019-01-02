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
    
    func render(with encoder: MTLRenderCommandEncoder, time: TimeInterval) {
        children.forEach {
            $0.render(with: encoder, time: time)
        }
    }
}
