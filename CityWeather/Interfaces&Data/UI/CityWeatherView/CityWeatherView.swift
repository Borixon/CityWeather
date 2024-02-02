//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift

struct CityWeatherView: View, ViewProtocol {
    
    typealias CV = CityWeatherContentView
    typealias VM = CityWeatherViewModel
   
    internal var contentView: CityWeatherContentView!
    @ObservedObject var viewModel: CityWeatherViewModel
    
    init() {
        self.viewModel = .init()
        contentView = .init(viewModel: self.viewModel)
    }
    
    var body: some View {
        contentBody
    }
}

#Preview {
    CityWeatherView()
}

