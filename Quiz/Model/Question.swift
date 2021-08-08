//
//  QuestionModel.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import Foundation

final class Question {
    let text: String
    let answers: [String]
    let correctAnswer: String
    let correctAnswerIndex: Int
    var friendCall: Int {
        return callFriend().first ?? 0
    }
    var audienceHelp: Int {
        return activateAudienceHelp().first ?? 0
    }
    
    init(text: String, answers: [String], correctAnswer: String, correctAnswerIndex: Int) {
        self.text = text
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.correctAnswerIndex = correctAnswerIndex
    }
    
}

extension Question {
    
    // работает некорректно, всегла убирает два варианта по индексу 0 и 1, как можно исправить?
    func removeTwoWrongAnswers() -> [Int] {
        guard answers.count > 0 else { return [] }
        let abc =  answers.enumerated()
            .filter { $1 != correctAnswer }
            .map { $0.offset }
        let randomWrongAnswer = abc.randomElement()
        return abc.filter { $0 != randomWrongAnswer }
    }
    
    func callFriend() -> [Int] {
        guard answers.count > 0 else { return [] }
        let randomAnswer = Int.random(in: 0...1)
        let isCorrect = randomAnswer == 1
        
        if isCorrect {
            return answers
                .enumerated()
                .filter { $1 == correctAnswer }
                .map { $0.offset }
        } else {
            let randomAnswerIndex = answers
                .enumerated()
                .map { $0.offset }
                .randomElement()!
            return [randomAnswerIndex]
        }
    }
    
    func activateAudienceHelp() -> [Int] {
        guard answers.count > 0 else { return [] }
        let correctAnswerIndex = answers.firstIndex(of: correctAnswer)
        
        let maxPercent = 100
        let correctAnswerPercent = Int.random(in: 30..<95)
        var freePercent = maxPercent - correctAnswerPercent
        let secondPercent = Int.random(in: 1..<freePercent - 2)
        freePercent -= secondPercent
        let thirdPercent = Int.random(in: 1..<freePercent)
        freePercent -= thirdPercent
        let fourthPercent = freePercent
        
        var percentAnswers = [
            secondPercent,
            thirdPercent,
            fourthPercent
        ]
        
        percentAnswers.insert(correctAnswerPercent, at: correctAnswerIndex!)
        return percentAnswers
    }
    
}
