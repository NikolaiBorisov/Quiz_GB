//
//  GameSingleton.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import Foundation

final class GameSingleton {
    
    var currentGame: GameSession?
    private var questions: [Question]
    private let resultsCareTaker = ResultsCareTaker()
    static let shared = GameSingleton()
    var results: [Result] {
        didSet {
            ResultsCareTaker.save(results: self.results)
        }
    }
    private init() {
        questions = .init()
        self.results = ResultsCareTaker.retrieveResults()
    }
    
    func addResults(_ result: Result) {
        self.results.append(result)
    }
    
    func deleteResults() {
        self.results = []
    }
}
