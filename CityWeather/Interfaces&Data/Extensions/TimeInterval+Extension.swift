//
//  TimeInterval+Extension.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import Foundation

enum DateFormats: String {
    case time = "HH:mm"
    case date = "dd.MM.yyyy"
    case dayDate = "dd.MM"
    case dayShort = "EEE"
    case dayName = "EEEE"
}

extension TimeInterval {
    
    func format(_ format: DateFormats, for calendar: Calendar = .current) -> String {
        getDateString(format: format.rawValue)
    }
    
    func daysBetween(date: TimeInterval, for calendar: Calendar = .current) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date(timeIntervalSince1970: self))
        let end = calendar.startOfDay(for: Date(timeIntervalSince1970: date))
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    private func getDateString(format: String) -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
