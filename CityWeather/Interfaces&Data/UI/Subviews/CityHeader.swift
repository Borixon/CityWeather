//
//  CityHeader.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import SwiftUI

struct CityHeader: View {
    
    var viewData: CityHeaderData
    
    var body: some View {
        VStack (alignment: .center) {
            Text(viewData.city)
                .padding(.top, 16)
                .padding(.horizontal, 32)
                .font(Font.system(
                    size: 38,
                    weight: .light))
            
            if let descritpion = viewData.description {
                Text(descritpion)
                    .padding(.top, 0)
                    .padding(.bottom, 4)
            }
            
            Text(viewData.temperatureText)
                .padding(.horizontal, 32)
                .font(Font.system(
                    size: 28,
                    weight: .light))
            
            Text(viewData.sensedTempText)
                .padding(.top, 8)
                .padding(.horizontal, 32)
                .font(Font.system(
                    size: 18,
                    weight: .light))
            
            HStack(spacing: 32) {
                VStack {
                    Text(viewData.sunriseText)
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)
                }
                VStack {
                    Text(viewData.sunsetText)
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)
                }
            }
            .padding(.init(
                top: 8,
                leading: 32,
                bottom: 16,
                trailing: 32))
        }
        .frame(maxWidth: .infinity)
        .background(Background.standard)
    }
}

#Preview() {
    CityHeader(viewData: .init(
        city: "Kraków",
        castDescription: "Cloudy day",
        temperature: 6.9,
        sensedTemperature: 5.6,
        sunrise: 1731077,
        sunset: 1779737))
}
