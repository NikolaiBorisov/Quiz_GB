//
//  QuizLabel.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 08.08.2021.
//

import UIKit

final class QuizLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.numberOfLines = 0
        self.textAlignment = .center
        self.font = UIFont.labelFont20
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.layer.masksToBounds = true
    }
    
}
