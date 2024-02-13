//
//  DBObject.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import Foundation
import RealmSwift

protocol DBObject: Codable {
    associatedtype R: Object
    var dbModel: R { get }
}
