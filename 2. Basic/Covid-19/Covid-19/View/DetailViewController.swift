//
//  DetailViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/08.
//

import UIKit

class DetailViewController: UITableViewController {
    private let detailView = DetailView()
    private var viewModel: DetailViewModel!
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel(delegate: self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func cellTapped() {
    }
}
