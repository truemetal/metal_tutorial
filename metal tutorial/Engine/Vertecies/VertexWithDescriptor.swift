//
//  VertexWithDescriptor.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

protocol VertexWithDescriptor {
    static var descriptor: MTLVertexDescriptor { get }
}
