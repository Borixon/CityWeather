//
//  GetWeatherForName.swift
//  PixiForecast
//
//  Created by Michał Krupa on 13/02/2024.
//

import Foundation
import RxSwift

struct GetWeatherForName: UseCaseProtocol {
    
    typealias D = NSWeather
    
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func invoke() -> Observable<NSWeather> {
        return Observable.create {
            $0.on(.error(AppError.notImplemented))
            return Disposables.create()
        }
    }
}
