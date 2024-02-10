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
    
    @State internal var iOrientation = UIDevice.current.orientation
    
    var body: some View {
        Group {
            if UIDevice().userInterfaceIdiom == .phone {
                iPhoneView
            } else {
                iPadView
            }
        }
        .onAppear() {
            setupAppOrientaionNotification()
        }
        .onChange(of: scenePhase) { phase in
            handleScenePhase(phase)
        }
    }
    
    private func setupAppOrientaionNotification() {
        NotificationCenter.default.addObserver(
            forName: UIDevice.orientationDidChangeNotification,
            object: nil,
            queue: .main) { _ in
                setDeviceOrientation()
            }
        setDeviceOrientation()
    }
    
    private func handleScenePhase(_ phase: ScenePhase) {
        if phase == .active {
            model.updateWeather()
        }
    }
    
    // TODO: Check flat orientation
    private func setDeviceOrientation() {
        iOrientation = UIDevice.current.orientation
    }
}
