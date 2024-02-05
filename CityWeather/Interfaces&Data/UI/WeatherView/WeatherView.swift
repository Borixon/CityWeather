//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift

struct WeatherView: View {
    
    @EnvironmentObject private var model: WeatherModel
    @EnvironmentObject private var router: AppRouter
    
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
                WeatherDetailsView()
            }
        }
        .onAppear() {
            model.onStart()
        }
    }
        
    @ViewBuilder private var iPhoneView: some View {
        VStack {
            if !model.isLoading, let data = model.weather {
                Group {
                    CityHeader(viewData: data.headerData)
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(data.daysData, id: \.id) { item in
                                SpecificDayWeatherCell(
                                    weatherData: item)
                                .onTapGesture {
                                    model.didSelectDate(item.time)
                                    router.isWeatherDetailsPresented = true
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                
            } else if model.isLoading {
                LoadingView()
                
            } else {
                RetryInfoView() {
                    model.getWeather()
                }
            }
        }
    }
    
    @ViewBuilder private var iPadView: some View {
        VStack {
            
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        WeatherView()
            .environment(WeatherModel.previewModel)
    } else {
        WeatherView()
    }
}
