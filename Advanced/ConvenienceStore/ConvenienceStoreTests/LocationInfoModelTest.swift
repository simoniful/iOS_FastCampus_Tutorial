//
//  LocationInfoModelTest.swift
//  ConvenienceStoreTests
//
//  Created by Sang hun Lee on 2022/06/13.
//

import XCTest
import Nimble

@testable import ConvenienceStore

class LocationInfoModelTest: XCTestCase {
    let stubNetwork = LocalNetworkStub()
    
    var doc: [KLDocument]!
    var model: LocationInfoModel!
    
    override func setUp() {
        self.model = LocationInfoModel(localNetwork: stubNetwork)
        self.doc = cvsList
    }
    
    func testDocumentsToCellData() {
        // 실제 모델의 값
        let cellData = model.documentsToCellData(doc)
        // dummy의 값
        let placeName = doc.map { $0.placeName }
        // 실제 모델의 값
        let address0 = cellData[1].address
        // dummy의 값
        let roadAddressName = doc[1].roadAddressName
        
        expect(cellData.map { $0.placeName }).to(
            equal(placeName),
            description: "DetailListCellData의 placeName은 document의 PlaceName이다."
        )
        
        expect(address0).to(
            equal(roadAddressName),
            description: "KLDocument의 RoadAddressName이 빈 값이 아닐 경우 roadAdderss가 cellData에 전달된다."
        )
    }
}
