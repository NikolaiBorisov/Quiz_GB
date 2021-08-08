//
//  MainViewMaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit
import SnapKit

final class MainViewMaker {
    
    unowned var container: MainViewController
    init(container: MainViewController) {
        self.container = container
        container.view.backgroundColor = .systemIndigo
    }
    
    lazy var nameTF: UITextField = {
        let tf = QuizTextField()
        tf.delegate = container.self
        
        return tf
    }()
    
    lazy var startButton: UIButton = {
        let button = QuizButton(type: .Start)
        
        return button
    }()
    
    lazy var resultsButton: UIButton = {
        let button = QuizButton(type: .Results)
        
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = QuizStackView()
        [
            startButton,
            resultsButton
        ]
        .forEach {stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    lazy var lastResultLabel: UILabel = {
        let label = QuizLabel()
        
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.spacing = 70
        stackView.distribution = .equalSpacing
        [
            nameTF,
            buttonStackView,
            lastResultLabel
        ]
        .forEach {stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func setupLayouts() {
        container.view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(container.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
    
}
