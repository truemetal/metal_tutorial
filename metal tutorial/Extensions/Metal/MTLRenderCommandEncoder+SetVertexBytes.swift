//
//  MTLRenderCommandEncoder+SetVertexBytes.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import MetalKit

extension MTLRenderCommandEncoder {
    
    func setVertexBytes<T>(_ value: T, index: Int) {
        var value = value
        setVertexBytes(&value, length: MemoryLayout<T>.stride, index: index)
    }
    
    func setFragmentBytes<T>(_ value: T, index: Int) {
        var value = value
        setFragmentBytes(&value, length: MemoryLayout<T>.stride, index: index)
    }
}
