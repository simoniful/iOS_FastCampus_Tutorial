//
//  FeedViewController.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/28.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    let feedView = FeedView()
    
    override func loadView() {
        super.loadView()
        self.view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        feedView.tableView.dataSource = self
        // feedView.tableView.delegate = self
    }
}

private extension FeedViewController {
    func setNavigationBar() {
        navigationItem.title = "Instagram"
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = uploadButton
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedViewCell.identifier, for: indexPath) as? FeedViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
