//
//  CityWeatherTests.swift
//  CityWeatherTests
//
//  Created by Michał Krupa on 31/01/2024.
//

import Moya
import RealmSwift
import XCTest

@testable import CityWeather


final class ModelTests: XCTestCase {

    typealias T = WeatherService.T
   
    // TODO: update - not rich yet
    @MainActor func testRichModel() throws {
        
        let service = service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        XCTAssertNil(sut.weather)
        
        sut.updateWeather()
        
        XCTAssertNotNil(sut.weather)
        XCTAssertNotNil(sut.selectedCityData)
    }
    
    /**
     SelectedTime should not be nil for pads
     */
    @MainActor func testSelectedTimePad() throws {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            return
        }
        
        let service = service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        sut.updateWeather()
        
        XCTAssertNotNil(sut.selectedTime)
        XCTAssertNotNil(sut.selectedCityData)
    }
    
    /**
     Selecting time on phones should always return some value,
     in this case it shoud be earliest returned date
     */
    @MainActor func testSelectedTimePhone() throws {
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return
        }
        
        let service = service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        sut.updateWeather()
        sut.didSelectDate(0)
        
        XCTAssertNotNil(sut.selectedTime)
        XCTAssertNotNil(sut.selectedCityData)
    }
    
    // TODO: move to utils
    private func targetResponse(code: Int, responseFile: String) -> (ModelTests.T) -> Endpoint{
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
    
    private func service(for responseFile: String, code: Int) -> WeatherService {
        WeatherService(
            provider: MoyaProvider<T>(
                endpointClosure: targetResponse(
                    code: code,
                    responseFile: responseFile),
                stubClosure: { _ in .immediate })
        )
    }
}

//TODO: Move to utils?
struct JSON {
    
    let name: String
    var data: Data {
        let bundle = Bundle(for: ModelTests.self)
        guard let path = bundle.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: path) else {
            return Data()
        }
        return data
    }
}
