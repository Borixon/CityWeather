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
            if !model.isLoading, model.data.weather != nil {
                contentView
                    .padding(Margins.standard)
                
            } else if model.isLoading {
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
            model.updateWeather()
        }
    }
    
    @ViewBuilder private var contentView: some View {
        Group {
            if model.isLandscape == true {
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
        if let daysData = model.data.weather?.daysData {
            ForEach(daysData, id: \.id) { item in
                SmallDayWeatherCell(
                    weatherData: item,
                    selectedTime: model.data.selectedTime)
                .onTapGesture {
                    model.didSelectDate(item.time)
                    model.objectWillChange.send()
                }
            }
            
        } else {
            retryView
        }
    }
    
    @ViewBuilder private var dayList: some View {
        ScrollView(model.isLandscape == true ? .vertical : .horizontal) {
            if model.isLandscape == true {
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
                    viewData: model.data.selectedCityData)
                
                DataRangeChart(
                    title: "Temperatures for 24 hours in \(AppData.unitSystem.tempUnit)",
                    data: model.data.temperatureDetails,
                    margin: 1,
                    step: 1)
            }
            HStack {
                DataChart(
                    title: "Cloud coverage in '%'",
                    data: model.data.cloudsDetails,
                    max: 100,
                    step: 10)
                
                DataChart(
                    title: "Pressure in \(AppData.unitSystem.pressureUnit)",
                    data: model.data.pressureDetails,
                    start: model.data.pressureMinimum,
                    margin: 2,
                    step: 2)
            }
            HStack {
                DataChart(
                    title: "Visibility in \(AppData.unitSystem.distanceUnit)s",
                    data: model.data.visibilityDetails,
                    step: model.data.visibilityStep)
                
                DataChart(
                    title: "Precipation probability in '%'",
                    data: model.data.precipationDetails,
                    max: 100,
                    step: 10)
            }
        }
    }
}
