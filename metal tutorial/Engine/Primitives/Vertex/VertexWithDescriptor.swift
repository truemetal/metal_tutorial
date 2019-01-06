//
//  VertexWithDescriptor.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

protocol VertexWithDescriptor {
    static var descriptor: MTLVertexDescriptor { get }
}
