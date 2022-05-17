//
//  ViewController.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/17.
//

import UIKit

class MainListViewController: UITableViewController {

    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar
        title = "Brewery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MainListCellView.self, forCellReuseIdentifier: MainListCellView.identifier)
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        
        fetchData(of: currentPage)
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
        print("Rows: \(indexPath.row)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}

// 미리 셀을 불러오는 역할
extension MainListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1) / 25 + 1 == currentPage {
                self.fetchData(of: currentPage)
            }
        }
    }
}

private extension MainListViewController {
    func fetchData(of page: Int) {
        // 한번 요청된 적이 있는 것에 대한 분류
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: {$0.originalRequest?.url == url }) == nil else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR, URLSession dataTask: \(error?.localizedDescription)")
                return
            }
            
            switch response.statusCode {
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499):
                print("""
                    ERROR, Client ERROR: \(response.statusCode)
                    Response: \(response)
                """)
            case (500...599):
                print("""
                    ERROR, Server ERROR: \(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR: \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}


