//
//  Stubs.swift
//  CityWeatherTests
//
//  Created by Michał Krupa on 12/02/2024.
//

import Foundation
import Moya

@testable import CityWeather
struct Stubs {
    
    typealias T = WeatherService.T
   
    func targetResponse(code: Int, responseFile: String) -> (T) -> Endpoint {
        return { (target: T) -> Endpoint in
            return Endpoint(
                url: target.path,
                sampleResponseClosure: {
                    .networkResponse(
                        code,
                        JSON(name:responseFile).data) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers)
        }
    }
    
    func service(for responseFile: String, code: Int) -> WeatherService {
        WeatherService(
            provider: MoyaProvider<T>(
                endpointClosure: targetResponse(
                    code: code,
                    responseFile: responseFile),
                stubClosure: { _ in .immediate })
        )
    }
}

struct JSON {
    let name: String
    var data: Data {
        let bundle = Bundle(for: WeatherModelTests.self)
        guard let path = bundle.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: path) else {
            return Data()
        }
        return data
    }
}
