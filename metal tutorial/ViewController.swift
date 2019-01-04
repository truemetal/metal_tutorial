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
        
        renderer.scene = CubeScene(device: renderer.device, size: view.bounds.size)
        metalView.depthStencilPixelFormat = .depth32Float
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        (renderer.scene as? CubeScene)?.aspectRatio = size.aspectRatio.fl
    }
}
