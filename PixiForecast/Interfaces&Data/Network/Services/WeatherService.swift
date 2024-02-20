//
//  WeatherService.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import CoreLocation
import RxSwift
import RxMoya
import Moya

typealias WeatherServiceAlias = NetworkServiceProtocol & WeatherServiceProtocol

protocol WeatherServiceProtocol {
    func weather(for city: String) -> Observable<NSWeather>
    func weather(for coordinates: CLLocationCoordinate2D) -> Observable<NSWeather>
}

final class WeatherService: WeatherServiceAlias {
    
    typealias T = WeatherTarget
    
    internal let provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = .init()) {
        self.provider = provider
    }
 
    func weather(for city: String) -> Observable<NSWeather> {
        requestData(T.weather(["q":city]))
    }
    
    func weather(for coordinates: CLLocationCoordinate2D) -> Observable<NSWeather> {
        requestData(
            T.weather(["lat": coordinates.latitude,
                       "lon": coordinates.longitude]))
    }
}

final class MockWeatherService: WeatherServiceAlias {
    
    typealias T = WeatherTarget
    
    internal let provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = .init()) {
        self.provider = provider
    }
 
    func weather(for city: String) -> Observable<NSWeather> {
        return Observable.create { observer in
            observer.on(.next(Previews.nsWeather))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
    func weather(for coordinates: CLLocationCoordinate2D) -> Observable<NSWeather> {
        return Observable.create { observer in
            observer.on(.next(Previews.nsWeather))
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
