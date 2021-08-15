//
//  SettingsViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 09.08.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private lazy var viewMaker = SettingsViewMaker(container: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewMaker.setupLayouts()
        setupActionForButton()
    }
    
    private func setupActionForButton() {
        viewMaker.sequentiallyButton.addTarget(self, action: #selector(onSequentiallyButtonTapped(_:)), for: .touchUpInside)
        viewMaker.shuffleButton.addTarget(self, action: #selector(onShuffleButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func onSequentiallyButtonTapped(_ sender: UIButton) {
        viewMaker.shuffleButton.isHidden = true
        Game.shared.sequenceIsShuffle.toggle()
        showAlert(for: sender)
    }
    
    @objc private func onShuffleButtonTapped(_ sender: UIButton) {
        viewMaker.sequentiallyButton.isHidden = true
        Game.shared.sequenceIsShuffle.toggle()
        showAlert(for: sender)
    }

}

extension SettingsViewController {
    
    func showAlert(for button: UIButton) {
        switch button {
        case viewMaker.sequentiallyButton:
            let alert = UIAlertController(title: "Note", message: "The questions will be shown sequentially", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
        case viewMaker.shuffleButton:
            let alert = UIAlertController(title: "Note", message: "The questions will be shown randomly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
        default: break
        }
    }
    
}
