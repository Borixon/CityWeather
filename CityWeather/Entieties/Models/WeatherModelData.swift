//
//  WeatherModelData.swift
//  CityWeather
//
//  Created by Michał Krupa on 12/02/2024.
//

import Foundation
import SwiftUI

class WeatherModelData {
    
    @Published var weather: DBWeather? = nil
    @Published var selectedTime: TimeInterval? = nil
    
    func update(_ dataModel: DBWeather?) {
        weather = dataModel
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectedTime = weather?.earliestTime
        }
    }
    
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
    
    private func getCorrespondingTime(_ time: TimeInterval?) -> TimeInterval {
        guard let time = time,
              let firstDay = weather?.earliestTime else {
            return 0
        }
        let days = firstDay.daysBetween(date: time)
        return firstDay + (Double(days) * 24.0 * 60.0 * 60.0)
    }
}
