//
//  WeatherDetailsView.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import SwiftUI
import Charts

struct WeatherDetailsView {
    
    @EnvironmentObject var model: WeatherModel
    @EnvironmentObject var router: AppRouter
    
    var closeVisible: Bool = true
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
                    data: model.data.temperatureDetails,
                    margin: 1,
                    step: 1)
                .frame(height: 200)
                
                DataChart(
                    title: "Cloud coverage in '%'",
                    data: model.data.cloudsDetails,
                    max: 100,
                    step: 10)
                .frame(height: 200)
                
                DataChart(
                    title: "Pressure in \(AppData.unitSystem.pressureUnit)",
                    data: model.data.pressureDetails,
                    start: model.data.pressureMinimum,
                    margin: 2,
                    step: 2)
                .frame(height: 200)
                
                DataChart(
                    title: "Visibility in \(AppData.unitSystem.distanceUnit)s",
                    data: model.data.visibilityDetails,
                    step: model.data.visibilityStep)
                .frame(height: 200)
                
                DataChart(
                    title: "Precipation probability in '%'",
                    data: model.data.precipationDetails,
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
        WeatherView()
            .environment(WeatherModel.previewModel)
    } else {
        WeatherView()
    }
}
