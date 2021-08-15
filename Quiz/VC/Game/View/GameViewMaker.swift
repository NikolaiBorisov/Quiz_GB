//
//  GameViewMaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit
import SnapKit

final class GameViewMaker {
    
    var answersButtonsArray: [UIButton] {
        return [answer1Button, answer2Button, answer3Button, answer4Button]
    }
    
    unowned var container: GameViewController
    init(container: GameViewController) {
        self.container = container
        container.view.backgroundColor = .systemIndigo
    }
    
    lazy var imageViewContainer: UIImageView = {
        let imageView = QuizImageView()
        
        return imageView
    }()
    
    lazy var friendCallButton: UIButton = {
        let button = QuizGameButton(type: .friendCall)
        
        return button
    }()
    
    lazy var audienceHelpButton: UIButton = {
        let button = QuizGameButton(type: .audienceHelp)
        
        return button
    }()
    
    lazy var fiftyFiftyButton: UIButton = {
        let button = QuizGameButton(type: .fiftyFifty)
        button.setImage(Constants.Image.fiftyFifty, for: .normal)
        
        return button
    }()
    
    lazy var helpButtonStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        [
            friendCallButton,
            audienceHelpButton,
            fiftyFiftyButton
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        [
            imageViewContainer,
            helpButtonStackView
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var questionLabel: UILabel = {
        let label = QuizLabel()
        
        return label
    }()
    
    func roundLabel() {
        questionLabel.layer.cornerRadius = questionLabel.frame.size.height / 2
    }
    
    lazy var answer1Button: UIButton = {
        let button = QuizGameButton(type: .none)
        
        return button
    }()
    
    lazy var answer2Button: UIButton = {
        let button = QuizGameButton(type: .none)
        
        return button
    }()
    
    lazy var answerButtonTopStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.axis = .horizontal
        // спейсинг не работает корректно, если поставить значение 10 в строке 103
        stackView.spacing = 0
        [
            answer1Button,
            answer2Button
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var answer3Button: UIButton = {
        let button = QuizGameButton(type: .none)
        
        return button
    }()
    
    lazy var answer4Button: UIButton = {
        let button = QuizGameButton(type: .none)
        
        return button
    }()
    
    
    lazy var answerButtonBottomStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.axis = .horizontal
        // спейсинг не работает корректно, если поставить значение 10 в строке 130
        stackView.spacing = 0
        [
            answer3Button,
            answer4Button
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var currentComplitionLabel: UILabel = {
        let label = QuizLabel()
        
        return label
    }()
    
    lazy var currentQuestionNumberLabel: UILabel = {
        let label = QuizLabel()
        
        return label
    }()
    
    lazy var currentProgressStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.axis = .horizontal
        // спейсинг не работает корректно, если поставить значение 10 в строке 130
        stackView.spacing = 0
        [
            currentQuestionNumberLabel,
            currentComplitionLabel
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var answerButtonMainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        [
            currentProgressStackView,
            questionLabel,
            answerButtonTopStackView,
            answerButtonBottomStackView
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func cnangeBackgroundColorForButton(with index: Int, and percent: Int) {
        let color = UIColor(red: 0, green: (CGFloat(percent) * 2) / 255, blue: 0, alpha: 1)
        answersButtonsArray[index].backgroundColor = color
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        [
            topStackView,
            answerButtonMainStackView
        ]
        .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func setupLayouts() {
        [
            mainStackView
        ]
        .forEach { container.view.addSubview($0) }
        
        mainStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(container.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.bottom.equalTo(container.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
}
