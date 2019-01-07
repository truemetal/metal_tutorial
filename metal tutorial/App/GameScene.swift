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
        static let panSensitivity: Float = 1
    }
    
    lazy var border = try? Model(device: device, modelName: "border")
    lazy var ball = try? Model(device: device, modelName: "ball")
    lazy var paddle = try? Model(device: device, modelName: "paddle")
    lazy var brick = try? Model(device: device, modelName: "brick")
    lazy var bricks = brick.map { Instance(device: device, model: $0, instanceCount: Constants.bricksPerRow * Constants.bricksPerColumn) }
    let soundController = GameSoundController(backgroundMusicFileName: "bulletstorm_bg_v1.mp3", popSoundFileName: "pop.wav")
    
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
        isPaused = false
        startPauseCountdown()
        
        ball?.position += float3(ballVelocity.x, ballVelocity.y, 0)
        animateBricks(time: time)
        checkBricksCollisionAndRemoveIfNeeded()
        checkBorderCollision()
        checkPaddleCollision()
        checkIfGameIsLost()
    }
    
    func playPopSound() { soundController?.popSoundPlayer?.play() }
    
    override func pausedStateDidChange() {
        if isPaused { soundController?.backgroundMusicPlayer?.pause() }
        else { soundController?.backgroundMusicPlayer?.play() }
    }
    
    var sceneOffset: Float {
        return (Constants.gameHeight / 2) / tan(camera.fovDegrees.degreesToRadians / 2)
    }
    
    func setupScene() {
        guard let border = border, let ball = ball, let paddle = paddle, let bricks = bricks else { expectationFail(); return }
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
    
    let borderMargin: Float = 3
    lazy var paddleMaxX = Constants.gameWidth - borderMargin
    lazy var paddleMinX = borderMargin
    var ballVelocity = float2(0.2, 0.3)
    
    override func handlePan(translation: CGPoint) {
        guard let paddle = paddle.valOrExpFail else { return }
        let deltaX = translation.x.flt * (Constants.gameWidth / size.width.flt) * Constants.panSensitivity
        let x = paddle.position.x + deltaX
        paddle.position.x = max(min(paddleMaxX, x), paddleMinX)
    }
    
    override func handlePinch(scale: Float) { }
}

// MARK: game mechanics

extension GameScene {
    
    func checkBricksCollisionAndRemoveIfNeeded() {
        guard let ball = ball else { expectationFail(); return }
        let ballRect = ball.boundingBox(withParentModelViewMatrix: camera.modelMatrix)
        
        for (idx, brick) in (bricks?.instances ?? []).enumerated() {
            if ballRect.intersects(brick.boundingBox(withParentModelViewMatrix: camera.modelMatrix)) {
                bricks?.instances.remove(at: idx)
                ballVelocity.y *= -1
                playPopSound()
                return
            }
        }
    }
    
    func animateBricks(time: TimeInterval) {
        for brick in bricks?.instances ?? [] {
            brick.rotation.y = .pi / 4 * time.flt
            brick.rotation.z = .pi / 4 * time.flt
        }
    }
    
    func checkBorderCollision() {
        guard let ball = ball else { expectationFail(); return }
        if ball.position.y >= Constants.gameHeight { ballVelocity.y *= -1; playPopSound() }
        if ball.position.x <= 0 || ball.position.x >= Constants.gameWidth  { ballVelocity.x *= -1; playPopSound() }
    }
    
    func checkPaddleCollision() {
        guard let ball = ball, let paddle = paddle else { expectationFail(); return }
        let ballRect = ball.boundingBox(withParentModelViewMatrix: camera.modelMatrix)
        let paddleRect = paddle.boundingBox(withParentModelViewMatrix: camera.modelMatrix)
        
        if ballRect.intersects(paddleRect) {
            ballVelocity.y = abs(ballVelocity.y)
            playPopSound()
        }
    }
    
    func checkIfGameIsLost() {
        guard let ball = ball else { expectationFail(); return }
        if ball.position.y <= 0 { ballVelocity.y *= -1; playPopSound() }
    }
}
