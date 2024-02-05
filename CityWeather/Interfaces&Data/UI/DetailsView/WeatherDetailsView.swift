//
//  WeatherDetailsView.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import SwiftUI

struct WeatherDetailsView: View {
    
    @EnvironmentObject var model: WeatherModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        Button("Back", action: {
            router.isWeatherDetailsPresented = false
        })
        Text("We are here!")
    }
}
