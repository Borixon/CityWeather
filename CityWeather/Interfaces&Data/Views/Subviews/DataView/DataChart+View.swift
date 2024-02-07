//
//  DataChart+View.swift
//  CityWeather
//
//  Created by Michał Krupa on 07/02/2024.
//

import SwiftUI
import Charts

extension DataChart: View {
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Font.system(
                        size: 16,
                        weight: .medium))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            Chart {
                ForEach(
                    Array(data.enumerated()), id:\.offset) { i, entry in
                        BarMark(
                            x: .value("\(i)", i),
                            yStart: .value("s", start),
                            yEnd: .value("v", Int(entry.value)),
                            width: Marks.dimension)
                        .foregroundStyle(.white)
                        .annotation(
                            position: .bottom,
                            alignment: .center) {
                                Text(data[i].annotation)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(
                                        size: 12,
                                        weight: .light))
                            }
                            
                    }
                
            }
            .chartXAxis(.hidden)
            .chartYAxis { AxisMarks(values: yAxisValues) }
            .chartYScale(domain: [start, maxComputed])
            .padding(.horizontal, 8)
            .padding(.bottom, 24)
        }
        .background(Background.box)
    }
}

#Preview {
    DataChart(
        title: "Title",
        data: [DataValue(value: 1020, annotation: "os"),
               DataValue(value: 1000, annotation: "ph"),
               DataValue(value: 980, annotation: "hp")],
        start: 970)
}
