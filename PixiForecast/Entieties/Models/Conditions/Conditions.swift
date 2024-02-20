//
//  ThunderstormConditions.swift
//  PixiForecast
//
//  Created by Michał Krupa on 15/02/2024.
//

import Foundation


enum ThunderstormConditions: String {
    
    /// Rainy
    case lightRain = "thunderstorm with light rain"
    case rainRain = "thunderstorm with rain"
    case heavyRain = "thunderstorm with heavy rain"
    
    /// No rain?
    case light = "light thunderstorm"
    case regular = "thunderstorm"
    case heavy = "heavy thunderstorm"
    
    /// God knows
    case ragged = "ragged thunderstorm"
    
    /// Light rain / drizzle ("mżawka")
    case lightDrizzle = "thunderstorm with light drizzle"
    case drizzle = "thunderstorm with drizzle"
    case heavyDrizzle = "thunderstorm with heavy drizzle"
}

enum DrizzleConditions: String {
    case lightDrizzle = "light intensity drizzle"
    case drizzle = "drizzle"
    case heavyDrizzle = "heavy intensity drizzle"
    case lightDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyDrizzleRain = "heavy intensity drizzle rain"
    case showerDrizzleRain = "shower rain and drizzle"
    case heavyShowerDrizzleRain = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"
}

enum RainConditions: String {
    case light = "light rain"
    case moderate = "moderate rain"
    case heavy = "heavy intensity rain"
    case veryHeavy = "very heavy rain"
    case extreme = "extreme rain"
    case freezing = "freezing rain"
    case lightShower = "light intensity shower rain"
    case shower = "shower rain"
    case heavyShower = "heavy intensity shower rain"
    case ragged = "ragged shower rain"
}

enum SnowConditions: String {
    
    case light = "light snow"
    case regular = "snow"
    case heavy = "heavy snow"
    case sleet = "sleet"
    
    // snow/rain
    case lightShowerSleet = "light shower sleet"
    case showerSleet = "shower sleet"
    case lightRainSnow = "light rain and snow"
    case rainSnow = "rain and snow"
    
    case lightShower = "light shower snow"
    case shower = "shower snow"
    case heavyShower = "heavy shower snow"
}

enum AthmosphereConditions: String {
    
    case mist
    case smoke
    case haze
    case fog
    
    case sandDust = "sand/dust whirls"
    case sand
    case dust
    
    // WTF
    case volcanic = "volcanic ash"
    
    case squalls
    case tornado
}

enum ClearSkyConditions: String {
    case clear = "clear sky"
}

enum CloudsConditions: String {
    case few = "few clouds"
    case scattered = "scattered clouds"
    case broken = "broken clouds"
    case overcast = "overcast clouds"
}
