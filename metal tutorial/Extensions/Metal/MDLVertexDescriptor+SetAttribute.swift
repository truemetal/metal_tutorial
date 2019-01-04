//
//  MDLVertexDescriptor+SetAttribute.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import ModelIO

extension MDLVertexDescriptor {
    
    func setAttribute(name: String, index: Int) {
        guard let attribute = attributes[index] as? MDLVertexAttribute else { expectationFail(); return }
        attribute.name = name
        attributes[index] = attribute
    }
}
