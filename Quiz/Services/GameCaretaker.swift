//
//  GameCaretaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 10.08.2021.
//

import Foundation

enum Error: Swift.Error {
    case gameNotFound
}

class GameCaretaker {
    
    typealias Memento = Data
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func saveGame(_ game: GameSession) throws {
        let data: Memento = try encoder.encode(game)
        UserDefaults.standard.set(data, forKey: Constants.Keys.game.rawValue)
    }
    
    func loadGame() throws -> GameSession {
        guard let data = UserDefaults.standard.value(forKey: Constants.Keys.game.rawValue) as? Memento,
              let game = try? decoder.decode(GameSession.self, from: data) else {
            throw Error.gameNotFound
        }
        return game
    }
    
}
