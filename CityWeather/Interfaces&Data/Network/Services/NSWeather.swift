//
//  NSWeather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import RxMoya
import Moya

final class NSWeather: NetworkServiceProtocol {
    
    typealias T = WeatherTarget
    internal let provider = MoyaProvider<T>()
    
    func getWeather(for city: String) -> Single<Response> {
        request(T.weatherFor(
            params(with: ["q":city]))
        )
    }
    
    func weather(for city: String) -> Single<Weather> {
        
    }
}
