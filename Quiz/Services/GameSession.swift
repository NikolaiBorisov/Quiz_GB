//
//  GameSession.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 06.08.2021.
//

import Foundation

class GameSession: Codable {
    var countQuestion: Int
    var countAnswers: Int
    private(set) var isFiftyFiftyAvailable: Bool
    private(set) var isFriendCallAvailable: Bool
    private(set) var isAudienceHelpAvailable: Bool
    
    init(countQuestion: Int, countAnswers: Int) {
        self.countQuestion = countQuestion
        self.countAnswers = countAnswers
        isFiftyFiftyAvailable = true
        isFriendCallAvailable = true
        isAudienceHelpAvailable = true
    }
    
    convenience init() {
        self.init(countQuestion: 0, countAnswers: 0)
    }
    
}

extension GameSession: GameViewControllerDelegate {
    
    func showLastResult(value: Int, name: String) {
    }
    
    func hintsUsed(hint: GameHints) {
        switch hint {
        case .fifty: isFiftyFiftyAvailable = false
        case .call: isFriendCallAvailable = false
        case .audience: isAudienceHelpAvailable = false
        }
    }
    
    func correctAnswer() {
        countAnswers += 1
    }
    
    func getNumberOfCurrentGame() -> Int {
        0
    }
    
}
