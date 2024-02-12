//
//  Repository.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift
import SwiftUI

@MainActor
final class WeatherModel: ObservableObject {
    
    private let bag: DisposeBag = .init()
    private let city: String = "Paris"
    private let webService: WeatherService
    private let repository: WeatherRepository
    
    private let orientObserver: OrientationObserver = .init()
    
    @Published var selectedTime: TimeInterval? = nil
    @Published var isLoading: Bool = false
    @Published var weather: DBWeather? = nil
    @Published var isLandscape: Bool? = nil
    
    init(webService: WeatherService = .init(),
         repository: WeatherRepository = .init()) {
        self.webService = webService
        self.repository = repository
        
        orientObserver
            .publisher
            .filter({ $0 != .faceUp && $0 != .faceDown })
            .subscribe(onNext: {
                self.isLandscape = $0 == .landscapeRight || $0 == .landscapeLeft
            })
            .disposed(by: bag)
    }
    
    var temperatureDetails: [MinMax<Int>] {
        weather?.temperatures24h(selectedTime) ?? []
    }
    
    var cloudsDetails: [DataValue<Int>] {
        weather?.clouds24h(selectedTime) ?? []
    }
    
    var selectedCityData: CityHeaderData? {
        let time = getCorrespondingTime(selectedTime)
        return weather?.cityData(for: time)
    }
    
    var visibilityDetails: [DataValue<Int>] {
        weather?.visibility24h(selectedTime) ?? []
    }
    
    var visibilityStep: Int {
        Int(Double(visibilityDetails.map { $0.value }.max() ?? 0) / 4.0)
    }
    
    var precipationDetails: [DataValue<Int>] {
        weather?.precipation24h(selectedTime) ?? []
    }
    
    var pressureMinimum: Int {
        (pressureDetails.map { $0.value }.min() ?? 0) - 5
    }
    
    var pressureDetails: [DataValue<Int>] {
        weather?.pressure24h(selectedTime) ?? []
    }
    
    
    func updateWeather() {
        isLoading = true
        resolveWeather(for: city)
            .subscribe(onNext: { [unowned self] data in
                self.handleDataReceive(data)
                
            }, onError: {  [unowned self] _ in
                self.handleDataReceive(nil)
            })
            .disposed(by: bag)
    }
    
    func didSelectDate(_ date: TimeInterval) {
        selectedTime = date
    }
    
    
    private func getCorrespondingTime(_ time: TimeInterval?) -> TimeInterval {
        guard let time = time,
              let firstDay = weather?.earliestTime else {
            return 0
        }
        let days = firstDay.daysBetween(date: time)
        return firstDay + (Double(days) * 24.0 * 60.0 * 60.0)
    }
    
    private func resolveWeather(for city: String) -> Observable<DBWeather> {
        return Observable.create { [unowned self] observer in
            self.webService.weather(for: city)
                .flatMap { data -> Observable<Void> in
                    return self.repository.save(data)
                }
                .flatMap { _ -> Observable<DBWeather> in
                    return self.repository.retrive()
                }
                .subscribe(
                    onNext: { data in
                        observer.onNext(data)
                        observer.onCompleted()
                        
                    }, onError: { error in
                        observer.onError(error)
                    })
                .disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
    private func handleDataReceive(_ data: DBWeather?) {
        weather = data
        isLoading = false
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            selectedTime = weather?.earliestTime
        }
    }
}
