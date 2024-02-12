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
    
    @Published var isLoading: Bool = false
    @Published var isLandscape: Bool? = nil
    @Published var data: WeatherModelData = .init()
    
    init(webService: WeatherService = .init(),
         repository: WeatherRepository = .init()) {
        self.webService = webService
        self.repository = repository
        setupObserver()
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
        data.selectedTime = date
    }
    
    
    private func setupObserver() {
        orientObserver
            .publisher
            .filter({ $0 != .faceUp && $0 != .faceDown })
            .subscribe(onNext: {
                self.isLandscape = $0 == .landscapeRight || $0 == .landscapeLeft
            })
            .disposed(by: bag)
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
    
    private func handleDataReceive(_ weather: DBWeather?) {
        data.update(weather)
        isLoading = false
    }
}
