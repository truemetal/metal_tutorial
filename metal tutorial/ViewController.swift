//
//  ViewController.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 10/23/18.
//  Copyright © 2018 iOS-engineer. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblFPS: UILabel!
    
    var metalView: MTKView { return view as! MTKView }
    lazy var renderer: Renderer! = Renderer(metalView: metalView)
    let fpsCalculator = FPSCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblFPS.text = ""
        fpsCalculator.updateFPSBlock = { [weak self] in self?.lblFPS.text = "\($0)" }
        renderer.didDrawFrameBlock = { [weak self] in self?.fpsCalculator.didDisplayFrame() }

        renderer.scene = SunScene(device: renderer.device, size: view.bounds.size)
        
        metalView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(g:))))
        metalView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(g:))))
        metalView.gestureRecognizers?.forEach { $0.delegate = self }
    }
    
    @objc func panGesture(g: UIPanGestureRecognizer) {
        let t = g.translation(in: metalView)
        g.setTranslation(.zero, in: metalView)
        
        renderer.scene?.camera.rotation.y -= t.x.fl.degreesToRadians
        renderer.scene?.camera.rotation.x -= t.y.fl.degreesToRadians
    }
    
    @objc func pinchGesture(g: UIPinchGestureRecognizer) {
        renderer.scene?.camera.position.z /= g.scale.fl
        g.scale = 1
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
