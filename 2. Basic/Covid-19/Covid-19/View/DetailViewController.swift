//
//  DetailViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/08.
//

import UIKit

class DetailViewController: UITableViewController {

    let detailView = DetailView()
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.content
    }
}
