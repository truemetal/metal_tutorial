//
//  GameOverScene.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import MetalKit

protocol GameOverSceneDelegate: class {
    func playerWantsToCloseGameOverScene()
}

class GameOverScene: Scene {
    
    weak var delegate: GameOverSceneDelegate?
    
    enum State { case win, loose }
    var state: State? { didSet { stateChanged() } }
    
    lazy var winText = (try? Model(device: device, modelName: "youwin")) ?? Node()
    lazy var looseText = (try? Model(device: device, modelName: "youlose")) ?? Node()
    var gameOverModel: Node?
    
    init(device: MTLDevice, size: CGSize, state: State, delegate: GameOverSceneDelegate) {
        super.init(device: device, size: size)
        
        defer { self.state = state }
        self.delegate = delegate
        
        clearColor = MTLClearColor(red: 0, green: 0.41, blue: 0.29, alpha: 1)
        
        winText.materialColor = float4(0, 1, 0, 1)
        looseText.materialColor = float4(1, 0, 0, 1)
        
        light.color = float3(1, 1, 1)
        light.ambientIntensity = 0.3
        light.diffuseIntensity = 0.8
        light.direction = float3(0, -1, -1)
        
        camera.position.z = -30
    }
    
    func stateChanged() {
        children.removeAll()
        guard let state = state else { return }
        
        switch state {
        case .win: gameOverModel = winText
        case .loose: gameOverModel = looseText
        }
        
        gameOverModel.map { children.append($0) }
    }
    
    override func animate(time: TimeInterval) {
        let progress = sin(time * 2).flt
        gameOverModel?.rotation.x = .pi / 4 * progress
        gameOverModel?.scale = float3(1.flt + progress * 0.1)
    }
    
    override func handleTap() {
        delegate?.playerWantsToCloseGameOverScene()
    }
    
    override func handlePan(translation: CGPoint) {}
    override func handlePinch(scale: Float) {}
}
