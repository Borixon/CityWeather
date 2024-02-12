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

final class WeatherModelTests: XCTestCase {

    // TODO: update - not rich yet
    @MainActor func testRichModel() throws {
        
        let service = Stubs().service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        XCTAssertNil(sut.data.weather)
        
        sut.updateWeather()
        
        XCTAssertNotNil(sut.data.weather)
        XCTAssertNotNil(sut.data.selectedCityData)
    }
    
    /**
     SelectedTime should not be nil for pads
     */
    @MainActor func testSelectedTimePad() throws {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            return
        }
        
        let service = Stubs().service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        sut.updateWeather()
        
        XCTAssertNotNil(sut.data.selectedTime)
        XCTAssertNotNil(sut.data.selectedCityData)
    }
    
    /**
     Selecting time on phones should always return some value,
     in this case it shoud be earliest returned date
     */
    @MainActor func testSelectedTimePhone() throws {
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return
        }
        
        let service = Stubs().service(for: "weatherParis", code: 200)
        let sut = WeatherModel(webService: service)
        
        sut.updateWeather()
        sut.didSelectDate(0)
        
        XCTAssertNotNil(sut.data.selectedTime)
        XCTAssertNotNil(sut.data.selectedCityData)
    }
    
    @MainActor func testLessData() throws {
        let service = Stubs().service(for: "waetherParis20DataPoints", code: 200)
        let sut = WeatherModel(webService: service)
        
        sut.updateWeather()
        
        XCTAssertEqual(sut.data.weather?.daysData.count, 20)
    }
}
