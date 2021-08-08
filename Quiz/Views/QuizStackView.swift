//
//  QuizStackView.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

final class QuizStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
}
