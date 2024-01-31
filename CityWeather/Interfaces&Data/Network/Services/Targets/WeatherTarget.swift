//
//  WeatherTarget.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Moya
import Foundation

enum WeatherTarget {
    case weatherFor(_ params: [String:Any])
}

extension WeatherTarget: TargetType {
    var baseURL: URL {
        API.baseUrl
    }
    
    var path: String {
        switch self {
        case .weatherFor:
            "data/2.5/forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weatherFor:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .weatherFor(let params):
            .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
