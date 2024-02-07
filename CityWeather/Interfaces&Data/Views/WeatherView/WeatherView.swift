//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift

struct WeatherView: View {
    
    @EnvironmentObject internal var model: WeatherModel
    @EnvironmentObject internal var router: AppRouter
    
    var body: some View {
        NavigationView {
            Group {
                if UIDevice().userInterfaceIdiom == .phone {
                    iPhoneView
                } else {
                    iPadView
                }
            }
            .fullScreenCover(
                isPresented: $router.isWeatherDetailsPresented) {
                    WeatherDetailsView(selectedTime: model.selectedTime!)
                        .background(
                            Image("Background0")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
                                .aspectRatio(contentMode: .fill))
            }
        }
        .onAppear() {
            model.onStart()
        }
    }
    
    @ViewBuilder private var iPadView: some View {
        VStack {
            
        }
    }
}
