//
//  RandomSequenceStrategy.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 09.08.2021.
//

import Foundation

final class RandomSequenceStrategy: SequenceStrategy {
    
    private let questions: [Question]
    init(_ questions: [Question]) {
        self.questions = questions
    }
    
    func getQuestions() -> [Question] {
        return questions.shuffled()
    }
    
}
