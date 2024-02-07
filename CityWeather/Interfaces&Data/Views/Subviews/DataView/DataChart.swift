//
//  DataChart.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import SwiftUI

struct DataChart {
    
    var title: String
    var data: Array<DataValue<Int>>
    var max: Int? = nil
    var start: Int = 0
    var margin: Int = 5
    var step: Int = 5
    
    var maxComputed: Int {
        data.map{ $0.value }.max() ?? 0
    }
    
    var yAxisValues: [Int] {
        let to = max != nil ? max! : maxComputed
        let margin = self.margin < 0 ? 1 : self.margin
        let step = self.step < 1 ? 1 : self.step
        
        return stride(
            from: start,
            to: to + margin,
            by: step).map { $0 }
    }
}
