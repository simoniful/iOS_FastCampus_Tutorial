//
//  DetailViewModel.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/08.
//

import Foundation
import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func cellTapped()
}

class DetailViewModel: NSObject {
    private var tableViewSections = [DetailSection]()
    var covidOverview: CovidOverview?
    static let ReuseIdentifier = "DetailCell"
    private weak var delegate: DetailViewModelDelegate?
    
    init(delegate: DetailViewModelDelegate, covidData: CovidOverview) {
        super.init()
        self.delegate = delegate
        covidOverview = covidData
        configureDatasource(covidData: covidData)
    }
    
    private func configureDatasource(covidData: CovidOverview) {
        let getInTouchSection = DetailSection(
            title: "현황",
            cells: [
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "신규 확진자"
                        cell.detailTextLabel?.text = "\(covidData.newCase) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: { 
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "확진자"
                        cell.detailTextLabel?.text = "\(covidData.totalCase) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "완치자"
                        cell.detailTextLabel?.text = "\(covidData.recovered) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "사망자"
                        cell.detailTextLabel?.text = "\(covidData.death) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "발생률"
                        cell.detailTextLabel?.text = "\(covidData.percentage) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "해외 유입 신규 확진자"
                        cell.detailTextLabel?.text = "\(covidData.newFcase) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                ),
                DetailItem(
                    createdCell: {
                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.ReuseIdentifier)
                        cell.textLabel?.text = "지역 발생 신규 확진자"
                        cell.detailTextLabel?.text = "\(covidData.newCcase) 명"
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.cellTapped() }
                )
            ]
        )
        tableViewSections = [getInTouchSection]
    }
}

extension DetailViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableViewSections[section].cells.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        return cell.createdCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        cell.action?(cell)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.text = tableViewSections[section].title
            headerView.textLabel?.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .bold)
        }
    }
}




