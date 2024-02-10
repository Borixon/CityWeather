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
            if !model.isLoading, model.weather != nil {
                contentView
                    .padding(Margins.standard)
                
            } else if model.isLoading {
                LoadingView()
                
            } else {
                RetryInfoView() {
                    model.updateWeather()
                }
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
    
    @ViewBuilder private var contentView: some View {
        Group {
            if isLandscape {
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
        ForEach(model.weather!.daysData, id: \.id) { item in
            SmallDayWeatherCell(
                weatherData: item,
                selectedTime: model.selectedTime)
            .onTapGesture {
                model.didSelectDate(item.time)
            }
        }
    }
    
    @ViewBuilder private var dayList: some View {
        ScrollView(isLandscape ? .vertical : .horizontal) {
            if isLandscape {
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
                    viewData: model.selectedCityData)
                
                DataRangeChart(
                    title: "Temperatures for 24 hours in \(AppData.unitSystem.tempUnit)",
                    data: model.temperatureDetails,
                    margin: 1,
                    step: 1)
            }
            HStack {
                DataChart(
                    title: "Cloud coverage in '%'",
                    data: model.cloudsDetails,
                    max: 100,
                    step: 10)
                
                DataChart(
                    title: "Pressure in \(AppData.unitSystem.pressureUnit)",
                    data: model.pressureDetails,
                    start: model.pressureMinimum,
                    margin: 2,
                    step: 2)
            }
            HStack {
                DataChart(
                    title: "Visibility in \(AppData.unitSystem.distanceUnit)s",
                    data: model.visibilityDetails,
                    step: model.visibilityStep)
                
                DataChart(
                    title: "Precipation probability in '%'",
                    data: model.precipationDetails,
                    max: 100,
                    step: 10)
            }
        }
    }
    
    private var isLandscape: Bool {
        iOrientation == .landscapeLeft || iOrientation == .landscapeRight
    }
}
