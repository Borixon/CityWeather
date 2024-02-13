//
//  ResponseParser.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation
import RxSwift

struct ResponseParser {
    func parseAndEmmit<D:Decodable>(data: Data, observer: AnyObserver<D>) {
        do {
            let obj = try JSONDecoder()
                .decode(D.self, from: data)
            observer.onNext(obj)
        } catch {
            observer.onError(error)
        }
    }
}
