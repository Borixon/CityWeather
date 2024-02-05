//
//  WeatherTarget.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Moya
import Foundation

enum WeatherTarget {
    case weather(_ params: [String:Any])
}

extension WeatherTarget: TargetType {
    var baseURL: URL {
        API.baseUrl
    }
    
    var path: String {
        switch self {
        case .weather:
            "data/2.5/forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weather:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .weather(let params):
            .requestParameters(
                parameters: obligatoryParams(with: params),
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    private func obligatoryParams(with current: [String:Any]) -> [String:Any] {
        var params = current
        params["units"] = AppData.unitSystem.rawValue
        params["appid"] = API.key
        return params
    }
}
