//
//  Background.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import Foundation
import SwiftUI

struct Background {
    static var box: some View {
        RoundedRectangle(cornerRadius: 0)
            .foregroundColor(Color("BoxColor"))
    }
    
    static var selectedBox: some View {
        RoundedRectangle(cornerRadius: 0)
            .foregroundColor(Color("BoxColorSelected"))
    }
}
