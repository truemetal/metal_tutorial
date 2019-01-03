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
typealias Block<T> = (T)->()
func expectationFail() { abort() }

class ViewController: UIViewController {
    
    @IBOutlet weak var lblFPS: UILabel!
    
    var metalView: MTKView { return view as! MTKView }
    lazy var renderer = Renderer(metalView: metalView)
    let fpsCalculator = FPSCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblFPS.text = ""
        fpsCalculator.updateFPSBlock = { [weak self] in self?.lblFPS.text = "\($0)" }
        renderer.didDrawFrameBlock = { [weak self] in self?.fpsCalculator.didDisplayFrame() }
        
        renderer.scene = ZombiePlaneScene(device: renderer.device, size: view.bounds.size)
    }
}
