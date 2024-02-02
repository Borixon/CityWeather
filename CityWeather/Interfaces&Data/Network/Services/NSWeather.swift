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

    func weather(for city: String) -> Observable<NSCityWeather> {
        requestData(T.weather(["q":city]))
    }
}
