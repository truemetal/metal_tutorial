//
//  Scene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation
import MetalKit

class Scene: Node {
    
    init(device: MTLDevice, size: CGSize) {
        self.device = device
        self.size = size
    }
    
    var device: MTLDevice
    var size: CGSize
}
