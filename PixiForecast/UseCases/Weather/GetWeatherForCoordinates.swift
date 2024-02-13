//
//  GetWeatherForCoordinates.swift
//  PixiForecast
//
//  Created by Michał Krupa on 13/02/2024.
//

import RxSwift
import CoreLocation

struct GetWeatherForCoordinates: UseCaseProtocol {
    
    typealias D = NSWeather
    
    private let coordinates: CLLocationCoordinate2D
    
    init(_ coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
    func invoke() -> Observable<NSWeather> {
        return Observable.create {
            $0.on(.error(AppError.notImplemented))
            return Disposables.create()
        }
    }
}
