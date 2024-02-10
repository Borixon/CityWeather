//
//  DBWeather.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import RealmSwift
import Foundation

@objcMembers final class DBWeather: Object {
    
    dynamic var id: String = UUID().uuidString
    dynamic var city: DBCity? = .init()
    dynamic var dataPoints = List<DBWeatherDataPoint>()
    
    public override static func primaryKey() -> String? { "id" }
    
    override init() { }
    
    init(_ nsWeather: NSWeather) {
        self.id = nsWeather.city.name
        self.city = DBCity(nsWeather.city)
        self.dataPoints.append(objectsIn: nsWeather.list.map { .init($0) })
    }
    
    var earliestTime: TimeInterval? {
        dataPoints.map { $0.time }.sorted().first
    }
    
    var groupedData: [Date : [DBWeatherDataPoint]] {
        Dictionary(
            grouping: dataPoints,
            by: { Calendar.current.startOfDay(
                for: Date(timeIntervalSince1970: $0.time))
            })
    }
    
    var daysData: Array<DayShortData> {
        let mapped: [DayShortData?] = groupedData.keys.map({
            if let time = groupedData[$0]?.map({ $0.time }).first,
               let min = groupedData[$0]?.map({ $0.tempMin }).min(),
               let max = groupedData[$0]?.map({ $0.tempMax }).max(),
               let pressures = groupedData[$0]?.map({ $0.pressure }) {
                
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
        guard let city = self.city else {
            return nil
        }
        
        let time: TimeInterval?
        if selected != nil {
            time = selected
        } else {
            time = earliestTime
        }
        
        guard time != nil else { return nil }
        
        let selectedWeather = dataPoints.first(where: { $0.time == time })
        let cast = selectedWeather?.weatherDescription
        let icon = selectedWeather?.weatherIcon
        let temperature = selectedWeather?.temperature
        let tempSensed = selectedWeather?.tempSensed
        
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
    
    func data24h(_ selectedTime: TimeInterval?) -> [DBWeatherDataPoint] {
        guard let time = selectedTime else {
            return []
        }
        return dataPoints.filter {
            $0.time >= time &&
            $0.time < time + (24*60*60)
        }
    }
    
    func clouds24h(_ timeInterval: TimeInterval?) -> [DataValue<Int>] {
        data24h(timeInterval)
            .map({ DataValue(
                value: $0.cloudCoverage.asInt,
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
                value: Int($0.pressure),
                annotation: "\($0.time.format(.time))")})
    }
    
    func temperatures24h(_ timeInterval: TimeInterval?) -> [MinMax<Int>] {
        data24h(timeInterval)
            .map({ MinMax(
                min: Int($0.tempMin),
                max: Int($0.tempMax),
                annotation: "\($0.time.format(.time))")})
    }
}
