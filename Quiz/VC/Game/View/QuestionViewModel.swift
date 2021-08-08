//
//  QuestionViewModel.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import Foundation

final class QuestionViewModel {
    
    var questionNumber = 0
    var score = 0
    
    let questionsArray = [
        Question(
            text: "1. Когда был создан язык Swift?",
            answers: ["2010", "2011", "2013", "2014"],
            correctAnswer: "2014",
            correctAnswerIndex: 3),
        Question(
            text: "2. Кто является автором и разработчиком языка Swift?",
            answers: ["Крейг Федериги", "Стив Джобс", "Крис Латтнер", "Билл Гейтс"],
            correctAnswer: "Крис Латтнер",
            correctAnswerIndex: 2),
        Question(
            text: "3. Наследником какого языка является Swift?",
            answers: ["C", "C++", "C#", "Ruby"],
            correctAnswer: "C",
            correctAnswerIndex: 0),
        Question(
            text: "4. Какое расширение файлов у языка Swift?",
            answers: [".xcode", ".swift", ".xcodeproj", ".xcworkspace"],
            correctAnswer: ".swift",
            correctAnswerIndex: 1),
        Question(
            text: "5. На каком языке написана основная кодовая база Apple?",
            answers: ["Swift", "C", "Objective-C", "C++"],
            correctAnswer: "Objective-C",
            correctAnswerIndex: 2)
    ]
    
    func getQuestionText() -> String {
        questionsArray[questionNumber].text
    }
    
    func getAnswers() -> [String] {
        questionsArray[questionNumber].answers
    }
    
    func getScore() -> Int {
        score
    }
    
    func moveToTheNextQuestion(alertCallback: @escaping (() -> Void)) {
        if questionNumber + 1 < questionsArray.count {
            questionNumber += 1
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alertCallback()
            }
        }
    }
    
    func checkAnswers(userAnswer: String) -> Bool {
        if userAnswer == questionsArray[questionNumber].correctAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getFriendAdvice() -> Int {
        return questionsArray[questionNumber].friendCall
    }
    
    func getAudienceHelp() -> [Int] {
        return questionsArray[questionNumber].activateAudienceHelp()
    }
    
    func activateFiftyFifty() -> [Int] {
        return questionsArray[questionNumber].removeTwoWrongAnswers()
    }
    
}
