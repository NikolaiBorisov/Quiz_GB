//
//  MainViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var viewMaker = MainViewMaker(container: self)
    var gameSession = GameSession()
    private let caretracerQuestion = QuestionsCaretaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic()
        setupHideKeyboardOntaps()
        viewMaker.setupLayouts()
        setupActionForButton()
    }
    
    private func playMusic() {
    guard let url = Constants.URL.beginningMusicURL else { return }
        Player.shared.playSoundOn(vc: url)
    }
    
    private func setupActionForButton() {
        viewMaker.startButton.addTarget(self, action: #selector(onStartButtonTapped(_:)), for: .touchUpInside)
        viewMaker.resultsButton.addTarget(self, action: #selector(onResultsButtonTapped(_:)), for: .touchUpInside)
        viewMaker.settingsButton.addTarget(self, action: #selector(onSettingsButtonTapped(_:)), for: .touchUpInside)
        viewMaker.addButton.addTarget(self, action: #selector(onAddButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onStartButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        let vc = GameViewController()
        vc.gameVCDelegate = self
        let questions = caretracerQuestion.loadQuestions().getQuestions()
        vc.strategy = Game.shared.sequenceIsShuffle ? RandomSequenceStrategy(questions) : SequentiallyStrategy(questions)
        guard let name = viewMaker.nameTF.text else { return }
        if !name.isEmpty {
        vc.title = name
        } else {
            vc.title = Constants.VCTitle.gameVCTitle
        }
        navigationController?.pushViewController(vc, animated: true)
        createGameSession()
    }
    
    private func createGameSession() {
        Game.shared.currentGame = gameSession
    }
    
    @objc private func onResultsButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        let vc = ResultsTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onSettingsButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onAddButtonTapped(_ sender: UIButton) {
        showAlertAddQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension MainViewController: GameViewControllerDelegate {
    func hintsUsed(hint: GameHints) {}
    
    func correctAnswer() {}
    
    func getNumberOfCurrentGame() -> Int { 0 }
    
    func showLastResult(value: Int, name: String) {
        viewMaker.lastResultLabel.text = "Last Score: \(String(value))\nName: \(name)"
    }
    
}

extension MainViewController: GameSessionDelegate {
    
    func didEndGame(allCountQuestion: Int, answerCount: Int) {
        gameSession.countAnswers = answerCount
        gameSession.countQuestion = allCountQuestion
        Game.shared.recordSession()
    }
    
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}

extension MainViewController {
    
    func showAlertAddQuestion() {
        let alert = UIAlertController(
            title: "Добавьте Ваш вопрос",
            message: "Напишите вопрос и ответы к нему. \nПоля должны быть уникальны.",
            preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Вопрос"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Правильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        
        let add = UIAlertAction(
            title: "Добавить",
            style: .default) { (_) in
            
            let question = Question(
                id: 0,
                question: alert.textFields?[0].text ?? "",
                answers: [
                    "\(alert.textFields?[1].text ?? "")" : true,
                    "\(alert.textFields?[2].text ?? "")" : false,
                    "\(alert.textFields?[3].text ?? "")" : false,
                    "\(alert.textFields?[4].text ?? "")" : false
                ]
            )
            try? self.caretracerQuestion.saveQuestion(question)
        }
        add.isEnabled = false
        
        let cancel = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )
        [add, cancel]
            .forEach { alert.addAction($0) }
        
        for i in 0...4 {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: alert.textFields?[i],
                queue: OperationQueue.main
            ) { (notification) -> Void in
                let textFields = alert.textFields?.compactMap { $0.text }
                guard let texts = textFields else {
                    add.isEnabled = false
                    return
                }
                if Set(texts).count == 5, !texts.contains("") {
                    add.isEnabled = true
                } else {
                    add.isEnabled = false
                }
            }
        }
        self.present(alert, animated: true)
    }
    
}
