//
//  ViewController.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 10/23/18.
//  Copyright © 2018 ios-engineer.com. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblFPS: UILabel!
    
    var metalView: MTKView { return view as! MTKView }
    lazy var renderer: Renderer! = Renderer(metalView: metalView)
    let fpsCalculator = FPSCalculator()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblFPS.text = ""
        fpsCalculator.updateFPSBlock = { [weak self] in self?.lblFPS.text = "\($0)" }
        renderer.didDrawFrameBlock = { [weak self] in self?.fpsCalculator.didDisplayFrame() }

        setScene()
        
        metalView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
        metalView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(g:))))
        metalView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(g:))))
        metalView.gestureRecognizers?.forEach { $0.delegate = self }
        
        gameDirector.sceneDidChangeBlock = { [weak self] in self?.renderer.scene.map { self?.scenes[0] = $0 } }
    }
    
    @objc func tapGesture() {
        renderer.scene?.handleTap()
    }
    
    @objc func panGesture(g: UIPanGestureRecognizer) {
        let t = g.translation(in: metalView)
        g.setTranslation(.zero, in: metalView)
        renderer.scene?.handlePan(translation: t)
    }
    
    @objc func pinchGesture(g: UIPinchGestureRecognizer) {
        renderer.scene?.handlePinch(scale: g.scale.flt)
        g.scale = 1
    }
    
    func setScene() {
        renderer.scene = scenes[sceneIdx]
        renderer.scene?.size = view.bounds.size
    }
    
    @IBAction func btnPrevSceneTap() {
        sceneIdx = sceneIdx - 1
        if sceneIdx == -1 { sceneIdx = scenes.count - 1 }
        setScene()
    }
    
    @IBAction func btnNextSceneTap() {
        sceneIdx = (sceneIdx + 1) % scenes.count
        setScene()
    }
    
    var sceneIdx = 0
    
    lazy var scenes: [Scene] = [
        GameScene(device: renderer.device, size: view.bounds.size, delegate: gameDirector),
        R2D2Scene(device: renderer.device, size: view.bounds.size),
        MushroomScene(device: renderer.device, size: view.bounds.size),
        GreenfieldScene(device: renderer.device, size: view.bounds.size),
        CrowdScene(device: renderer.device, size: view.bounds.size),
        SunScene(device: renderer.device, size: view.bounds.size),
        HumanScene(device: renderer.device, size: view.bounds.size),
        CubeModelScene(device: renderer.device, size: view.bounds.size),
        NabooScene(device: renderer.device, size: view.bounds.size),
        GradientPlaneScene(device: renderer.device, size: view.bounds.size),
        CubeScene(device: renderer.device, size: view.bounds.size),
        ZombiePlaneScene(device: renderer.device, size: view.bounds.size)
    ]
    
    lazy var gameDirector = GameDirector(renderer: renderer)
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
