//
//  DetailViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/08.
//

import UIKit

class DetailViewController: UITableViewController {
    var covidOverview: CovidOverview?
    
    private let detailView = DetailView()
    private var viewModel: DetailViewModel!
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let covidOverview = self.covidOverview else { return }
        self.title = covidOverview.countryName
        viewModel = DetailViewModel(delegate: self, covidData: covidOverview)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func cellTapped() {
        print("Tapped Cell")
    }
}
