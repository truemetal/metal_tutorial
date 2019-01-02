//
//  FPSLogger.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/1/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

import Foundation

class FPSLogger {
    
    let timer: Timer
    
    deinit {
        timer.invalidate()
    }
    
    init() {
        weak var welf: FPSLogger?
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            welf?.logFps()
        })
        
        welf = self
    }
    
    private var framesCount = 0
    
    private func logFps() {
        print(framesCount)
        framesCount = 0
    }
    
    func didDisplayFrame() {
        framesCount += 1
    }
}
