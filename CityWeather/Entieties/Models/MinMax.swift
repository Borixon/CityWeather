//
//  MinMax.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import Foundation
import Charts

struct MinMax<T: Strideable & Plottable> {
    var min: T
    var max: T
    var annotation: String
}
