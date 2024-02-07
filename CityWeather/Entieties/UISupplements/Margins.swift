//
//  Margins.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation
import SwiftUI
import Charts

struct Margins {
    static let standard: EdgeInsets = .init(
        top: 8,
        leading: 16,
        bottom: 8,
        trailing: 16)
}

struct Background {
    static var box: some View { 
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color("BoxColor"))
    }
    
    static var selectedBox: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color("BoxColorSelected"))
    }
}

struct Marks {
    static var dimension: MarkDimension {
        let small = UIDevice.current.userInterfaceIdiom == .phone
        return MarkDimension(floatLiteral: small ? 6 : 16)
    }
}
