//
//  SpecificDayWeatherCell.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import SwiftUI

struct DayWeatherCell: View {
    
    let weatherData: DayShortData
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            TitleSubtitleView(
                title: weatherData.day.capitalized,
                subtitle: weatherData.date)
            
            TitleSubtitleView(
                title: weatherData.pressureText,
                subtitle: NSLocalizedString("avgPress", comment: ""))
            
            TitleSubtitleView(
                title: weatherData.tempAplitudeText,
                subtitle: NSLocalizedString("temperature", comment: ""))
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(Margins.standard)
        .background(Background.box)
    }
}
