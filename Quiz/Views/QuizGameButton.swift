//
//  QuizHelpButton.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit
import SnapKit

final class QuizGameButton: UIButton {
    
    enum HelpButtonType: String {
        case friendCall = "iphone.homebutton.radiowaves.left.and.right"
        case audienceHelp = "person.3.fill"
        case fiftyFifty = "fifty"
        case sequentially = "arrow.right"
        case shuffle = "shuffle"
        case none = ""
    }
    
    init(type: HelpButtonType) {
        super.init(frame: .zero)
        self.configureSelf(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf(with image: HelpButtonType) {
        self.setImage(UIImage(systemName: image.rawValue), for: .normal)
        self.tintColor = .white
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth =  2
    }
    
}
