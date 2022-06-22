//
//  DetailViewController.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/17.
//

import Foundation
import UIKit
import Kingfisher

class DetailViewController: UITableViewController {
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = beer?.name ?? "No named beer"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        let headerView = DetailStretchyHeaderView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        headerView.imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        
        tableView.tableHeaderView = headerView
    }
}

extension DetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodPairing?.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tip"
        case 3:
            let isFoodPairingEmpty = beer?.foodPairing?.isEmpty ?? true
            return isFoodPairingEmpty ? nil : "Food Pairing"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DetailListCell")
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = String(beer?.id ?? 0)
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? "No description"
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? "No brewer's tips"
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
            return cell
        default:
            return cell
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = self.tableView.tableHeaderView as? DetailStretchyHeaderView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}

