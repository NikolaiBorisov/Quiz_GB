//
//  ResultsTableViewController.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

final class ResultsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic()
        setupTableView()
        setupBackButton()
    }
    
    private func playMusic() {
    guard let url = Constants.URL.endMusicURL else { return }
        Player.shared.playSoundOn(vc: url)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemIndigo
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.cellIdentifier)
        title = Constants.VCTitle.resultVCTitle
    }
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Constants.Image.backButtonImage,
            style: .plain,
            target: self,
            action: #selector(onBackButtonTapped(_:))
        )
    }
    
    @objc private func onBackButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.results.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = Game.shared.results[indexPath.row]
        cell.backgroundColor = .systemIndigo
        (cell as? ResultsTableViewCell)?.configure(with: item)
        (cell as? ResultsTableViewCell)?.cellDelegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.cellIdentifier, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if case .delete = editingStyle {
            Game.shared.results.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ResultsCaretaker.delete(row: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

extension ResultsTableViewController: ResultsTableViewCellDelegate {
    
    func didTapOnScoreLabel(scoreLabel: String) {
        print(scoreLabel)
    }
    
}
