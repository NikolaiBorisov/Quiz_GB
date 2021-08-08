//
//  QuizResultLabel.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 08.08.2021.
//

import UIKit

final class QuizResultLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.numberOfLines = 0
        self.textAlignment = .left
        self.font = UIFont.labelFont20
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.layer.masksToBounds = true
    }
    
}
