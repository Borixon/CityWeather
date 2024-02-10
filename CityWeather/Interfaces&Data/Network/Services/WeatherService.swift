//
//  WeatherService.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import RxMoya
import Moya

final class WeatherService: NetworkServiceProtocol {
    
    typealias T = WeatherTarget
    internal let provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = .init()) {
        self.provider = provider
    }
 
    func weather(for city: String) -> Observable<NSWeather> {
        requestData(T.weather(["q":city]))
    }
}
