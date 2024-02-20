//
//  WeatherModel+Extension.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation

extension WeatherPresenter: Observable {
    static var previewModel: WeatherPresenter {
        let model = WeatherPresenter()
        model.data.weather = Previews.dbWeather
        return model
    }
}
