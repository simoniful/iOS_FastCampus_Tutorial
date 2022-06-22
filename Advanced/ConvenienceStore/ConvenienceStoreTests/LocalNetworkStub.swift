//
//  LocalNetworkStub.swift
//  ConvenienceStoreTests
//
//  Created by Sang hun Lee on 2022/06/13.
//

import Foundation
import RxSwift
import Stubber
@testable import ConvenienceStore

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}



