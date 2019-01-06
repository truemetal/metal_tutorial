//
//  GameScene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/6/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

class GameScene: Scene {
    
    enum Constants {
        static let gameWidth: Float = 27
        static let gameHeight: Float = 48
        static let bricksPerRow: UInt = 8
        static let bricksPerColumn: UInt = 8
        static let panSensitivity: Float = 0.2
    }
    
    lazy var border = Model(device: device, modelName: "border")
    lazy var ball = Model(device: device, modelName: "ball")
    lazy var paddle = Model(device: device, modelName: "paddle")
    lazy var brick = Model(device: device, modelName: "brick")
    lazy var bricks = Instance(device: device, model: brick, instanceCount: Constants.bricksPerRow * Constants.bricksPerColumn)
    
    override init(device: MTLDevice, size: CGSize) {
        super.init(device: device, size: size)
        
        clearColor = MTLClearColor(red: 0, green: 0.41, blue: 0.29, alpha: 1)
        
        camera.position.z = -sceneOffset
        camera.position.x = -Constants.gameWidth / 2
        camera.position.y = -Constants.gameHeight / 2 + 5
        camera.rotation.x = 20.flt.degreesToRadians
        
        light.color = float3(1)
        light.ambientLightIntensity = 0.3
        light.diffuseIntensity = 0.8
        light.direction = float3(0, -1, -1)
        
        setupScene()
    }
    
    override func animate(time: TimeInterval) {
        for brick in bricks.instances {
            brick.rotation.y = .pi / 4 * time.flt
            brick.rotation.z = .pi / 4 * time.flt
        }
    }
    
    var sceneOffset: Float {
        return (Constants.gameHeight / 2) / tan(camera.fovDegrees.degreesToRadians / 2)
    }
    
    func setupScene() {
        children.append(contentsOf: [border, ball, paddle, bricks])
        
        ball.position = float3(Constants.gameWidth / 2, Constants.gameHeight * 0.1, 0)
        ball.materialColor = float4(0.5, 0.9, 0, 1)
        
        paddle.position = float3(Constants.gameWidth / 2, Constants.gameHeight * 0.05, 0)
        paddle.materialColor = float4(1, 0, 0, 1)
        
        border.position = float3(Constants.gameWidth / 2, Constants.gameHeight / 2, 0)
        border.materialColor = float4(0.51, 0.24, 0, 1)
        
        let colors = generateColors(number: Int(Constants.bricksPerRow))
        let originY = Constants.gameHeight * 0.5
        let margin = Constants.gameWidth * 0.11
        
        for row in 0 ..< Constants.bricksPerRow {
            for column in 0 ..< Constants.bricksPerColumn {
                let idx = row * Constants.bricksPerRow + column
                let brick = bricks.instances[Int(idx)]
                brick.position.x = margin + row.flt * margin
                brick.position.y = originY + column.flt * margin
                brick.materialColor = colors[Int(row)]
            }
        }
    }
    
    override func handlePan(translation: CGPoint) {
        paddle.position.x += translation.x.flt * Constants.panSensitivity
    }
    
    override func handlePinch(scale: Float) {
        
    }
}
