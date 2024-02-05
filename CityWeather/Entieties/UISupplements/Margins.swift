//
//  Margins.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation
import SwiftUI

struct Margins {
    static let standard: EdgeInsets = .init(
        top: 8,
        leading: 16,
        bottom: 8,
        trailing: 16)
}

struct Background {
    static var standard: some View { 
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.init(white: 0.95))
    }
}
