//
//  CreateSequenceStrategy.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 09.08.2021.
//

import Foundation

protocol SequenceStrategy {
    func getQuestions() -> [Question]
}
