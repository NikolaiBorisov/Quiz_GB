//
//  GameViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func showLastResult(value: Int, name: String)
    func hintsUsed(hint: GameHints)
    func correctAnswer()
    func getNumberOfCurrentGame() -> Int
}

protocol GameSessionDelegate: AnyObject {
    var gameSession: GameSession { get set }
    func didEndGame(allCountQuestion: Int, answerCount: Int)
}

final class GameViewController: UIViewController {
    
    private lazy var viewMaker = GameViewMaker(container: self)
    weak var gameVCDelegate: GameViewControllerDelegate?
    weak var gameSessionDelegate: GameSessionDelegate?
    
    var strategy: SequenceStrategy!
    private var questions = [Question]()
    private var question: Question?
    private var answers = [String]()
    private var countAnswer = Observable<Int>(0)
    private var countQuestions = 0
    var questionModel: Questions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        playMusic()
        viewMaker.setupLayouts()
        setupButtonAction()
        setQuestions()
        updateUI()
    }
    
    private func setupObserver() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.questions = self.strategy.getQuestions()
            self.countAnswer.value = 0
            self.countQuestions = self.questions.count
            self.countAnswer.addObserver(self, options: [.new, .initial]) { [weak self] (countAnswer, _) in
                guard let self = self else { return }
                self.viewMaker.currentComplitionLabel.text = "Выполнено:\n\(Int((Float(countAnswer) / Float(self.countQuestions)) * 100))%"
            }
        }
    }
    
    private func playMusic() {
        guard let url = Constants.URL.gameMusicURL else { return }
        Player.shared.playSoundOn(vc: url)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewMaker.roundLabel()
    }
    
    private func setupButtonAction() {
        viewMaker.answersButtonsArray.forEach {$0.addTarget(
            self,
            action: #selector(onAnswerButtonTapped(_:)),
            for: .touchUpInside
        )}
        viewMaker.fiftyFiftyButton.addTarget(self, action: #selector(onFiftyButtonTapped(_:)), for: .touchUpInside)
        viewMaker.friendCallButton.addTarget(self, action: #selector(onFriendCallButtonTapped(_:)), for: .touchUpInside)
        viewMaker.audienceHelpButton.addTarget(self, action: #selector(onAudienceHelpButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onFiftyButtonTapped(_ sender: UIButton) {
        //        for (index, _) in questionModel?.activateFiftyFifty().enumerated() {
        //                    viewMaker.buttonsArray[index].setTitle("", for: .normal)
        //                }
    }
    
    @objc private func onFriendCallButtonTapped(_ sender: UIButton) {
        //viewMaker.answersButtonsArray[(questionModel?.getFriendAdvice())].backgroundColor = .cyan
    }
    
    @objc private func onAudienceHelpButtonTapped(_ sender: UIButton) {
        //        for (index, percent) in questionModel?.getAudienceHelp().enumerated() {
        //                    viewMaker.cnangeBackgroundColorForButton(with: index, and: percent)
        //                }
    }
    
    @objc private func onAnswerButtonTapped(_ sender: UIButton) {
        guard let senderTitle = sender.titleLabel?.text else { return }
        let userGotItright = answers.contains(senderTitle)
        sender.backgroundColor = userGotItright ? UIColor.green : UIColor.red
        if answers.contains(senderTitle) {
            countAnswer.value += 1
            if !questions.isEmpty {
                setQuestions()
            } else {
                gameSessionDelegate?.didEndGame(
                    allCountQuestion: countQuestions,
                    answerCount: countAnswer.value
                )
                print("End of Game")
                self.showResult(countCorrectAnswer: countAnswer.value, countAllAnswers: countQuestions)
                resultHandler()
            }
        } else {
            gameSessionDelegate?.didEndGame(
                allCountQuestion: countQuestions,
                answerCount: countAnswer.value
            )
            self.showResult(countCorrectAnswer: countAnswer.value, countAllAnswers: countQuestions)
            resultHandler()
        }
        updateUI()
    }
    
    private func resultHandler() {
        let result = Result(
            userName: title ?? Constants.DefaultValue.userName,
            date: Date(),
            score: countAnswer.value
        )
        Game.shared.addResults(result)
        gameVCDelegate?.showLastResult(
            value: countAnswer.value,
            name: title ?? Constants.DefaultValue.userName
        )
    }
    
    private func updateUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.viewMaker.answersButtonsArray.forEach { $0.backgroundColor = .systemIndigo }
        }
    }
    
    private func setQuestions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.question = self.questions.removeFirst()
            guard let question = self.question else { return }
            self.viewMaker.currentQuestionNumberLabel.text = "Номер вопроса:\n\(question.id)"
            self.viewMaker.questionLabel.text = question.question
            let answers = Array(question.answers)
            self.viewMaker.answersButtonsArray.enumerated()
                .forEach { button in
                    button.element.setTitle(answers[button.offset].key, for: .normal)
                }
            self.answers = answers
                .filter { $0.value == true }
                .map { $0.key }
        }
    }
    
    private func showNextVC() {
        let vc = ResultsTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension GameViewController {
    
    func showResult(countCorrectAnswer: Int, countAllAnswers: Int) {
        let alert = UIAlertController(
            title: "Итог",
            message: "Правильных ответов: \(countCorrectAnswer)\nВсего вопросов: \(countAllAnswers)",
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
