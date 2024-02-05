//
//  Repository.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import SwiftUI

@MainActor
final class WeatherModel: ObservableObject {
    
    private let bag: DisposeBag = .init()
    private let weatherService = NSWeather()
    
    @Published var cityName: String = "Paris"
    @Published var isLoading: Bool = false
    @Published var weather: NSCityWeather?
    
    func onStart() {
        resolveWeather(for: cityName)
    }
    
    func getWeather() {
        downloadWeather(for: cityName)
    }
    
    func didSelectDate(_ date: TimeInterval) {
        
    }
    
    private func resolveWeather(for city: String) {
        /*
         if DB.weather == nil ||
            DB.weather.cityName != city ||
            DB.weather.updateTime == .isPassed {
            getWeatherFor(city)
         
         } else {
            weather = DB.weather
         }
         */

        downloadWeather(for: city)
    }
    
    private func downloadWeather(for city: String) {
        isLoading = true
        weatherService.weather(for: city)
            .subscribe(onNext: { [unowned self] data in
                handleDataReceive(data)
            }, onError: { [unowned self] error in
                handleDataReceive(nil)
            })
            .disposed(by: bag)
    }
    
    private func handleDataReceive(_ data: NSCityWeather?) {
        weather = data
        isLoading = false
        // TODO: Save to DB
    }
}

