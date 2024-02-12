//
//  SmallDayWeatherCell.swift
//  CityWeather
//
//  Created by Michał Krupa on 07/02/2024.
//

import SwiftUI

struct SmallDayWeatherCell: View {
    
    let weatherData: DayShortData
    let selectedTime: TimeInterval?
    
    var isSelected: Bool {
        selectedTime == weatherData.time
    }
    
    var background: some View {
        Group {
            if isSelected {
                Background.selectedBox
            } else {
                Background.box
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(weatherData.time.format(.dayShort).capitalized)
                .foregroundStyle(.white)
                .padding(.top, 8)
                .font(Font.system(
                    size: 30,
                    weight: .light))
            
            Text(weatherData.time.format(.date))
                .font(Font.system(size: 12))
                .foregroundStyle(.white)
                .padding(.top, 0)
                .padding(.bottom, 4)
            
            Text(weatherData.tempAplitudeText)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.5)
                .padding(.bottom, 8)
                .font(Font.system(
                    size: 18,
                    weight: .light))
            
        }
        .frame(width: 140)
        .padding(Margins.standard)
        .background(background)
    }
}

#Preview {
    SmallDayWeatherCell(
        weatherData: Previews.dayShortData,
        selectedTime: 0)
}
