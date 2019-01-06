//
//  GameSoundController.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/7/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import Foundation
import AVFoundation

class GameSoundController {
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var popSoundPlayer: AVAudioPlayer?
    
    init?(backgroundMusicFileName: String, popSoundFileName: String) {
        backgroundMusicPlayer = player(withFileName: backgroundMusicFileName).valOrExpFail
        backgroundMusicPlayer?.numberOfLoops = -1
        
        popSoundPlayer = player(withFileName: popSoundFileName).valOrExpFail
    }
    
    func player(withFileName n: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: n, withExtension: nil) else { expectationFail(); return nil }
        let p = try? AVAudioPlayer(contentsOf: url)
        p?.prepareToPlay()
        return p
    }
}
