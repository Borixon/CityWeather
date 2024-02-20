//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift
import SnapKit
import CoreLocation

struct WeatherView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject internal var presenter: WeatherPresenter = .init()
    @StateObject internal var router: AppRouter = .init()
    
    var body: some View {
        Group {
            if UIDevice().userInterfaceIdiom == .phone {
                iPhoneView
            } else {
                iPadView
            }
        }
        .onAppear {
            presenter.updateWeather()
        }
    }
}
