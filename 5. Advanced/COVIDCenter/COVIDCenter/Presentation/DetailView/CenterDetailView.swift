//
//  CenterDetailView.swift
//  COVIDCenter
//
//  Created by Sang hun Lee on 2022/06/14.
//

import SwiftUI

struct CenterDetailView: View {
    var center: Center
    
    var body: some View {
        VStack {
            MapView(coordination: center.coordinate)
                .ignoresSafeArea(edges: .all)
                .frame(maxWidth: .infinity,  maxHeight: .infinity)
            CenterRow(center: center)
        }
        .navigationTitle(center.facilityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CenterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(address: "서울특별시 뫄뫄구 뫄뫄동", centerName: "코로나19 경기도 시흥시 예방접종센터", centerType: .지역, createdAt: "2021-07-16 04:55:59", facilityName: "시흥국민체육센터", id: 283, lat: "37.3916531", lng: "126.8053548", org: "", phoneNumber: "031-310-6822", sigungu: "시흥시", updatedAt:  "2021-07-16 04:55:59", sido: .경기도, zipCode: "14976")
        CenterDetailView(center: center0)
    }
}
