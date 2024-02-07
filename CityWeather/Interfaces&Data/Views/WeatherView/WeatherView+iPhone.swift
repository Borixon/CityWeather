//
//  WeatherView+iPhone.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import SwiftUI

extension WeatherView {
      
    @ViewBuilder internal var iPhoneView: some View {
        VStack {
            if !model.isLoading, let data = model.weather {
                contentView(data)
                    .padding(.horizontal, 16)
                
            } else if model.isLoading {
                LoadingView()
                
            } else {
                RetryInfoView() {
                    model.getWeather()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            
            // TODO: Use swiftgen in order to choose images from structs
            Image("Background0")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
        )
    }
    
    @ViewBuilder private func contentView(_ data: NSCityWeather) -> some View {
        Group {
            CityHeader(viewData: data.headerData)
                .padding(.top,8)
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
