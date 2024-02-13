//
//  API.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct API {
    static let urlString = "https://api.openweathermap.org"
    static let baseUrl = URL(string: urlString)!
    static let key = "ac5fb59a9596ed2a4ef0f6a04bd33a57"
    
    static func iconUrl(_ icoName: String?) -> URL? {
        guard let icoName = icoName else { return nil }
        return URL(string: "https://openweathermap.org/img/wn/\(icoName)@2x.png")
    }
}
