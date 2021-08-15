//
//  GameSingleton.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import Foundation

final class Game {
    
    static let shared = Game()
    var currentGame: GameSession?
    var sequenceIsShuffle = false
    
    private(set) var games = [GameSession]()
    private let recorder = GameCaretaker()
    
    //private var questions: [Question]
    private let resultsCareTaker = ResultsCaretaker()
    
    var results: [Result] {
        didSet {
            ResultsCaretaker.save(results: self.results)
        }
    }
    private init() {
        //questions = .init()
        self.results = ResultsCaretaker.retrieveResults()
    }
    
    func addResults(_ result: Result) {
        self.results.append(result)
    }
    
    func deleteResults() {
        self.results = []
    }
    
    func recordSession() {
        guard let game = currentGame else { return }
        games.append(game)
        do {
            try recorder.saveGame(game)
        } catch {
            print("Error")
        }
        currentGame = GameSession()
        print(games)
    }
    
}
