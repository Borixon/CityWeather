//
//  LocationManager.swift
//  PixiForecast
//
//  Created by Michał Krupa on 13/02/2024.
//

import CoreLocation
import RxSwift

class LocationManager: NSObject {
    
    private let manager: CLLocationManager
    private let publisher = PublishSubject<CLLocation>()
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
    }
    
    func requestLocation() -> Observable<CLLocation> {
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.requestLocation()
        return publisher.take(1)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            if let first = locations.first {
                publisher.onNext(first)
            } else {
                publisher.onError(AppError.notImplemented)
            }
            manager.stopUpdatingLocation()
            manager.delegate = nil
    }
    
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager) {
            print("Auth status \(manager.authorizationStatus)")
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error) {
            publisher.onError(error)
    }
}
