//
//  ResultsCareTaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 06.08.2021.
//

import Foundation

final class ResultsCareTaker {
    
    enum Keys: String {
        case result = "result"
    }
    
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func save(results: [Result]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: Keys.result.rawValue)
        } catch {
            print(error)
        }
    }
    
    static func retrieveResults() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: Keys.result.rawValue) else {
            return []
        }
        do {
            return try self.decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    static func delete(row: Int) {
        guard var data = UserDefaults.standard.data(forKey: Keys.result.rawValue) else { return }
        data.remove(at: row)
    }
    
}
