//
//  MapView.swift
//  COVIDCenter
//
//  Created by Sang hun Lee on 2022/06/14.
//

import SwiftUI
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordination: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    @State private var annotationItems = [AnnotationItem]()
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordination)],
            annotationContent: {
                MapMarker(coordinate: $0.coordinate, tint: .indigo)
            }
        )
        .onAppear {
            setRegion(coordination)
            setAnnotationItems(coordination)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    }
    
    private func setAnnotationItems(_ coordinate: CLLocationCoordinate2D) {
        annotationItems = [AnnotationItem(coordinate: coordinate)]
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(address: "서울특별시 뫄뫄구 뫄뫄동", centerName: "코로나19 경기도 시흥시 예방접종센터", centerType: .지역, createdAt: "2021-07-16 04:55:59", facilityName: "시흥국민체육센터", id: 283, lat: "37.3916531", lng: "126.8053548", org: "", phoneNumber: "031-310-6822", sigungu: "시흥시", updatedAt:  "2021-07-16 04:55:59", sido: .경기도, zipCode: "14976")
        
        MapView(coordination: center0.coordinate)
    }
}
