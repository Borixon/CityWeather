//
//  Repository.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import SwiftUI

final class WeatherPresenter: ObservableObject {
    
    internal let bag: DisposeBag = .init()
      
    private let interactor: WeatherInteractor
    
    @Published var orientation: AppOrientation? = nil
    @Published var isLoading: Bool = true
    @Published var isLandscape: Bool? = nil
    @Published var data: WeatherModelData = .init()
    
    init(interactor: WeatherInteractor = .init(webService: MockWeatherService())) {
        self.interactor = interactor
        setupOrientationObserver()
    }
    
    
    func updateWeather() {
        isLoading = true
        interactor
            .weatherForCurrentLocation()
            .subscribe(onNext: { data in
                self.isLoading = false
                self.data = .init(weather: data)
            }, onError: { _ in
                self.isLoading = false
            })
            .disposed(by: bag)
    }
    
    func didSelectDate(_ date: TimeInterval) {
        
    }
    
    
    private func setupOrientationObserver() {
        OrientationObserver
            .shared
            .subscribeToOrientationUpdates(self)
    }
    
    private func getWeather(for city: String) -> Observable<DBWeather> {
        return Observable.create { _ in
            return Disposables.create()
        }
    }
    
    private func setupWeatherData(_ weather: DBWeather?) {
        
        
    }
    
    /*
    @Environment(\.scenePhase) var scenePhase
    private func handleScenePhase(_ phase: ScenePhase) {
        guard
            // latestUpdate + 1min < .now
            phase == .active else {
            return
        }
        updateWeather()
    }
    */
}

extension WeatherPresenter: OrientationObserverProtocol {
    func orientationDidChange(to orientation: AppOrientation?) {
        self.orientation = orientation
    }
}
