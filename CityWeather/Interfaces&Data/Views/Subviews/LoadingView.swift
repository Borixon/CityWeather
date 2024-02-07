//
//  LoadingView.swift
//  CityWeather
//
//  Created by Michał Krupa on 04/02/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView(label: {
            Text("loading")
                .foregroundStyle(.white)
        })
        .progressViewStyle(.circular)
        .tint(.white)
    }
}
