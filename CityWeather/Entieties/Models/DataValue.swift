//
//  DataValue.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import Foundation
import Charts

struct DataValue<T: Strideable & Plottable> {
    var value: T
    var annotation: String
}
