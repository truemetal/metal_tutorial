//
//  CrowdScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/5/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class CrowdScene: Scene {

    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        let model = Model(device: device, modelName: "humanFigure")
        let people = Instance(device: device, model: model, instanceCount: 200)
        children.append(people)
        
        for instance in people.instances {
            instance.scale = float3(arc4random_uniform(2).flt)
            instance.position.x = arc4random_uniform(160).flt - 80.flt
            instance.position.z = -arc4random_uniform(200).flt
            instance.materialColor = float4(drand48().flt, drand48().flt, drand48().flt, 1)
        }
        
        people.scale = float3(0.1)
        people.position.z = -8
        people.position.y = -3
        people.rotation.x = -20.flt.degreesToRadians
    }
}
