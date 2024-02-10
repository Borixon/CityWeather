//
//  WeatherModel+Extension.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation

extension WeatherModel: Observable {
    static var previewModel: WeatherModel {
        let model = WeatherModel()
        model.weather = Previews.dbWeather
        return model
    }
}
