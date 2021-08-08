//
//  QuizButton.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

final class QuizButton: UIButton {
    
    enum QuizButtonType: String {
        case Start
        case Results
    }
    
    init(type: QuizButtonType) {
        super.init(frame: .zero)
        self.configureSelf(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf(with type: QuizButtonType) {
        self.setTitle(type.rawValue, for: .normal)
        self.titleLabel?.font = UIFont.buttonFont25
        self.titleLabel?.textAlignment = .center
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .purple
    }
    
}
