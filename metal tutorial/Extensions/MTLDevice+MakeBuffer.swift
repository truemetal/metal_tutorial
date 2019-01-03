//
//  MTLDevice+MakeBuffer.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

extension MTLDevice {
    
    func makeBuffer<T>(bytes: [T]) -> MTLBuffer? {
        return makeBuffer(bytes: bytes, length: bytes.count * MemoryLayout<T>.stride, options: [])
    }
}
