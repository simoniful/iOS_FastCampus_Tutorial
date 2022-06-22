//
//  ViewController.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import UIKit
import Alamofire
import Charts

class MainViewController: UIViewController {

    let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.activityIndicator.startAnimating()
        
        self.fetchCovidOverview { [weak self] result in
            guard let self = self else { return }
            self.mainView.activityIndicator.stopAnimating()
            self.mainView.activityIndicator.isHidden = true
            self.mainView.horizontalStackView1.isHidden = false
            self.mainView.pieChart.isHidden = false
            switch result {
            case let .success(result):
                self.configureStackview(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        }
    }
    
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeonbuk,
            cityCovidOverview.jeonnam,
            cityCovidOverview.jeju
        ]
    }
    
    func configureChartView(covidOverviewList: [CovidOverview]) {
        self.mainView.pieChart.delegate = self
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.85
        dataSet.valueLinePart1Length = 0.35
        dataSet.valueLinePart2Length = 0.05
        dataSet.valueTextColor = .black
        
        dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel() +
            ChartColorTemplates.material()
        
        self.mainView.pieChart.data = PieChartData(dataSet: dataSet)
        self.mainView.pieChart.spin(duration: 0.3, fromAngle: self.mainView.pieChart.rotationAngle, toAngle: self.mainView.pieChart.rotationAngle + 80)
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStackview(koreaCovidOverview: CovidOverview) {
        self.mainView.localCountLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.mainView.localNewCountLabel.text = "\(koreaCovidOverview.newCase) 명"
    }

    // 탈출 클로저를 통한 비동기 작업 수행
    func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let params = [
            "serviceKey": API_KEY
        ]
        AF.request(url, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let decorder = JSONDecoder()
                    let result = try decorder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}

extension MainViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let detailViewController = DetailViewController()
        guard let covidOverview = entry.data as? CovidOverview else { return }
        detailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

