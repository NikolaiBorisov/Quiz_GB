//
//  MainViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var viewMaker = MainViewMaker(container: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic()
        setupHideKeyboardOntaps()
        viewMaker.setupLayouts()
        setupActionForButton()
    }
    
    private func playMusic() {
        let url = URL.beginningMusicURL
        Player.shared.playSoundOn(vc: url)
    }
    
    private func setupActionForButton() {
        viewMaker.startButton.addTarget(self, action: #selector(onStartButtonTapped(_:)), for: .touchUpInside)
        viewMaker.resultsButton.addTarget(self, action: #selector(onResultsButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onStartButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        let vc = GameViewController()
        vc.gameVCDelegate = self
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
        let session = GameSession()
        GameSingleton.shared.currentGame = session
    }
    
    @objc private func onResultsButtonTapped(_ sender: UIButton) {
        sender.pulsate()
        let vc = ResultsTableViewController()
        navigationController?.pushViewController(vc, animated: true)
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

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}
