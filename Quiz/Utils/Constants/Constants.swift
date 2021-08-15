//
//  Constants.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

enum Constants {
    
    enum Keys: String {
        case result = "result"
        case game = "game"
        case questions = "questions"
    }
    
    enum Image {
        static let dibrov = UIImage(named: "dibrov")
        static let fiftyFifty = UIImage(named: "fifty")
        static let backButtonImage = UIImage(systemName: "chevron.left")
    }
    
    enum URL {
        static let gameMusicURL = Bundle.main.url(forResource: "Кто хочет стать миллионером - Обдумывание", withExtension: "mp3")
        static let beginningMusicURL = Bundle.main.url(forResource: "Кто хочет стать миллионером - начало", withExtension: "mp3")
        static let endMusicURL = Bundle.main.url(forResource: "Кто хочет стать миллионером - конец", withExtension: "mp3")
    }
    
    enum Placeholder {
        static let userNameTF = "Enter your name"
    }
    
    enum VCTitle {
        static let gameVCTitle = "Unknown user"
        static let resultVCTitle = "Results"
    }
    
    enum DefaultValue {
        static let userName = "Unknown user"
    }
}
