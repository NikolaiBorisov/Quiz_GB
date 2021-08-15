//
//  QuestionModel.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    let answers: [String: Bool]
    
    var friendCall: Int {
        return callFriend().first ?? 0
    }
    var audienceHelp: Int {
        return activateAudienceHelp().first ?? 0
    }
    
}

struct Questions: Codable {
    var questionNumber = 0
    var userQuestions = [Question]()
    var questions: [Question] = [
        Question.init(
            id: 1,
            question: "Когда был создан язык Swift?",
            answers: [
                "2010": false,
                "2011": false,
                "2013": false,
                "2014": true,
            ]),
        Question.init(
            id: 2,
            question: "Кто является автором и разработчиком языка Swift?",
            answers: [
                "Крейг Федериги": false,
                "Стив Джобс": false,
                "Билл Гейтс": false,
                "Крис Латтнер": true,
            ]),
        Question.init(
            id: 3,
            question: "Наследником какого языка является Swift?",
            answers: [
                "C++": false,
                "C#": false,
                "Ruby": false,
                "C": true,
            ]),
        Question.init(
            id: 4,
            question: "Какое расширение файлов у языка Swift?",
            answers: [
                ".xcode": false,
                ".xcodeproj": false,
                ".xcworkspace": false,
                ".swift": true,
            ]),
        Question.init(
            id: 5,
            question: "На каком языке написана основная кодовая база Apple?",
            answers: [
                ".Swift": false,
                "C": false,
                "C++": false,
                "Objective-C": true,
            ]),
    ]
    
    func getQuestions() -> [Question] {
        return questions + userQuestions
    }
    
    func getFriendAdvice() -> Int {
        return questions[questionNumber].friendCall
    }
    
    func getAudienceHelp() -> [Int] {
        return questions[questionNumber].activateAudienceHelp()
    }
    
    func activateFiftyFifty() -> [Int] {
        return questions[questionNumber].removeTwoWrongAnswers()
    }
}

enum GameHints: CaseIterable {
    case fifty, call, audience
}

extension Question {
    
    // работает некорректно, всегла убирает два варианта по индексу 0 и 1, как можно исправить?
    func removeTwoWrongAnswers() -> [Int] {
        guard answers.values.count > 0 else { return [] }
        let abc =  answers.enumerated()
            //.filter { $1 != answers.values}
            .map { $0.offset }
        let randomWrongAnswer = abc.randomElement()
        return abc.filter { $0 != randomWrongAnswer }
    }
    
    func callFriend() -> [Int] {
        guard answers.values.count > 0 else { return [] }
        let randomAnswer = Int.random(in: 0...1)
        let isCorrect = randomAnswer == 1
        
        if isCorrect {
            return answers
                .enumerated()
                //.filter { $1 == answers.values }
                .map { $0.offset }
        } else {
            let randomAnswerIndex = answers.values
                .enumerated()
                .map { $0.offset }
                .randomElement()!
            return [randomAnswerIndex]
        }
    }
    
    func activateAudienceHelp() -> [Int] {
        guard answers.count > 0 else { return [] }
        //let correctAnswerIndex = answers.values.firstIndex(of: answers.values)
        
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
        //percentAnswers.insert(correctAnswerPercent, at: correctAnswerIndex!)
        return percentAnswers
    }
    
}
