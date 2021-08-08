//
//  QuizImageView.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 08.08.2021.
//

import UIKit

final class QuizImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.contentMode = .scaleAspectFill
        self.image = Constants.Image.dibrov
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
    
}

