//
//  ViewController.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 10/23/18.
//  Copyright © 2018 iOS-engineer. All rights reserved.
//

import UIKit
import MetalKit

typealias VoidBlock = ()->()
func expectationFail() { abort() }

class ViewController: UIViewController {
    
    var metalView: MTKView { return view as! MTKView }
    lazy var renderer = Renderer(metalView: metalView)
    let fpsLogger = FPSLogger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        renderer.scene = TexturedPlaneScene(device: renderer.device, size: view.bounds.size)
        
        renderer.didDrawFrameBlock = { [weak self] in self?.fpsLogger.didDisplayFrame() }
    }
}
