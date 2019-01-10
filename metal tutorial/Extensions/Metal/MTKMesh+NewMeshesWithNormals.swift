//
//  MTKMesh+NewMeshesWithNormals.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/10/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

extension MTKMesh {
    
    class func newMeshesWithNormals(asset: MDLAsset, device: MTLDevice, creaseThreshold: Float = 0.1) throws -> [MTKMesh] {
        let msh = try MTKMesh.newMeshes(asset: asset, device: device).modelIOMeshes
        msh.forEach({ $0.addNormals(withAttributeNamed: MDLVertexAttributeNormal, creaseThreshold: creaseThreshold) })
        return try msh.map { try MTKMesh(mesh: $0, device: device) }
    }
}
