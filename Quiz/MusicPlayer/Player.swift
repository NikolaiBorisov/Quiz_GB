//
//  Player.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 07.08.2021.
//

import Foundation
import UIKit
import AVFoundation

final class Player {
    
    static let shared = Player()
    private init() {}
    
    var player: AVAudioPlayer?
    func playSoundOn(vc withURL: URL) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: withURL, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
