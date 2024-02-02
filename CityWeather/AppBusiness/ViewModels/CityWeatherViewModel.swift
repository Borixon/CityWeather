//
//  Repository.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import SwiftUI

final class CityWeatherViewModel: ObservableObject, ViewModelProtocol {
    
    @Published var weather: NSCityWeather? = nil
    @Published var detailsPresented: Bool = false
    
    let bag: DisposeBag = .init()
    
    private let weatherService = NSWeather()
    
    func onStart() {
        resolveWeather(for: "Paris")
    }
    
    private func resolveWeather(for city: String) {
        /*
         if DB.weather == nil ||
            DB.weather.cityName != city ||
            DB.weather.updateTime == .isPassed {
            /* GET NEW STUFF FROM YOURNETWORK */
         
         } else {
            weather = DB.weather
         }
         */
        
        weather = .init(
            list: [.init(
                time: 177777777,
                timeReadable: "2024",
                weather: [.init(
                    main: "Smog",
                    description: "Is everywhere")],
                athmosphere: .init(
                    temperature: 15,
                    tempSensed: 10,
                    tempMin: 10,
                    tempMax: 15,
                    pressure: 1200,
                    humidity: 30),
                clouds: .init(
                    coverage: 60),
                wind: .init(
                    speed: 10,
                    gust: 23,
                    degree: 123),
                precipation: 0.3,
                visibility: 5000)],
            city: .init(
                name: city,
                country: "PL",
                sunrise: 177777777,
                sunset: 177779777))

        // getWeatherFor(city)
    }
    
    private func getWeatherFor(_ city: String) {
        weatherService.weather(for: city)
            .subscribe(onNext: { data in
                self.weather = data
            }, onError: { error in
                self.weather = nil
            }, onDisposed: {
                print("DISPOSED")
            })
            .disposed(by: bag)
    }
}

