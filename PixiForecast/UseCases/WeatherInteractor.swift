//
//  WeatherInteractor.swift
//  PixiForecast
//
//  Created by Michał Krupa on 15/02/2024.
//

import RxSwift
import CoreLocation

class WeatherInteractor {
    
    private let webService: any WeatherServiceAlias
    private let repository: WeatherRepository
    private let locationManager: LocationManager
    private let bag = DisposeBag()
    
    init(webService: any WeatherServiceAlias = WeatherService(),
         repository: WeatherRepository = .init(),
         locationManager: LocationManager = .init()) {
        self.webService = webService
        self.repository = repository
        self.locationManager = locationManager
    }
    
    func weather(for name: String) { }
    
    func weatherForCurrentLocation() -> Observable<DBWeather> {
        locationManager
            .requestLocation()
            .flatMap { [unowned self] data -> Observable<DBWeather> in
                self.downloadWeather(for: data.coordinate)
            }
    }
    
    func weather() {
        // Should we getWeather from service for given location source?
        // If dbweather == nil -> YES
        // If latestUpdate.isLate -> YES
            // Else -> display latest DBWeather
        // What source for location
            // If CurrentLocation -> proceed
                // Do we have location permission determined?
                    // If no -> ask for permission and proceed
                // Do we have permission granted?
                    // Ye -> getWeatherFor location
                    // No -> display how sorry u are
            // Else if we look for city -> Proceed
                // If shouldUpdate -> download and save new weather
                // Else -> display DBWeather (if available, but it should be)
        
        
    }
    
    private func saveWeatherAndEmmit(
        observable: Observable<NSWeather>,
        observer: AnyObserver<DBWeather>) -> Disposable {
            
        observable
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
    }
    
    private func downloadWeather(for cityName: String) -> Observable<DBWeather> {
        return Observable.create { [unowned self] observer in
            self.saveWeatherAndEmmit(
                observable: self.webService.weather(for: cityName),
                observer: observer)
            .disposed(by: self.bag)
            return Disposables.create()
        }
    }
    
    private func downloadWeather(for coords: CLLocationCoordinate2D) -> Observable<DBWeather> {
        return Observable.create { [unowned self] observer in
            self.saveWeatherAndEmmit(
                observable: self.webService.weather(for: coords),
                observer: observer)
            .disposed(by: self.bag)
            return Disposables.create()
        }
    }
}
