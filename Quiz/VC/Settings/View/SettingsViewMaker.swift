//
//  SettingsViewMaker.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 09.08.2021.
//

import UIKit

final class SettingsViewMaker {
    
    unowned var container: SettingsViewController
    init(container: SettingsViewController) {
        self.container = container
        container.view.backgroundColor = .systemIndigo
    }
    
    lazy var infoLabel: UILabel = {
        let label = QuizLabel()
        label.text = "Choose the sequence of the questions"
        
        return label
    }()
    
    lazy var sequentiallyButton: UIButton = {
        let button = QuizGameButton(type: .sequentially)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    lazy var shuffleButton: UIButton = {
        let button = QuizGameButton(type: .shuffle)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    lazy var settingsButtonStackView: UIStackView = {
        let stackView = QuizStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        [
            infoLabel,
            sequentiallyButton,
            shuffleButton
        ]
        .forEach {stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    func setupLayouts() {
        container.view.addSubview(settingsButtonStackView)
        
        settingsButtonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(172)
        }
    }
    
}
