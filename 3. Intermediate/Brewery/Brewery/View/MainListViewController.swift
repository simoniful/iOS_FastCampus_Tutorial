//
//  ViewController.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/17.
//

import UIKit

class MainListViewController: UITableViewController {

    var beerList = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar
        title = "Brewery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MainListCellView.self, forCellReuseIdentifier: MainListCellView.identifier)
        tableView.rowHeight = 150
    }
}

// UITableView DataSource, Delegate
extension MainListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainListCellView.identifier, for: indexPath) as? MainListCellView else { return UITableViewCell() }
        let beer = beerList[indexPath.row]
        cell.configureCell(with: beer)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}

