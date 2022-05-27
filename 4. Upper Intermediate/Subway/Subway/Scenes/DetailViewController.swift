//
//  DetailViewController.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit
import Alamofire

// MARK: - View
final class DetailViewController: UIViewController {
    
    
    private let station: Row
    private var realtimeArrivalList: [RealtimeArrivalList] = []
    let detailView = DetailView()
    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refreshControl
    }()
    
    init(station: Row) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = station.stationName
        detailView.collectionView.dataSource = self
        detailView.collectionView.refreshControl = refreshControl
        fetchData()
    }
}

// MARK: - API
extension DetailViewController {
    @objc private func fetchData() {
        let stationName = station.stationName
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
        
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalResponseModel.self) { [weak self] response in
                self?.refreshControl.endRefreshing()
                guard case .success(let data) = response.result else { return }
                self?.realtimeArrivalList = data.realtimeArrivalList
                self?.detailView.collectionView.reloadData()
            }
            .resume()
    }
}

// MARK: - CollectionView DataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realtimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewCell.identifier, for: indexPath) as? DetailViewCell else { return UICollectionViewCell() }
        let realtimeArrival = realtimeArrivalList[indexPath.item]
        cell.configureCell(with: realtimeArrival)
        return cell
    }
}
