//
//  QuizTextField.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 08.08.2021.
//

import UIKit

final class QuizTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.textColor = .black
        self.textAlignment = .center
        self.placeholder = Constants.Placeholder.userNameTF
        self.font = UIFont.buttonFont25
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clearButtonMode = .always
    }
    
}
