//
//  Player.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 07.08.2021.
//

import Foundation
import UIKit
import AVFoundation

enum URL {
    static let gameMusicURL = "Кто хочет стать миллионером - Обдумывание"
    static let beginningMusicURL = "Кто хочет стать миллионером - начало"
    static let endMusicURL = "Кто хочет стать миллионером - конец"
}

final class Player {
    
    static let shared = Player()
    private init() {}
    
    var player: AVAudioPlayer?
    func playSoundOn(vc withURL: String) {
        guard let url = Bundle.main.url(forResource: withURL, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
