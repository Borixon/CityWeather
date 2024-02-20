//
//  WeatherView+iPad.swift
//  CityWeather
//
//  Created by Michał Krupa on 07/02/2024.
//

import SwiftUI

extension WeatherView {

    @ViewBuilder internal var iPadView: some View {
        Group {
            if !presenter.isLoading, presenter.data.weather != nil {
                contentView
                    .padding(Margins.standard)
                
            } else if presenter.isLoading {
                LoadingView()
                
            } else {
                retryView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            // TODO: Use swiftgen in order to choose images from structs
            Image("Background1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
        )
    }
    
    @ViewBuilder private var retryView: some View {
        RetryInfoView() {
            presenter.updateWeather()
        }
    }
    
    @ViewBuilder private var contentView: some View {
        Group {
            if presenter.isLandscape == true {
                HStack {
                    details
                    dayList
                }
            } else {
                VStack {
                    details
                    dayList
                }
            }
        }
    }
    
    @ViewBuilder private var dayListContent: some View {
        if let daysData = presenter.data.weather?.daysData {
            ForEach(daysData, id: \.id) { item in
                SmallDayWeatherCell(
                    weatherData: item,
                    selectedTime: presenter.data.selectedTime)
                .onTapGesture {
                    presenter.didSelectDate(item.time)
                    presenter.objectWillChange.send()
                }
            }
            
        } else {
            retryView
        }
    }
    
    @ViewBuilder private var dayList: some View {
        ScrollView(presenter.isLandscape == true ? .vertical : .horizontal) {
            if presenter.isLandscape == true {
                LazyVStack {
                    dayListContent
                }
                .frame(width: 180)
            } else {
                LazyHStack {
                    dayListContent
                }
                .frame(height: 180)
            }
        }
    }
    
    @ViewBuilder private var details: some View {
        VStack {
            HStack {
                CityHeader(
                    viewData: presenter.data.selectedCityData)
                
                DataRangeChart(
                    title: "Temperatures for 24 hours in \(AppData.unitSystem.tempUnit)",
                    data: presenter.data.temperatureDetails,
                    margin: 1,
                    step: 1)
            }
            HStack {
                DataChart(
                    title: "Cloud coverage in '%'",
                    data: presenter.data.cloudsDetails,
                    max: 100,
                    step: 10)
                
                DataChart(
                    title: "Pressure in \(AppData.unitSystem.pressureUnit)",
                    data: presenter.data.pressureDetails,
                    start: presenter.data.pressureMinimum,
                    margin: 2,
                    step: 2)
            }
            HStack {
                DataChart(
                    title: "Visibility in \(AppData.unitSystem.distanceUnit)s",
                    data: presenter.data.visibilityDetails,
                    step: presenter.data.visibilityStep)
                
                DataChart(
                    title: "Precipation probability in '%'",
                    data: presenter.data.precipationDetails,
                    max: 100,
                    step: 10)
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
