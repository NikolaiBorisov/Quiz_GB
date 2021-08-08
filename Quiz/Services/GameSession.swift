//
//  GameSession.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 06.08.2021.
//

import Foundation

class GameSession {
    private(set) var answerTotal: Int
    private(set) var correctAnswersTotal: Int
    private(set) var isFiftyFiftyAvailable: Bool
    private(set) var isFriendCallAvailable: Bool
    private(set) var isAudienceHelpAvailable: Bool
    
    init() {
        answerTotal = .zero
        correctAnswersTotal = .zero
        isFiftyFiftyAvailable = true
        isFriendCallAvailable = true
        isAudienceHelpAvailable = true
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
        correctAnswersTotal += 1
    }
    
    func getNumberOfCurrentGame() -> Int {
        correctAnswersTotal
    }
    
}
