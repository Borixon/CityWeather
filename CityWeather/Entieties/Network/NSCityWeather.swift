//
//  Weather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSCityWeather: Codable {
    var list: Array<NSWeatherStamp>
    var city: NSCity
}

extension NSCityWeather {
  
    var earliestTime: TimeInterval? {
        list.map { $0.time }.sorted().first
    }
    
    var groupedData: [Date : [NSWeatherStamp]] {
        Dictionary(
            grouping: list,
            by: { Calendar.current.startOfDay(
                for: Date(timeIntervalSince1970: $0.time))
            })
    }
    
    var daysData: Array<DayShortData> {
        let mapped: [DayShortData?] = groupedData.keys.map({
            if let time = groupedData[$0]?.map({ $0.time }).first,
               let atmo = groupedData[$0]?.map({ $0.athmosphere }),
               let min = atmo.map({ $0.tempMin }).min(),
               let max = atmo.map({ $0.tempMax }).max() {
                let pressures = atmo.map({ $0.pressure })
                let averagePressure: Double = Double(pressures.reduce(0, +)) / Double(pressures.count)
                
                return DayShortData(
                    id: time,
                    time: time,
                    day: time.format(.dayShort),
                    date: time.format(.date),
                    tempMin: min,
                    tempMax: max, 
                    pressure: Int16(averagePressure))
                
            } else {
                return nil
            }
        })

        return Array(mapped
            .compactMap { $0 }
            .sorted(by: { $0.time < $1.time })
            .prefix(5))
    }
    
    func cityData(for selected: TimeInterval? = nil) -> CityHeaderData? {
        
        let time: TimeInterval?
        if selected != nil {
            time = selected
        } else {
            time = earliestTime
        }
        
        guard time != nil else { return nil }
        
        let selectedWeather = list.first(where: { $0.time == time })
        let cast = selectedWeather?.weather.first?.description
        let icon = selectedWeather?.weather.first?.icon
        let temperature = selectedWeather?.athmosphere.temperature
        let tempSensed = selectedWeather?.athmosphere.tempSensed
        
        return .init(
            city: city.name,
            time: time!,
            castDescription: cast,
            icon: icon,
            temperature: temperature,
            sensedTemperature: tempSensed,
            sunrise: city.sunrise,
            sunset: city.sunset)
        
    }
    
    func data24h(_ selectedTime: TimeInterval?) -> [NSWeatherStamp] {
        guard let time = selectedTime else {
            return []
        }
        return list.filter {
            $0.time >= time &&
            $0.time < time + (24*60*60)
        }
    }
    
    func clouds24h(_ timeInterval: TimeInterval?) -> [DataValue<Int>] {
        data24h(timeInterval)
            .map({ DataValue(
                value: $0.clouds.coverage.asInt,
                annotation: "\($0.time.format(.time))")})
    }
    
    func visibility24h(_ timeInterval: TimeInterval?) -> [DataValue<Int>] {
        data24h(timeInterval)
            .map({ DataValue(
                value: Int($0.visibility),
                annotation: "\($0.time.format(.time))")})
    }
    
    func precipation24h(_ timeInterval: TimeInterval?) -> [DataValue<Int>] {
        data24h(timeInterval)
            .map({ DataValue(
                value: Int($0.precipation * 100.0), // * 100 is added because range is normalized (0.0...1.0)
                annotation: "\($0.time.format(.time))")})
    }
    
    func pressure24h(_ timeInterval: TimeInterval?) -> [DataValue<Int>] {
        data24h(timeInterval)
            .map({ DataValue(
                value: Int($0.athmosphere.pressure),
                annotation: "\($0.time.format(.time))")})
    }
    
    func temperatures24h(_ timeInterval: TimeInterval?) -> [MinMax<Int>] {
        data24h(timeInterval)
            .map({ MinMax(
                min: Int($0.athmosphere.tempMin),
                max: Int($0.athmosphere.tempMax),
                annotation: "\($0.time.format(.time))")})
    }
}
