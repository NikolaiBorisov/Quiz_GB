//
//  ResultsTableViewCell.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 06.08.2021.
//

import UIKit
import SnapKit

protocol ResultsTableViewCellDelegate: AnyObject {
    func didTapOnScoreLabel(scoreLabel: String)
}

final class ResultsTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "cell"
    weak var cellDelegate: ResultsTableViewCellDelegate?
    
    @objc func onResultLabelTapped() {
        cellDelegate?.didTapOnScoreLabel(scoreLabel: scoreLabel.text ?? "none")
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = QuizResultLabel()
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = QuizResultLabel()
        
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = QuizResultLabel()
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onResultLabelTapped)))
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = QuizStackView()
        [userNameLabel, dateLabel]
            .forEach {stack.addArrangedSubview($0) }
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Result) {
        userNameLabel.text = model.userName
        dateLabel.text = dateFormatter.string(from: model.date)
        scoreLabel.text = String(model.score)
    }
    
    private func setupLayouts() {
        [stackView, scoreLabel]
            .forEach { contentView.addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
}
