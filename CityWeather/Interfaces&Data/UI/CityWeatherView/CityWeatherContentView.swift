//
//  CityWeatherContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 01/02/2024.
//

import SwiftUI

struct CityWeatherContentView: ContentViewProtocol {
    
    typealias VM = CityWeatherViewModel
    
    @ObservedObject var viewModel: CityWeatherViewModel
    
    var iPhoneView: some View {
        Text(viewModel.weather?.city.name ?? "NOPE")
    }
    
    var iPadView: some View {
        Text("iPad \(viewModel.weather?.city.name ?? "NOPE")")
    }
}
