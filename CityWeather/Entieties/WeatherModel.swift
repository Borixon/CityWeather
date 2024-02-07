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
    @Published var selectedTime: TimeInterval?
    @Published var isLoading: Bool = false
    @Published var weather: NSCityWeather?
    
    var temperatureDetails: [MinMax<Int>] {
        weather?.temperatures24h(selectedTime) ?? []
    }
    
    var cloudsDetails: [DataValue<Int>] {
        weather?.clouds24h(selectedTime) ?? []
    }
    
    var selectedCityData: CityHeaderData? {
        let time = getCorrespondingTime(selectedTime)
        return weather?.cityData(for: time)
    }
    
    var visibilityDetails: [DataValue<Int>] {
        weather?.visibility24h(selectedTime) ?? []
    }
    
    var visibilityStep: Int {
        Int(Double(visibilityDetails.map { $0.value }.max() ?? 0) / 4.0)
    }
    
    var precipationDetails: [DataValue<Int>] {
        weather?.precipation24h(selectedTime) ?? []
    }
    
    var pressureMinimum: Int {
        (pressureDetails.map { $0.value }.min() ?? 0) - 5
    }
    
    var pressureDetails: [DataValue<Int>] {
        weather?.pressure24h(selectedTime) ?? []
    }
    
    func onStart() {
        resolveWeather(for: cityName)
    }
    
    func getWeather() {
        downloadWeather(for: cityName)
    }
    
    /** 
     This function returns date (as time interval) that is closest to current time
     and moved in time, for calculated number of days
     */
    func getCorrespondingTime(_ time: TimeInterval?) -> TimeInterval {
        guard let time = time,
              let firstDay = weather?.earliestTime else {
            return 0
        }
        let days = firstDay.daysBetween(date: time)
        return firstDay + (Double(days) * 24.0 * 60.0 * 60.0)
    }
    
    func didSelectDate(_ date: TimeInterval) {
        selectedTime = date
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
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectedTime = weather?.earliestTime
        }
        
        // TODO: Save to DB
    }
}

