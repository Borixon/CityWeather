//
//  TimeInterval+Extension.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import Foundation

extension TimeInterval {
    
    func timeText(for calendar: Calendar = .current) -> String {
        getDateString(format: "HH:mm")
    }
    
    func dayText(for calendar: Calendar = .current) -> String {
        getDateString(format: "EEE")
    }
    
    func dateText(for calendar: Calendar = .current) -> String {
        getDateString(format: "dd.MM.yyyy")
    }
    
    private func getDateString(format: String) -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
