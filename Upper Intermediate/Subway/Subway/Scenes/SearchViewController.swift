//
//  SearchViewController.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit
import Alamofire

// MARK: - View
class SearchViewController: UIViewController {
    
    // MARK: - Properties
    let searchView = SearchView()
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    private var stations: [Row] = []
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        searchView.resultTableView.dataSource = self
        searchView.resultTableView.delegate = self
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요"
        // 서치 컨트롤러 이 외의 부분을 어둡게 표시할 여부 확인
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
}

// MARK: - API
extension SearchViewController {
    private func requestStationData(from stationName: String) {
        let urlString = "http://openapi.seoul.go.kr:8088/\(API_KEY ?? "")/json/SearchInfoBySubwayNameService/1/5/\(stationName)/"
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) {[weak self] response in
            guard case .success(let data) = response.result else { return }
            self?.stations = data.searchInfo.row
            self?.searchView.resultTableView.reloadData()
        }
        .resume()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView.resultTableView.isHidden = false
        searchView.resultTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchView.resultTableView.isHidden = true
        stations = []
        searchView.resultTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationData(from: searchText)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SearchViewCell")
        let station = stations[indexPath.row]
        cell.textLabel?.text = "\(station.stationName)"
        cell.detailTextLabel?.text = "\(station.lineNumber)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(station: stations[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

