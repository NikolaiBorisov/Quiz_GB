//
//  GameViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

enum GameHints: CaseIterable {
    case fifty, call, audience
}

protocol GameViewControllerDelegate: AnyObject {
    func showLastResult(value: Int, name: String)
    func hintsUsed(hint: GameHints)
    func correctAnswer()
    func getNumberOfCurrentGame() -> Int
}

final class GameViewController: UIViewController {
    
    private lazy var viewMaker = GameViewMaker(container: self)
    private var viewModel = QuestionViewModel()
    weak var gameVCDelegate: GameViewControllerDelegate?
    private let dataSource = GameSingleton.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameVCDelegate = dataSource.currentGame
        playMusic()
        viewMaker.setupLayouts()
        updateUI()
        setupButtonAction()
    }
    
    private func playMusic() {
        let url = URL.gameMusicURL
        Player.shared.playSoundOn(vc: url)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewMaker.roundLabel()
    }
    
    private func setupButtonAction() {
        viewMaker.buttonsArray.forEach {$0.addTarget(
            self,
            action: #selector(onAnswerButtonTapped(_:)),
            for: .touchUpInside
        )}
        viewMaker.fiftyFiftyButton.addTarget(self, action: #selector(onFiftyButtonTapped(_:)), for: .touchUpInside)
        viewMaker.friendCallButton.addTarget(self, action: #selector(onFriendCallButtonTapped(_:)), for: .touchUpInside)
        viewMaker.audienceHelpButton.addTarget(self, action: #selector(onAudienceHelpButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setButtonsTitle() {
        let answers = viewModel.getAnswers()
        for (index, button) in viewMaker.buttonsArray.enumerated() {
            button.setTitle(answers[index], for: .normal)
            button.backgroundColor = .systemIndigo
        }
    }
    
    @objc private func onFiftyButtonTapped(_ sender: UIButton) {
        for (index, _) in viewModel.activateFiftyFifty().enumerated() {
            viewMaker.buttonsArray[index].setTitle("", for: .normal)
        }
    }
    
    @objc private func onFriendCallButtonTapped(_ sender: UIButton) {
        viewMaker.buttonsArray[viewModel.getFriendAdvice()].backgroundColor = .cyan
    }
    
    @objc private func onAudienceHelpButtonTapped(_ sender: UIButton) {
        for (index, percent) in viewModel.getAudienceHelp().enumerated() {
            viewMaker.cnangeBackgroundColorForButton(with: index, and: percent)
        }
    }
    
    @objc private func updateUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.viewMaker.questionLabel.text = self.viewModel.getQuestionText()
            self.setButtonsTitle()
        }
    }
    
    @objc private func onAnswerButtonTapped(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }
        let userGotItRight = viewModel.checkAnswers(userAnswer: senderTitle)
        sender.backgroundColor = userGotItRight ? UIColor.green : UIColor.orange
        GameSingleton.shared.currentGame = nil
        viewModel.moveToTheNextQuestion { [weak self] in
            guard let self = self else { return }
            self.showAlert()
            let score = self.viewModel.getScore()
            let result = Result(
                userName: self.title ?? Constants.DefaultValue.userName,
                date: Date(),
                score: score
            )
            GameSingleton.shared.addResults(result)
            self.gameVCDelegate?.showLastResult(
                value: score,
                name: self.title ?? Constants.DefaultValue.userName
            )
        }
        updateUI()
    }
    
    private func showNextVC() {
        let vc = ResultsTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension GameViewController {
    
    func showAlert() {
        let result = "\(viewModel.getScore())"
        let alert = UIAlertController(
            title: "Правильных ответов:",
            message: result,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
                            title: "Продолжить",
                            style: .destructive,
                            handler: { [weak self] _ in
                                self?.showNextVC()
                            })
        )
        present(alert, animated: true, completion: nil)
    }
    
}
