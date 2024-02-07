//
//  WeatherDetailsView.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import SwiftUI
import Charts
import SwiftUICharts

struct WeatherDetailsView {
    
    @EnvironmentObject var model: WeatherModel
    @EnvironmentObject var router: AppRouter
    
    var closeVisible: Bool = true
    var selectedTime: TimeInterval
    
    var temperatureData: [MinMax<Int>] {
        model.weather?.temperatures24h(selectedTime) ?? []
    }

    var cloudsData: [DataValue<Int>] {
        model.weather?.clouds24h(selectedTime) ?? []
    }
    
    var visibilityData: [DataValue<Int>] {
        model.weather?.visibility24h(selectedTime) ?? []
    }
    
    var visibilityStep: Int {
        Int(Double(visibilityData.map { $0.value }.max() ?? 0) / 4.0)
    }
    
    var precipationData: [DataValue<Int>] {
        model.weather?.precipation24h(selectedTime) ?? []
    }
    
    var pressureMinimum: Int {
        (pressureData.map { $0.value }.min() ?? 0) - 5
    }
    
    var pressureData: [DataValue<Int>] {
        model.weather?.pressure24h(selectedTime) ?? []
    }
}

extension WeatherDetailsView: View {
    
    var body: some View {
        Group {
            if closeVisible {
                closeBar
            }
            contentView
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder private var contentView: some View {
        ScrollView {
            VStack(spacing: 24) {
                DataRangeChart(
                    title: "Temperatures for 24 hours in \(AppData.unitSystem.tempUnit)",
                    data: temperatureData,
                    margin: 1,
                    step: 1)
                .frame(height: 200)
                
                DataChart(
                    title: "Cloud coverage in '%'",
                    data: cloudsData,
                    max: 100,
                    step: 10)
                .frame(height: 200)
                
                DataChart(
                    title: "Pressure in \(AppData.unitSystem.pressureUnit)",
                    data: pressureData,
                    start: pressureMinimum,
                    margin: 2,
                    step: 2)
                .frame(height: 200)
                
                DataChart(
                    title: "Visibility in \(AppData.unitSystem.distanceUnit)s",
                    data: visibilityData,
                    step: visibilityStep)
                .frame(height: 200)
                
                DataChart(
                    title: "Precipation probability in '%'",
                    data: precipationData,
                    max: 100,
                    step: 10)
                .frame(height: 200)
            }
        }
    }
    
    @ViewBuilder private var closeBar: some View {
        HStack {
            Spacer()
            Button("", systemImage: "xmark", action: {
                router.isWeatherDetailsPresented = false
            })
            .foregroundStyle(.white)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        WeatherDetailsView(selectedTime: 17777)
            .environment(WeatherModel.previewModel)
    } else {
        WeatherDetailsView(selectedTime: 17777)
    }
}
