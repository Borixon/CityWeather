//
//  DBCity.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import Foundation
import RealmSwift

@objcMembers final class DBCity: Object {
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var sunrise: TimeInterval = 0
    dynamic var sunset: TimeInterval = 0
    
    public override static func primaryKey() -> String? { "id" }
    
    override init() { }
    
    init(_ nsCity: NSCity) {
        self.id = nsCity.name
        self.name = nsCity.name
        self.sunset = nsCity.sunset
        self.sunrise = nsCity.sunrise
    }
}
