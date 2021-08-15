//
//  QuestionsCaretaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 09.08.2021.
//

import Foundation

class QuestionsCaretaker {
    typealias Memento = Data
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    lazy var questions: Questions = {
        return loadQuestions()
    }()
    
    func saveQuestion(_ question: Question) throws {
        let id = questions.questions.count + questions.userQuestions.count
        let newQuestion = (Question(id: id, question: question.question, answers: question.answers))
        questions.userQuestions.append(newQuestion)
        let data: Memento = try encoder.encode(questions.userQuestions)
        UserDefaults.standard.set(data, forKey: Constants.Keys.questions.rawValue)
        print("User question has been successfully saved")
    }
    
    func loadQuestions() -> Questions {
        guard
            let data = UserDefaults.standard.value(forKey: Constants.Keys.questions.rawValue) as? Memento,
            let userQuestions = try? decoder.decode([Question].self, from: data)
        else {
            return Questions()
        }
        
        var questions = Questions()
        questions.userQuestions = userQuestions
        
        return questions
    }
    
}
