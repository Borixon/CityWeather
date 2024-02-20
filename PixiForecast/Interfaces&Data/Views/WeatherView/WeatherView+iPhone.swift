//
//  WeatherView+iPhone.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import SwiftUI

extension WeatherView {
    
    @ViewBuilder internal var iPhoneView: some View {
        NavigationView {
            VStack {
                if !presenter.isLoading, let data = presenter.data.weather {
                    contentView(data)
                        .padding(.horizontal, 16)
                    
                } else if presenter.isLoading {
                    LoadingView()
                    
                } else {
                    RetryInfoView() {
                        presenter.updateWeather()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Group {
                    if let data = presenter.data.weather?.city {
                        OutdoorsView(data)
                            .edgesIgnoringSafeArea(.all)
                    } else {
                        Text("NO data")
                    }
                }
                
            )
        }
        .fullScreenCover(isPresented: $router.isWeatherDetailsPresented) {
            WeatherDetailsView(
                model: presenter,
                router: router)
        }
    }
    
    @ViewBuilder private func contentView(_ data: DBWeather) -> some View {
        Group {
            CityHeader(viewData: data.cityData())
                .padding(.top,8)
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(data.daysData, id: \.id) { item in
                        DayWeatherCell(
                            weatherData: item)
                        .onTapGesture {
                            presenter.didSelectDate(item.time)
                            router.isWeatherDetailsPresented = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherView(presenter:
            .init(interactor:
                    .init(webService: MockWeatherService())
            )
    )
}
