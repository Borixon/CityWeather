//
//  NetworkService.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import RxMoya
import Moya

protocol NetworkServiceProtocol: AnyObject {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

extension NetworkServiceProtocol {
    internal func request(_ target: T) -> Single<Response> {
        provider.rx.request(target)
    }
    
    internal func params(with requiredParams: [String:Any]) -> [String:Any] {
        var params = requiredParams
        params["appid"] = API.key
        return params
    }
}
