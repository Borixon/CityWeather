//
//  Marks.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import Foundation
import Charts
import SwiftUI

struct Marks {
    static var dimension: MarkDimension {
        let small = UIDevice.current.userInterfaceIdiom == .phone
        return MarkDimension(floatLiteral: small ? 6 : 16)
    }
}
