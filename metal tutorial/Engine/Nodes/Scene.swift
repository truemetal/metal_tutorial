//
//  Scene.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import Foundation
import MetalKit

class Scene: Node {
    
    init(device: MTLDevice, size: CGSize) {
        self.device = device
        self.size = size
        super.init()
        
        camera.aspect = size.aspectRatio.flt
        camera.position.z = -4
        children.append(camera)
    }
    
    var device: MTLDevice
    var size: CGSize { didSet { camera.aspect = size.aspectRatio.flt } }
    var camera = Camera()
    var clearColor: MTLClearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    var light = Light()
    
    let startTime = Date()
    func animate(time: TimeInterval) { }
    
    override func render(with encoder: MTLRenderCommandEncoder, parentModelViewMatrix: matrix_float4x4) {
        expectationFail()
    }
    
    func render(with encoder: MTLRenderCommandEncoder) {
        isPaused = false
        
        animate(time: Date().timeIntervalSince(startTime) - pauseDuration)
        encoder.setVertexBytes(SceneConstants(projectionMatrix: camera.projectionMatrix), index: 2)
        encoder.setFragmentBytes(light, index: 0)
        super.render(with: encoder, parentModelViewMatrix: camera.viewMatrix)
    }
    
    func handleTap() { }
    
    func handlePan(translation: CGPoint) {
        camera.rotation.y -= translation.x.flt.degreesToRadians
        camera.rotation.x -= translation.y.flt.degreesToRadians
    }
    
    func handlePinch(scale: Float) {
        camera.position.z /= scale
    }
    
    // MARK: pause
    
    var isPaused = true {
        willSet { if newValue == false, isPaused == true { unPause() }  }
        didSet { pausedStateDidChange() }
    }
    
    var pauseTimer: Timer?
    var pauseDuration: TimeInterval = 0
    var pauseStartTime: Date?
    
    func unPause() {
        guard let pauseStartTime = pauseStartTime else { return }
        pauseDuration += Date().timeIntervalSince(pauseStartTime)
    }
    
    func pausedStateDidChange() {
        if isPaused == false { startPauseCountdown() }
    }

    func startPauseCountdown() {
        pauseTimer?.invalidate()
        
        pauseTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            self?.isPaused = true
            self?.pauseStartTime = Date()
        }
    }
}
