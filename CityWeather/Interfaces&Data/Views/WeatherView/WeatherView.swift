//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift

struct WeatherView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject internal var model: WeatherModel
    @EnvironmentObject internal var router: AppRouter
    
    var body: some View {
        Group {
            if UIDevice().userInterfaceIdiom == .phone {
                iPhoneView
            } else {
                iPadView
            }
        }
        .onChange(of: scenePhase) { phase in
            handleScenePhase(phase)
        }
    }
    
    private func handleScenePhase(_ phase: ScenePhase) {
        if phase == .active {
            model.updateWeather()
        }
    }
}
