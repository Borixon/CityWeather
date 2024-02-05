//
//  TitleSubtitleView.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import SwiftUI

struct TitleSubtitleView: View {

    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(Font.system(
                    size: 18,
                    weight: .light))
            Text(subtitle)
                .font(Font.system(
                    size: 12,
                    weight: .light))
        }
    }
}

