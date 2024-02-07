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
            NotificationCenter.default.addObserver(
                forName: UIDevice.orientationDidChangeNotification,
                object: nil,
                queue: .main) { _ in
                    setDeviceOrientation()
                }
            setDeviceOrientation()
            model.onStart()
        }
    }
    
    private func setDeviceOrientation() {
        iOrientation = UIDevice.current.orientation
    }
}
