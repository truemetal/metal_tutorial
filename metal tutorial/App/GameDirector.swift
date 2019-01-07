//
//  GameDirector.swift
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import CoreGraphics

class GameDirector: GameSceneDelegate, GameOverSceneDelegate {
    
    weak var renderer: Renderer?
    init(renderer: Renderer) { self.renderer = renderer }
    
    var sceneDidChangeBlock: VoidBlock?
    var size: CGSize { return renderer?.metalView?.bounds.size ?? .zero }
    
    func playerDidWin() {
        guard let renderer = renderer else { return }
        renderer.scene = GameOverScene(device: renderer.device, size: size, state: .win, delegate: self)
        sceneDidChangeBlock?()
    }
    
    func playerDidLoose() {
        guard let renderer = renderer else { return }
        renderer.scene = GameOverScene(device: renderer.device, size: size, state: .loose, delegate: self)
        sceneDidChangeBlock?()
    }
    
    func playerWantsToCloseGameOverScene() {
        guard let renderer = renderer else { return }
        renderer.scene = GameScene(device: renderer.device, size: size, delegate: self)
        sceneDidChangeBlock?()
    }
}
