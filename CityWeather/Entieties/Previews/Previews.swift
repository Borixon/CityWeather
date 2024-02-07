//
//  Previews.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation

struct Previews {
    
    static var nsWeather: NSCityWeather {
        .init(
            list: [
                NSWeatherStamp(
                    time: 177777777,
                    timeReadable: "2024",
                    weather: [.init(
                        main: "Smog",
                        description: "Smog is dense today",
                        icon: "")],
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
                    visibility: 5000),
                NSWeatherStamp(
                    time: 177780000,
                    timeReadable: "2024",
                    weather: [.init(
                        main: "Smog",
                        description: "Smog is dense today",
                        icon: "")],
                    athmosphere: .init(
                        temperature: 14,
                        tempSensed: 12,
                        tempMin: 11,
                        tempMax: 16,
                        pressure: 1205,
                        humidity: 33),
                    clouds: .init(
                        coverage: 65),
                    wind: .init(
                        speed: 10,
                        gust: 23,
                        degree: 123),
                    precipation: 0.3,
                    visibility: 5000)],
            city: .init(
                name: "Kraków",
                country: "PL",
                sunrise: 177777777,
                sunset: 177779777))
    }
    
    static var dayShortData: DayShortData {
        .init(
            id: 77777777,
            time: 77777777,
            day: "Wt.",
            date: "12.12.2012",
            tempMin: 26,
            tempMax: 32,
            pressure: 1003)
    }
}
