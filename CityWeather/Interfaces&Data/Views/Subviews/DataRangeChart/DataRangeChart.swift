//
//  DataRangeChart.swift
//  CityWeather
//
//  Created by Michał Krupa on 07/02/2024.
//

import SwiftUI
import Charts

struct DataRangeChart<T: Strideable & Plottable> {
    
    var title: String
    var data: Array<MinMax<T>>
    var margin: UInt8 = 1
    var step: Int = 1
    
    var from: Int {
        data.map { $0.min }.min() as? Int ?? 0
    }
    
    var to: Int {
        data.map { $0.max }.max() as? Int ?? 0
    }
    
    var yAxisValues: [Int] {
        let step = self.step < 1 ? 1 : self.step
        return stride(
            from: from - Int(margin),
            to: to + Int(margin),
            by: step).map { $0 }
    }
}
