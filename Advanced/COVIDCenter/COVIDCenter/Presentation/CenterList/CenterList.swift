//
//  CenterList.swift
//  COVIDCenter
//
//  Created by Sang hun Lee on 2022/06/14.
//

import SwiftUI

struct CenterList: View {
    var centers = [Center]()
    
    var body: some View {
        List(centers, id: \.id) { center in
            NavigationLink(destination: CenterDetailView(center: center)) {
                CenterRow(center: center)
            }
            .navigationTitle(center.sido.rawValue)
        }
    }
}

struct CenterList_Previews: PreviewProvider {
    static var previews: some View {
        var centers = [
            Center(address: "서울특별시 뫄뫄구 뫄뫄동", centerName: "코로나19 경기도 시흥시 예방접종센터", centerType: .지역, createdAt: "2021-07-16 04:55:59", facilityName: "시흥국민체육센터", id: 283, lat: "37.3916531", lng: "126.8053548", org: "", phoneNumber: "031-310-6822", sigungu: "시흥시", updatedAt:  "2021-07-16 04:55:59", sido: .경기도, zipCode: "14976"),
            Center(address: "서울특별시 뫄뫄구 뫄뫄동", centerName: "코로나19 경기도 시흥시 예방접종센터", centerType: .지역, createdAt: "2021-07-16 04:55:59", facilityName: "시흥국민체육센터", id: 283, lat: "37.3916531", lng: "126.8053548", org: "", phoneNumber: "031-310-6822", sigungu: "시흥시", updatedAt:  "2021-07-16 04:55:59", sido: .경기도, zipCode: "14976"),
            Center(address: "서울특별시 뫄뫄구 뫄뫄동", centerName: "코로나19 경기도 시흥시 예방접종센터", centerType: .지역, createdAt: "2021-07-16 04:55:59", facilityName: "시흥국민체육센터", id: 283, lat: "37.3916531", lng: "126.8053548", org: "", phoneNumber: "031-310-6822", sigungu: "시흥시", updatedAt:  "2021-07-16 04:55:59", sido: .경기도, zipCode: "14976")
        ]
        
        CenterList(centers: centers)
    }
}
