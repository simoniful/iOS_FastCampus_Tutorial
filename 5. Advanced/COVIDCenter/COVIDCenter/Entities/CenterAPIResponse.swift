//
//  CenterAPIResponse.swift
//  COVIDCenter
//
//  Created by Sang hun Lee on 2022/06/14.
//

import Foundation
import CoreLocation

// MARK: - CenterAPIResponse
struct CenterAPIResponse: Decodable {
    let page, perPage, totalCount, currentCount: Int
    let matchCount: Int
    let data: [Center]
}

// MARK: - Datum
struct Center: Decodable, Hashable {
    let id: Int
    let centerName, sigungu, facilityName: String
    let sido: Sido
    let zipCode, address, lat, lng: String
    let createdAt, updatedAt, org: String
    let centerType: CenterType
    let phoneNumber: String
    
    enum CenterType: String, Decodable {
        case central = "중앙/권역"
        case local = "지역"
    }
    
    // CaseIterable, Identifiable 정리
    enum Sido: String, Decodable, CaseIterable, Identifiable {
        case 서울특별시
        case 부산광역시
        case 대구광역시
        case 인천광역시
        case 광주광역시
        case 대전광역시
        case 울산광역시
        case 세종특별자치시
        case 경기도
        case 강원도
        case 충청북도
        case 충청남도
        case 전라북도
        case 전라남도
        case 경상북도
        case 경상남도
        case 제주특별자치도
        
        var id: String {
            return self.rawValue
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: CLLocationDegrees(self.lat) ?? .zero,
            longitude: CLLocationDegrees(self.lng) ?? .zero
        )
    }
}

